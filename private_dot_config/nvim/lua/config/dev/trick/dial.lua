local augend = require("dial.augend")
require("dial.config").augends:register_group({
	default = {
		augend.integer.alias.decimal_int,
		augend.integer.alias.hex,
		augend.constant.alias.bool,
		augend.constant.alias.Bool,
		augend.constant.alias.alpha,
		augend.constant.alias.Alpha,
		-- augend.date.alias["%Y/%m/%d"],
		augend.constant.new({
			elements = { "and", "or" },
			word = true,
			cyclic = true,
		}),
		augend.constant.new({
			elements = { "&&", "||" },
			word = false,
			cyclic = true,
		}),
		augend.semver.alias.semver,
	},
})
