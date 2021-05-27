|-|-|
| Problem: |	Can not install modules form powershell gallery|
|Error: "Warning: | 	Unable to find module repositories"|
|Solution (not tested): |  	[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12|
|	Register-PSRepository -Default -Verbose|
|	Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted|
