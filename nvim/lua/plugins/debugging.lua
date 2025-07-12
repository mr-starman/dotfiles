return {
	"mfussenegger/nvim-dap",
	"nvim-neotest/nvim-nio",
	dependencies = {
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end

		dap.configurations.java = {
			{
				type = "java",
				request = "launch",
				name = "Launch Java Program",
				mainClass = "com.example.Main",
				projectName = "YourProjectName",
			},
		}
	end,
}
