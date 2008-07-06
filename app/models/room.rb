class Room
  
  attr_reader :name, :transcripts
  
  def initialize(name)
    @name = name
    @transcripts = []
  end
  
  def add(transcript)
    @transcripts << transcript
    @transcripts.sort! { |t1, t2| t1.date <=> t2.date }
  end
      
  def previous_transcript
    transcripts.first.previous_transcript
  end
  
  def people
    names = transcripts.collect {|transcript| transcript.people}
    names.flatten.uniq.join(", ")
  end
  
  def last_post
    transcripts.last.last_post
  end
  
  def <=>(other)
     other.last_post <=> last_post
  end
  
  def self.group(transcripts)
    group = {}
    transcripts.each do |transcript| 
      room = group[transcript.room] ||= Room.new(transcript.room)
      room.add(transcript) 
    end
    group.values.sort
  end
end