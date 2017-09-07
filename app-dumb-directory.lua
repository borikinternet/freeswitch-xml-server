local XML	= require("XML-DD-Generator");

local lapis = require("lapis");
local app_helpers = require("lapis.application");
local capture_errors = app_helpers.capture_errors;
local to_json = require ("lapis.util").to_json;
local app = lapis.Application();
app:enable("etlua");

local respond_to = app_helpers.respond_to;

local xmlRespondTable = {
	GET = capture_errors(XML.generate),
	POST = capture_errors(XML.generate)
}

app:match("/dumb-directory", respond_to(xmlRespondTable));

return app;
