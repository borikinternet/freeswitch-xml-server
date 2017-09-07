local config = require("lapis.config")

config("development", {
	port = 8080,
	mysql = {
		host = '127.0.0.1',
		user = 'xml-server',
		password = [[j4D7DYveV9eR97TC]],
		database = 'phonecms'
	},
	daemon = "off",
})

config("production", {
	port = 8080,
	num_workers = 4,
	mysql = {
		host = '127.0.0.1',
		user = 'xml-server',
		password = [[j4D7DYveV9eR97TC]],
		database = 'phonecms'
	},
	daemon = "on",
	code_cache = "off",
})
