require "video_ruby/version"
require "video_ruby/video"

module VideoRuby

  def self.extract_frames(video_location)
    reconstructed_clip = nil
    extracted_audio = nil
    final_clip = nil
    image_processor = nil

    #Break and Build the Video
    clip=Video.new(video_location)

    puts "Extracting frames. This may take a while..."
    clip.extract_frames

    # image_processor = ImageProcessor.new("frames")
    # image_processor.load_frames

    # puts "Processing Images... This will take a while..."
    # image_processor.invert_color

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
end
