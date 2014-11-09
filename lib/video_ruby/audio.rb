class Audio

  attr_reader :file_path

  def initialize(audio_path)

    if !audio_path  
      raise ArgumentError.new("You must provide an audio path value!")  
    end

    @file_path = audio_path

  end

end
