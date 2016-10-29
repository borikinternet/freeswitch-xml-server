local config = require("lapis.config")

config("development", {
	port = 8080,
	daemon = "off",
	mysql = {
		host = '127.0.0.1',
		user = 'xml-server',
		password = [[M&rP4-HTzm87w_dD]],
		database = 'ASR'
	}
})

config("production", {
	port = 8080,
	num_workers = 4,
	code_cache = "off",
	daemon = "on",
	mysql = {
		host = '127.0.0.1',
		user = 'xml-server',
		password = [[M&rP4-HTzm87w_dD]],
		database = 'ASR'
	}
})
