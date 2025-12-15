-- fold --
return {
	-- nvim-ufo --
	{ "zR", require("ufo").openAllFolds },
	{ "", "n", "zM", require("ufo").closeAllFolds },
}
