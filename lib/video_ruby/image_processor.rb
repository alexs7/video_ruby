require 'facter'
require "video_ruby/frame"

class ImageProcessor

	attr_reader	:frames_location, :all_frames

	def initialize(frames_dir)
		if !File.directory?(frames_dir) || Dir["frames/*"].empty?
			raise ArgumentError.new("You must provide a non-empty frames dir!")  
		end

		@all_frames = []
		@frames_location = frames_dir
	end

	def load_frames # returns an array ChunkyPNG Objects
		all_frames_files = []

		Dir.glob(@frames_location+"/*.png") do |frame_file|
			all_frames_files << frame_file
		end
		
		all_frames_files.sort.each do |frame_file|
			@all_frames << Frame.new(frame_file)
		end

		@all_frames
	end

	def greyscale(frame=nil)
    return frame.greyscale if frame
		@all_frames.each do |frame|
			frame.greyscale
			frame.save
		end
	end

  def invert_color(frame=nil)
    return frame.invert_color if frame
    @all_frames.each do |frame|
      frame.invert_color
      frame.save
    end
  end

	# def self.greyscale_all_frames_processes(frames_dir,output_dir)
	# 	number_of_frames = get_frames_count(frames_dir)
	# 	img_processor = ImageProcessor.new(frames_dir)
	# 	create_dir(output_dir)
	# 	#will return the number of processors (including any HT techs etc etc)
	# 	no_processors = Facter.processorcount.to_i

	# 	(1..number_of_frames).step(no_processors) do |frame_index|
	# 		for i in 0..(no_processors-1)
	# 			pid = Process.fork do
	# 				frame_number = frame_index+i
	# 				img_processor.load_image(frames_dir+"/frame_%04d.png"%+frame_number)
	# 				img_processor.greyscale_image
	# 				img_processor.save_image_in_dir(output_dir,"frame_%04d"%+frame_number)
	# 			end
	# 		end
	# 		wait_for_current_processes_to_finish
	# 	end
	# end

	# def self.wait_for_current_processes_to_finish
	# 	Process.waitall
	# end

end