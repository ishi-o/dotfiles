local ok, Rule = pcall(require, "nvim-autopairs.rule")
if not ok then
	return
end

local ok2, npairs = pcall(require, "nvim-autopairs")
if not ok2 then
	return
end
npairs.setup({
	disable_filetype = { "TelescopePrompt" },
	disable_in_macro = true,
	disable_in_visualblock = true,
	check_ts = true,
})
npairs.add_rule(Rule("“", "”", "markdown"))
npairs.add_rule(Rule("‘", "’", "markdown"))
npairs.add_rule(Rule("$", "$", "markdown"))
npairs.add_rule(Rule("$$", "$$", "tex"))
-- npairs.add_rule(Rule("/*", " */", {
-- 	"java",
-- 	"c",
-- 	"cpp",
-- 	"c",
-- 	"cs",
-- 	"javascript",
-- 	"typescript",
-- 	"php",
-- 	"sql",
-- 	"swift",
-- 	"go",
-- 	"rust",
-- 	"kotlin",
-- 	"scala",
-- 	"objc",
-- 	"dart",
-- 	"julia",
-- 	"haskell",
-- 	"perl",
-- 	"r",
-- 	"matlab",
-- }))
