require_relative "video_ruby/version"
require_relative "video_ruby/image_processor"
require_relative "video_ruby/frame"

module VideoRuby

  def self.extract_frames(video_location)
    reconstructed_clip = nil
    extracted_audio = nil
    final_clip = nil
    image_processor = nil

    #Break and Build the Video
    #clip=Video.new(video_location)

    #puts "Extracting frames. This may take a while..."
    #clip.extract_frames

    #image_processor = ImageProcessor.new("frames/")
    #image_processor.load_frames

    #puts "Processing Image(s)... This will take a while..."
    #image_processor.greyscale(Frame.new("frames/frame_000092.png"))

    # puts "Extracting audio..."
    # extracted_audio = clip.extract_audio

    # puts "Combining Frames"
    # reconstructed_clip = VideoConversionTools.combine_frames(clip.video_file_extension,
    #  clip.fps,
    #  clip.video_bitrate,
    #  'frames')

    # puts "Add audio to the new clip"
    # final_clip = VideoConversionTools.add_audio_track(reconstructed_clip.file_path, extracted_audio.file_path)

    # puts "Done!"
  end 

  def self.greyscale_image(image_path)
    absolute_path = File.absolute_path(image_path)
    ImageProcessor.new.greyscale(Frame.new(absolute_path))
  end

  def self.invert_image_color(image_path)
    absolute_path = File.absolute_path(image_path)
    ImageProcessor.new.invert_color(Frame.new(absolute_path))
  end

  def self.apply_sobel_filter(image_path)
    absolute_path = File.absolute_path(image_path)
    ImageProcessor.new.apply_sobel_filter(Frame.new(absolute_path))   
  end

end

image_path = File.absolute_path("lena.png") #initialize file reading here?
VideoRuby.apply_sobel_filter(image_path)