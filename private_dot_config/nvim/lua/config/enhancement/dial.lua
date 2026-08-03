local ok, augend = pcall(require, "dial.augend")
if not ok then
	return
end

local ok2, dial_config = pcall(require, "dial.config")
if ok2 then
	dial_config.augends:register_group({
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
end
