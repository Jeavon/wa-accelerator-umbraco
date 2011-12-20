setupScript = "setup\SetupLocal.cmd"
args = ""
Set shell = CreateObject("Shell.Application")
shell.ShellExecute setupScript, args, "", "runas"

