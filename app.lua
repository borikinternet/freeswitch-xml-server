local lapis = require("lapis");
local app = lapis.Application();
app:enable("etlua");

local app_helpers = require("lapis.application")
local capture_errors = app_helpers.capture_errors
local respond_to = app_helpers.respond_to

app:get("/", function()
  return "Welcome to Lapis " .. require("lapis.version")
end);

return app;
