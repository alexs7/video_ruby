require 'fileutils'

module Tools

  def self.create_frames_directory 
    FileUtils.rm_rf('frames') if Dir.exists?('frames')
    Dir::mkdir('frames')
  end

  def self.flip_filter(filter_array)
  	filter_array.map { |column| column.reverse }
  end

end