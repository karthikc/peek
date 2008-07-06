require 'mechanize'
class Account
  
  attr_reader :name, :timezone
  
  def initialize(agent, name)
    @agent = agent
    @name = name
    selected_timezone = page("/account/settings").at("#account_time_zone_id option[@selected]")
    @timezone = selected_timezone ? TimeZone.new(selected_timezone['value']) : nil
  end
  
  def transcripts_listing_url
    absolute_url "/files+transcripts"
  end
  
  def today
    timezone ? timezone.today : Date.today
  end
  
  def url
    absolute_url "/"
  end
  
  def absolute_url(path)
    path.start_with?("/") ? "http://#{@name}.campfirenow.com#{path}" : path
  end
  
  def page(uri)
    page = @agent.get uri
    page.search("a").each { |link| link['href'] = absolute_url(link['href']) }
    page.search("img").each { |image| image['src'] = absolute_url(image['src']) }
    page
  end
  
  def format_date(date)
    day = Date::DAYNAMES[date.wday]
    month = Date::MONTHNAMES[date.month]
    year = date.year
    return "#{day}, #{month} #{date.mday} #{year}" unless timezone
    
    day = 'Today' if date == today
    day = 'Yesterday' if date == today - 1
    year = '' if year = today.year
    return "#{day}, #{month} #{date.mday} #{year}" 
  end
  
  def self.login(name, email, password)
    agent = WWW::Mechanize.new
    login_page = agent.get "http://#{name}.campfirenow.com/login"
    form = login_page.forms.first
    form.email_address = email
    form.password = password
    home_page = agent.submit form
    home_page.title != 'Campfire Login' ? Account.new(agent, name) : nil
    rescue
      nil
  end
      
end