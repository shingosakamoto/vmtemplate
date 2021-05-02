#Requires -Version 3

[cmdletbinding(PositionalBinding = $true)]
param (
	[parameter(Mandatory = $false,
			   Position = 0,
			   ValueFromPipeline = $false,
			   ValueFromPipelineByPropertyName = $false)]
	[alias('CN')]
	[validatescript({ Test-Connection -ComputerName $_ -Count 1 -Quiet })]
	[string]$ComputerName = 'localhost'
)

BEGIN {
	
	Function Out-Notepad {
		
		[CmdletBinding()]		
		param (
			[Parameter(ValueFromPipeline = $True,
					   Position = 0, Mandatory = $True,
					   HelpMessage = "Pipelined input.")]
			[object[]]$InputObject
		)
		
		BEGIN {
						
			#initialize a placeholder array
			$data = @()
		} #end Begin scriptblock
		
		PROCESS {
			#save incoming objects to a variable
			if ($InputObject) {
				$data += $InputObject
			} else {
				$data += $_
			}
		} #end Process scriptblock
		
		END {
			
			$data | Out-File -FilePath .\Process.txt
			
		} #end End scriptblock
	} #end Function Out-Notepad
	
} # end BEGIN

PROCESS {
	
	systeminfo.exe /S $ComputerName /FO LIST | Out-Notepad
	
} # end PROCESS

END {
	# Cleanup work
} # end END

