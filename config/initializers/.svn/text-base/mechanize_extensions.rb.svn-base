class WWW::Mechanize
  def marshal_dump
    string_io = StringIO.new
    YAML::dump(cookie_jar.jar, string_io)
    string_io.string
  end
  
  def marshal_load(text)
    self.send 'initialize'
    cookie_jar.jar = YAML::load StringIO.new(text)
  end
end

class WWW::Mechanize::CookieJar
  attr_writer :jar
end