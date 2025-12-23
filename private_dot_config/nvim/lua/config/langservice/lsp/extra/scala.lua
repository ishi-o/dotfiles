-- use nvim-metals rather than lspconfig --
local metals_config = require("metals").bare_config()
metals_config.init_options = {
	statusBarProvider = "off",
	-- decorationProvider = false,
}
metals_config.settings = {
	verboseCompilation = true,
	showImplicitArguments = true,
	showImplicitConversionsAndClasses = true,
	showInferredType = true,
	superMethodLensesEnabled = true,
	excludedPackages = {
		"akka.actor.typed.javadsl",
		"org.apache.pekko.actor.typed.javadsl",
		"com.github.swagger.akka.javadsl",
	},
	testUserInterface = "Test Explorer",
	enableSemanticHighlighting = false,
}
metals_config.on_attach = function(_, _)
	require("metals").setup_dap()
end
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "scala", "sbt" },
	callback = function()
		require("metals").initialize_or_attach(metals_config)
	end,
	group = nvim_metals_group,
})
