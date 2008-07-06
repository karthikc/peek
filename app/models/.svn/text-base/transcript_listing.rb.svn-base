class TranscriptListing

  def initialize(account, uri)
    @account = account
    @page = @account.page(uri)
  end
  
  def collect(&block)
    all_transcripts = @page.search(".transcript").collect {|element| Transcript.new(@account, element)}
    selected_transcripts = all_transcripts.select(&block)
    return selected_transcripts unless selected_transcripts.size == all_transcripts.size and older_listing
    selected_transcripts + older_listing.collect(&block)
  end
  
  def older_listing
    return @older_listing if @older_listing
    links = @page.links.text("Older")
    @older_listing = links.empty? ? nil : TranscriptListing.new(@account, links[0].uri)
  end
  
  def self.collect(account, &block)
    listing = TranscriptListing.new(account, account.transcripts_listing_url)
    transcripts = listing.collect(&block)
    transcripts.reject {|transcript| transcript.messages.empty?}
  end
  
end