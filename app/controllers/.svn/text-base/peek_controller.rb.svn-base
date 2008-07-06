require 'mechanize'

class PeekController < ApplicationController
  
  before_filter :ensure_user_logged_in
  
  def index
    offset = params[:days] ? params[:days].to_i - 1 : 0
    @date = account.today - offset
    transcripts = TranscriptListing.collect(account) {|transcript| transcript.date >= @date}
    @rooms = Room.group(transcripts)
  end
  
end
