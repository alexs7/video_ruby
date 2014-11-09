require 'debugger'
require 'json'

class VideoDataParser

  attr_reader :data, :video_stream_index, :audio_stream_index

  def initialize(video_path)
    avprobe_json_data = `avprobe -loglevel panic -show_streams -of 'json' '#{ video_path }'`
    @data = JSON.parse(avprobe_json_data)
    @data["streams"].each do |stream|
      @video_stream_index = stream["index"] if stream["codec_name"] == "h264" || stream["codec_name"] == "mpeg4"
      @audio_stream_index = stream["index"] if stream["codec_name"] == "aac"
    end
  end

  def fps
    @data["streams"][@video_stream_index]["avg_frame_rate"][0..1]
  end

  def video_bitrate
    v_bitrate = @data["streams"][@video_stream_index]["bit_rate"]
    v_bitrate ? @data["streams"][@video_stream_index]["bit_rate"].split('.')[0] : nil
  end

  def audio_codec
    @data["streams"][@audio_stream_index]["codec_name"] if @data["streams"][1] #if the video has audio
  end

  def video_codec
    @data["streams"][@video_stream_index]["codec_name"]
  end

	# def self.get_frames_count(frames_dir)
	# 	Dir[frames_dir+"/frame*.png"].count
	# end

	# def self.greyscale_all_frames_threaded(frames_dir,output_dir)
	# 	number_of_frames = get_frames_count(frames_dir)
	# 	img_processor = ImageProcessor.new(frames_dir)
	# 	create_dir(output_dir)
	# 	greyscale_frames_threads = []

	# 	for frame_index in 1..2
	# 		greyscale_frames_threads << Thread.new(frame_index) { |frame_number|
	# 			img_processor.load_image(frames_dir+"/frame_%04d.png"%+frame_number)
	# 			img_processor.greyscale_image
	# 			img_processor.save_image(output_dir,"frame_%04d"%+frame_number)
	# 		}
	# 	end

	# 	greyscale_frames_threads.each { |thread| thread.join } #this blocks the main thread
	# end

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

	# def self.create_dir(dir_name)
	# 	Dir::mkdir(dir_name) if !File.directory?(dir_name)
	# end

 #  def self.check_if_file_exists?(output_name)
 #    raise IOError, "Dir/File #{output_name} already exists!" if File.exists?(output_name)
 #  end

end
