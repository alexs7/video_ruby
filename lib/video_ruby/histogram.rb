require "video_ruby/image_processor"

class Histogram < ImageProcessor

	def initialize(frames_dir)
		super frames_dir
	end

	def foo(image_name)
		img=load_image(image_name)
    img.pixel_color(1,1, "rgba(400, 256, 255, 0.0)")
    img.write('output.png')
    return #REMOVE
		greyscale_image(img)
		save_image('output.png',img)
	end

end
