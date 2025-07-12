-- Detect current java version (e.g., 17 or 21)
local function detect_java_version()
	local handle = io.popen("java -version 2>&1")
	local output = handle:read("*a")
	handle:close()
	local version = output:match('version "(%d+)')
	return version and "JavaSE-" .. version or "JavaSE-17"
end

local function get_java_home()
	local handle = io.popen("readlink -f $(which java) 2>/dev/null | sed 's:/bin/java::'")
	if not handle then return "/usr/lib/jvm/default" end
	local result = handle:read("*a") or ""
	handle:close()
	result = result:gsub("\n", "")
	return result ~= "" and result or "/usr/lib/jvm/default"
end

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
								name = detect_java_version(),
								path = get_java_home(),
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
