# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  
  def conference_date_2008(short=false)
    return "August 1&amp;2" if short
    "August 1&amp;2, 2008"
  end
  
  def conference_location_2008
    "Herndon, VA"
  end
  
  def conference_date(short=false)
    return "June" if short
    "April 9-10, 2010"
  end
  
  def conference_location
    "Reston, VA"
  end
end
