require 'chunky_png'

class Frame

  attr_reader :frame_data, :file_path, :height, :width

  def initialize(image_path=nil)
    @frame_data=ChunkyPNG::Image.from_file(image_path) if image_path
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

  def get_pixel_value_rgba(x,y)
    #convert from Fixnum to rgba values
    @frame_data[x,y].to_s(16).scan(/../).map{|hex_segment| hex_segment.to_i(16)}
  end

  #last value is set to full, 255 (opacity)
  def set_pixel_value_rgba(x,y,r,g,b,opacity=255)
    @frame_data[x,y]=ChunkyPNG::Color.rgba(r, g, b, opacity)
  end

  def save
    @frame_data.save(@file_path)
  end

end
