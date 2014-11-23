require_relative "tools"
require 'chunky_png'
require 'byebug'

class Frame

  attr_reader :frame_data, :file_path, :height, :width

  def initialize(image_path=nil)
    if image_path
      if !File.exist?(image_path)
        raise ArgumentError.new("File does not exist!")  
      end
      @frame_data=ChunkyPNG::Image.from_file(image_path)
    end

    @height = @frame_data.height
    @width = @frame_data.width
    @file_path = image_path
  end

  def greyscale
    for y in 0..@height-1
      for x in 0..@width-1
        r,g,b = get_pixel_value_rgba(x,y)
        if r!=nil && g!=nil && b!=nil
           set_pixel_value_rgba(x,y,(r+g+b)/3,(r+g+b)/3,(r+g+b)/3)
        end
      end
    end
  end

  def invert_color
    max_rgb_val = 255
    for y in 0..@height-1
      for x in 0..@width-1
        r,g,b = get_pixel_value_rgba(x,y)
        if r!=nil && g!=nil && b!=nil
           set_pixel_value_rgba(x,y, max_rgb_val - r, max_rgb_val - g, max_rgb_val - b)
        end
      end
    end
  end

  def apply_sobel_filter
    #the filter needs to be n*n dimensions
    sobel_filter = [[-1,0,1],[-2,0,2],[-1,0,1]]
    flipped_filter = Tools.flip_filter(sobel_filter)

    sum_r = sum_g = sum_b = 0
    for y in 0..@height-1
      for x in 0..@width-1

        puts "x: #{x}, y: #{y}"
        for j in 0..flipped_filter.size-1 
          for i in 0..flipped_filter.size-1
            puts "i: #{i}, j: #{j}"
            r,g,b = get_pixel_value_rgba(x-(i+1),y-(j+1))
            if r != 0
              byebug
            end
            if r!=nil && g!=nil && b!=nil
              puts "r: #{r}, g: #{g}, b: #{b}"
              r = r * flipped_filter[i][j]
              g = g * flipped_filter[i][j]
              b = b * flipped_filter[i][j]
              puts "sum_r: #{sum_r}, sum_g: #{sum_g}, sum_b: #{sum_b}"
              sum_r = sum_r + r
              sum_g = sum_g + g
              sum_b = sum_b + b
            end
          end
        end      
        set_pixel_value_rgba(x,y, sum_r, sum_g, sum_b)

      end
    end
  end

  def get_pixel_value_rgba(x,y)
    #convert from Fixnum to rgba values
    begin
      @frame_data[x,y].to_s(16).scan(/../).map{|hex_segment| hex_segment.to_i(16)}
    rescue ChunkyPNG::OutOfBounds
      [0,0,0]
    end
  end

  #last value is set to full, 255 (opacity)
  def set_pixel_value_rgba(x,y,r,g,b,opacity=255)
    begin
      @frame_data[x,y]=ChunkyPNG::Color.rgba(r, g, b, opacity)
    rescue ChunkyPNG::OutOfBounds
      puts "cant set at #{x},#{y}!"
    end
  end

  def save(filename_extension=nil)
    file_name = @file_path.split(".")[0]
    file_extension = @file_path.split(".")[1]
    @frame_data.save(file_name+filename_extension+"."+file_extension)
  end

end
