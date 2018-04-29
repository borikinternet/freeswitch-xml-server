local xg = {};

local cst = require("constants");
local assert_error = require("lapis.application").assert_error;
local to_json = require ("lapis.util").to_json;
local my_utils = require ("my_utils");

local debug = false;

function xg.generate(self)
	if debug then print(to_json(self.params)); end;
	local template = nil;
	local status = 200;
	self.params.user = my_utils.split(self.params.user,"@");
	self.tpl_params = {};
	if my_utils.isTable(self.params.user) 
		then self.params.user = self.params.user[1] end;
	if	self.params.section == "directory" 
			and self.params.tag_name == "domain" 
			and self.params.key_name == "name" 
			and self.params.user 
			and not self.params.purpose
		then 
			local db = require("lapis.db");
			local res,err = db.query(
				"SELECT idvoicemail_prefixes AS prefix\
					FROM voicemail_prefixes, voicemail_exclude_prefixes \
					WHERE ? LIKE CONCAT(idvoicemail_prefixes,'%') \
						AND NOT ? LIKE CONCAT(idvoicemail_exclude_prefixes, '%') \
					ORDER BY length(idvoicemail_prefixes) DESC \
					LIMIT 1;",
				tostring(self.params.user),
				tostring(self.params.user));
			if res and #res>0 then
				status = 200;
				template = "directory_user";
				self.tpl_params.domain = self.params.key_value;
				self.tpl_params.user = self.params.user;
				res,err = db.query(
					"SELECT name, value\
						FROM voicemail_attrs\
						WHERE username = ?  AND domain = ? AND attr_type = 'user_param'", 
					tostring(self.tpl_params.user),
					tostring(self.tpl_params.domain))
				self.tpl_params.user_params = res
				print(to_json(self.tpl_params))
			elseif err then
				self.err = err
			end
			if debug then print(to_json(self.tpl_params)) end
	elseif	self.params.section == "directory" 
			and self.params.tag_name == "domain" 
			and self.params.key_name == "name" 
		then 
			status = 200;
			template = "directory_domain";
			self.tpl_params.domain = self.params.key_value;
	end;
	if debug then print(template) end;
	return {
		layout = "DefaultXML",
		status = status,
		render = template or "no_result"
	}
end

return xg
