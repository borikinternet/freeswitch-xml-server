html = require "lapis.html"

class DefaultXML extends html.Widget
  content: => @content_for "inner"

-- vim:syn=moon
