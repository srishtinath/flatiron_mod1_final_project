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
        :bg_fill => false,
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

    print_pic('temp/combine.png')
end



display_two(Pokemon.first,Pokemon.third)