setupScript = "setup\Setup.cmd"
args = ""
Set shell = CreateObject("Shell.Application")
shell.ShellExecute setupScript, args, "", "runas"

