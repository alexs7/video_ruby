require_relative "video_data_parser"
require_relative "tools"
require_relative "audio"
require_relative "video_conversion_tools"

class Video

  attr_reader :fps, :file_path, :video_bitrate, :audio_codec,
              :video_file_extension

  def initialize(video_path)
    if !video_path  
      raise ArgumentError.new("You must provide a video path value!")  
    end

    video_data = VideoDataParser.new(video_path)
    @file_path = video_path
    @fps = video_data.fps
    @video_bitrate = video_data.video_bitrate
    @audio_codec = video_data.audio_codec
    @video_codec = video_data.video_codec
    @video_file_extension = file_extension(@video_codec)

  end

  def extract_frames
    Tools.create_frames_directory
    system("avconv -loglevel panic -i #{Regexp::escape(@file_path)} -r #{@fps} -f image2 frames/frame_%6d.png")
  end

  def extract_audio
    audio_file_path = "#{@file_path.split('.')[0]}_only_audio.#{@audio_codec}" #just local variable
    system("avconv -y -loglevel panic -i '#{@file_path}' -vn -acodec copy '#{audio_file_path}'")
    Audio.new(audio_file_path)
  end

  def file_extension(v_codec)
    v_codec == "h264" || v_codec == "mpeg4" ? "mp4" : "avi"
  end




  # def get_framerate
  #   framerate = 0
  #   @video_data['streams'].map do |data|
  #     if data['codec_type'] == "video" && (data['r_frame_rate'] == data['avg_frame_rate'])
  #       framerate = data['r_frame_rate']
  #     end
  #   end
  #   framerate.split('/')[0].to_i
  # end

  # def get_bitrate
  #   @video_data['format']['bit_rate'].to_i
  # end

  # def extract_frames
  #   Dir::mkdir(@dir_name_frames) if !File.directory?(@dir_name_frames)
  #   system("ffmpeg -loglevel panic -i #{Regexp::escape(@video_path)} -r #{@framerate} -f image2 #{Regexp::escape(@dir_name_frames)}/frame_%4d.png")
  # end

  # def build_video(output_dir=@dir_name_video)
  #   Dir::mkdir(@dir_name_video) if !File.directory?(@dir_name_video)
  #   system("ffmpeg -loglevel panic -start_number 1 -i #{Regexp::escape(@dir_name_frames)}/frame_%4d.png -vcodec mpeg4 -vb #{bitrate} #{Regexp::escape(@dir_name_video+'/rebuild.mp4')}")
  # end

end
