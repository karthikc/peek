class Transcript
  
  attr_reader :date
  
  def initialize(account, element)
    @account = account
    @link = element.at("a")['href']
    parts = @link.split("/")
    @date = Date.new(parts[6].to_i, parts[7].to_i, parts[8].to_i)
  end
  
  def page  
    @page ||= @account.page(@link)
  end
  
  def room
    page.search("#room_title h1").text
  end
  
  def humanized_date
    page.at("h1.date").inner_html.strip
  end
  
  def messages
    return @messages if @messages
    page.search(".enter_message").remove
    page.search(".kick_message").remove
    page.search(".leave_message").remove
    remove_consecutive_timestamps
    @messages = page.search(".message")
  end
  
  def remove_consecutive_timestamps
    page.search(".message").each do |message|
      previous = message.previous_sibling
      previous.remove if(previous and message.class? "timestamp_message" and previous.class? "timestamp_message")
    end
    last_message = page.search(".message").last
    last_message.remove if last_message and last_message.class? "timestamp_message"
  end
  
  def previous_transcript
    page.search("#chat-wrapper .adjacent_transcripts").at("a").to_html
  end
  
  def people
    messages.search('.person span').collect {|element| element.inner_html.strip}
  end
  
  def last_post
    last_timestamp = messages.search(".timestamp_message").last
    daymonth = last_timestamp.at(".date").inner_text
    time = last_timestamp.at(".time").inner_text
    DateTime.parse "#{daymonth} #{date.year}, #{time}", "%b %d %Y, %I:%M %p"
  end
  
end