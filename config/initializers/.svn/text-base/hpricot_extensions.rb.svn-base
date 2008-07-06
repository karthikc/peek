require 'mechanize'

class Hpricot::Elem
  def remove
    parent.children.delete(self)
  end
  
  def class?(classname)
    classes.include? classname
  end
end
