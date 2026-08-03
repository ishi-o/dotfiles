vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true

local lombok_jar = vim.fn.stdpath("data") .. "/mason/share/jdtls/lombok.jar"
local jvm_args = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Xmx6G -Xms1G "

if vim.fn.filereadable(lombok_jar) == 1 then
	vim.env.JDTLS_JVM_ARGS = "-javaagent:" .. lombok_jar .. " " .. jvm_args
else
	vim.notify("jdtls: lombok.jar not found, starting without -javaagent", vim.log.levels.INFO)
	vim.env.JDTLS_JVM_ARGS = jvm_args
end
