require_relative 'config/environment.rb'
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

def display_trainer_and_pokemon(trainer,pokemon)
    left = Magick::ImageList.new(
        download_image(trainer,false))
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

def display_pokemon(pokemon,format)
    if format=="grid"
        grid = true
    elsif format == "row"
        grid = false
    end
    image_list = Magick::ImageList.new()
    count = (pokemon.length.to_f/2).ceil()
    count.times do |i|
        index = i*2
        Magick::ImageList.new(pokemon[index])
        .crop(20,20,50,50)
        .resize_to_fit(25,25)
        .write("temp/#{i}-1.png")
        Magick::ImageList.new(pokemon[index+1])
        .crop(20,20,50,50)
        .resize_to_fit(25,25)
        .write("temp/#{i}-2.png")
        Magick::ImageList.new("temp/#{i}-1.png","temp/#{i}-2.png")
            .append(grid)
            .write("temp/#{i}-1and2.png")
        image_list.concat(Magick::Image.read("temp/#{i}-1and2.png"))
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
    bulb = download_image(Pokemon.find_by(name:"bulbasaur"))
    char = download_image(Pokemon.find_by(name:"charmander"))
    squirt = download_image(Pokemon.find_by(name:"squirtle"))
    pika = download_image(Pokemon.find_by(name:"pikachu"))
    pika2 = download_image(Pokemon.find_by(name:"pikachu"))
    pika3 = download_image(Pokemon.find_by(name:"pikachu"))

    display_pokemon([bulb,char,squirt,pika],"row")
end


