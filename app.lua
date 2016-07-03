local app = require("lapis").Application();
app:enable("etlua");

local app_helpers = require("lapis.application");
local capture_errors = app_helpers.capture_errors;
local respond_to = app_helpers.respond_to;

local XML = require("XMLGenerator");

local xmlRespondTable = {
	GET = capture_errors(XML.generate),
	POST = capture_errors(XML.generate)
}

app:match("xml", "/xml", respond_to(xmlRespondTable));

return app;
