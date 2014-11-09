require 'fileutils'

module Tools

  def Tools.create_frames_directory 
    FileUtils.rm_rf('frames') if Dir.exists?('frames')
    Dir::mkdir('frames')
  end

end