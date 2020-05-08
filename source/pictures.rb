require_relative '../config/environment.rb'
def download_image(pokemon,front=true)
    front ? f_or_b = pokemon.front_img_url : f_or_b = pokemon.back_img_url
    temp = Down.download(f_or_b)
    temp.path
end


def print_pic(path)
    options = {      
        :limit_x => 1.0,
        :limit_y => 0.0,
        :center_x => false,
        :center_y => false,
        :bg => "black",
        :bg_fill => true,
        :resolution => "low"
    }
    Catpix.print_image(path,options)
end

def display_two(item1,item2)
    #crop(x, y, width, height)
    right = Magick::ImageList.new(
        download_image(item2,true))
        .crop(10,30,50,50)
    left = Magick::ImageList.new(
        download_image(item1,false))
        .crop(30,10,50,50)
        right.write('temp/r.png')
        left.write('temp/l.png')
    image_list = Magick::ImageList.new('temp/l.png','temp/r.png')
    image_list.append(false).write('temp/combine.png')

    print_pic('temp/combine.png').display
end

def display_one(pokemon)
    portrait = Magick::ImageList.new(
        download_image(pokemon,true))
        .resize_to_fit(60,60)
        .crop(-50,-50,120,120)
    portrait.write('temp/combine.png')
    print_pic('temp/combine.png').display

end

def display_trainer_and_pokemon(pokemon)
    left = Magick::ImageList.new('assets/trainerBack.png')
        .resize_to_fit(40,40)
        .crop(0,-10,100,100)
    right = Magick::ImageList.new(
        download_image(pokemon,true))
        .resize_to_fit(50,50)
        .crop(-20,10,75,50)
        right.write('temp/r.png')
        left.write('temp/l.png')
        image_list = Magick::ImageList.new('temp/l.png','temp/r.png')
        image_list.append(false).write('temp/combine.png')
    
        print_pic('temp/combine.png').display
end

def display_pokemon(pokemon,format,options = {:x=>20,:y=>20,:width=>50,:height=>50,:resizeHeightWidth=>25})
    if format=="grid"
        grid = true
    elsif format == "row"
        grid = false
    end
    image_list = Magick::ImageList.new()
    count = (pokemon.length.to_f/2).ceil()
    if pokemon.length == 1
        Magick::ImageList.new(pokemon[0])
        .crop(options[:x],options[:y],options[:width],options[:height])
        .resize_to_fit(options[:resizeHeightWidth],options[:resizeHeightWidth])
        .write("temp/0-1.png")
        image_list.concat(Magick::Image.read("temp/0-1.png"))
    else    
        count.times do |i|
            index = i*2
            Magick::ImageList.new(pokemon[index])
                .crop(options[:x],options[:y],options[:width],options[:height])
                .resize_to_fit(options[:resizeHeightWidth],options[:resizeHeightWidth])
                .write("temp/#{i}-1.png")
                if(pokemon[index+1])
                    Magick::ImageList.new(pokemon[index+1])
                        .crop(options[:x],options[:y],options[:width],options[:height])
                        .resize_to_fit(options[:resizeHeightWidth],options[:resizeHeightWidth])
                        .write("temp/#{i}-2.png")
                else
                    Magick::ImageList.new("assets/black.png")
                    .crop(options[:x],options[:y],options[:width],options[:height])
                    .resize_to_fit(options[:resizeHeightWidth],options[:resizeHeightWidth])
                    .write("temp/#{i}-2.png")                    
                end
                Magick::ImageList.new("temp/#{i}-1.png","temp/#{i}-2.png")
                .append(grid)
                .write("temp/#{i}-1and2.png")
            image_list.concat(Magick::Image.read("temp/#{i}-1and2.png"))
        end
    end
    image_list.append(false).write('temp/combine.png')
    print_pic('temp/combine.png').display
end

def scroll_through_pokemon(pokemon)
    image_list = Magick::ImageList.new()
    count = (pokemon.length.to_f/2).ceil()
    count.times do |i|
        image_list.concat(Magick::Image.read(pokemon[i*2]))
        image_list.concat(Magick::Image.read(pokemon[(i*2)+1]))
    end
    image_list.append(true).write('temp/combine.png')
    print_pic('temp/combine.png').display
end

def display_starters
    scroll_through_pokemon(get_starters('highres'))
    display_pokemon(get_starters('lowres'),"row",{:x=>30,:y=>20,:width=>250,:height=>250,:resizeHeightWidth=>50})
end

def get_starters(res)
    starters=[ 
        bulb = "assets/#{res}/bulbasaur.png",
        char = "assets/#{res}/charmander.png",
        squirt = "assets/#{res}/squirtle.png",
        pika = "assets/#{res}/pikachu.png",
    ]
end

def get_pokemon_from_caught(pokeCaughtObj)
    pokeArray = []
    pokeCaughtObj.each do |i|
        pokeArray<<(i.pokemon)
    end
    pokeArray
end

def view_caught_pokemon(caughtPokemon)
    urls = []
    pokemon = get_pokemon_from_caught(caughtPokemon)
    pokemon.length.times do |i|
        urls<<download_image(pokemon[i])
    end
    display_pokemon(urls,'grid')
end
