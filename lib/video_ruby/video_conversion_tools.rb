require "video_ruby/video"

module VideoConversionTools

  def VideoConversionTools.combine_frames(file_ext_name,fps,v_bitrate=nil,frames_dir) #will return a new Video object
    new_clip_path = "reconstructed_video.#{file_ext_name}"
    if v_bitrate
    	system("avconv -y -loglevel panic -r #{fps} -i #{frames_dir}/frame_%6d.png -b:v #{v_bitrate} '#{new_clip_path}'")
    else
    	system("avconv -y -loglevel panic -r #{fps} -i #{frames_dir}/frame_%6d.png #{new_clip_path}")
    end
    Video.new(new_clip_path)
  end

  def VideoConversionTools.add_audio_track(video_path,audio_path) #returns the current Video with the added audio
    clip_path = "#{video_path.split('.')[0]}_added_audio.mp4" #just local variable
    system("avconv -y -loglevel panic -i '#{video_path}' -i '#{audio_path}' -c copy #{clip_path}")
    Video.new(clip_path)
  end

end