-- require("telescope").load_extension("remote-sshfs")

require("remote-sshfs").setup({
	connections = {
		ssh_configs = {
			vim.fn.expand("$HOME") .. "/.ssh/config",
			"/etc/ssh/ssh_config",
		},
		ssh_known_hosts = vim.fn.expand("$HOME") .. "/.ssh/known_hosts",
		sshfs_args = {
			"-o reconnect",
			"-o ConnectTimeout=3",
		},
	},
	mounts = {
		base_dir = vim.fn.expand("$HOME") .. "/.sshfs/",
		unmount_on_exit = true,
	},
	handlers = {
		on_connect = {
			change_dir = true,
		},
		on_disconnect = {
			clean_mount_folders = false,
		},
	},
	ui = {
		confirm = {
			connect = true,
			change_dir = false,
		},
	},
	log = {
		enabled = false,
		truncate = false,
		types = {
			all = false,
			util = false,
			handler = false,
			sshfs = false,
		},
	},
})
