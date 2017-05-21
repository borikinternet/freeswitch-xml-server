local xg = {};

local cst = require("constants");
local assert_error = require("lapis.application").assert_error;
local util = require ("lapis.util");
local to_json = util.to_json;
local my_utils = require ("my_utils");

function xg.generate(self)
	--print(to_json(self.params));
	local template = nil;
	self.params.user = my_utils.split(self.params.user,"@");
	if my_utils.isTable(self.params.user) 
		then self.params.user = self.params.user[1] end;
	if		self.params.section == "directory" 
			and self.params.tag_name == "" 
			and self.params.key_name == "" 
			and self.params.purpose ~= "gateways" 
		then template = "directory_full" 
	elseif	self.params.section == "directory" 
			and self.params.tag_name == "" 
			and self.params.key_name == "" 
			and self.params.purpose == "gateways" 
		then template = "directory_gateways" 
	elseif	self.params.section == "directory" 
			and self.params.tag_name == "domain" 
			and self.params.key_name == "name" 
			and self.params.purpose == "network-list" 
		then template = "netwrok_list"
	elseif	self.params.section == "directory" 
			and self.params.tag_name == "domain" 
			and self.params.key_name == "name" 
			and self.params.user 
			and not self.params.purpose
		then template = "directory_user"
	elseif	self.params.section == "directory" 
			and self.params.tag_name == "domain" 
			and self.params.key_name == "name" 
			and self.params.group 
			and self.params.action == "group_call" 
			and not self.params.purpose 
		then template = "directory_group"
	elseif	self.params.section == "directory" 
			and self.params.tag_name == "domain" 
			and self.params.key_name == "name" 
			and self.params.domain
		then template = "directory_domain"
	end;
	print(template);
	return {
		layout = "DefaultXML",
		render = template or "no_result"
	}
end

return xg
