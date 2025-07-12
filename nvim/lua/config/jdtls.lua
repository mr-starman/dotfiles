return {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	config = function()
		local jdtls = require("jdtls")
		local home = os.getenv("HOME")
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

		local config = {
			cmd = {
				"jdtls",
				"--jvm-arg=-javaagent:" .. home .. "/.local/share/nvim/lombok.jar",
			},
			root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
			settings = {
				java = {
					configuration = {
						runtimes = {
							{
								name = "JavaSE-17",
								path = "/usr/lib/jvm/java-17-openjdk/",
							},
						},
					},
				},
			},
			init_options = {
				bundles = {},
			},
		}

		jdtls.start_or_attach(config)
	end,
}
