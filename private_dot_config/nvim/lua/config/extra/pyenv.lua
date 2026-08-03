local ok, venv_selector = pcall(require, "venv-selector")
if ok then
	venv_selector.setup({
		options = {
			notify_user_on_venv_activation = true,
			picker = "native",
		},
		search = {
			conda_base = {
				command = "fd python$ ~/opt/conda3/bin --full-path --color never -E /proc",
				type = "anaconda",
			},
			conda_envs = {
				command = "fd python$ ~/opt/conda3/envs/**/bin --full-path --color never -E /proc",
				type = "anaconda",
			},
		},
	})
end
