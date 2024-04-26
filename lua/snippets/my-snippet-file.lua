local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	return {
		python = {
			s("cell", {
				t("#%% <cell>\n"),
				i(1, "Your code here"),
				t("#%% </cell>\n"),
			}),
		},
	}
}
