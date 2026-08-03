local ok, overseer = pcall(require, "overseer")
if ok then
	overseer.setup({
		templates = {
			"builtin",
			"user.cpp.cpp",
			"user.java.java",
			"user.go",
		},
	})
end
