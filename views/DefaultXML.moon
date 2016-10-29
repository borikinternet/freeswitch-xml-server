html = require "lapis.html"

class DefaultXML extends html.Widget
  content: =>
	 element "document", type: "freeswitch/xml", ->
		 @content_for "inner"

-- vim:syn=moon
