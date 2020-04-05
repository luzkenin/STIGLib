function Get-Stig {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        #$try = Invoke-WebRequest -UseBasicParsing -Uri 'https://public.cyber.mil/stigs/downloads/'
        $StigLibrary = Invoke-WebRequest -Uri 'https://public.cyber.mil/stigs/downloads/'
        #$Results = @()
    }
    
    process {
        foreach($Stig in $StigLibrary.links){
            if($Stig.href -like "*/zip/*"){
        
                [string]$Name = (($Stig.outerHTML) | % { [regex]::matches( $_ , '(?<=</span>\s+)(.*?)(?=\s+</a>)' ) } | select -ExpandProperty value).trim()
                #[int]$Version = (($Name) | % { [regex]::matches( $_ , '(?<=Ver\s+)(\d+)(?=,\s+Rel)' )} | select -ExpandProperty value)
                [int]$Version = (($Name) | % { [regex]::matches( $_ , '(?<=Ver\s+)(\d+)' )} | select -ExpandProperty value)
                [int]$Release = (($Name) | % { [regex]::matches( $_ , '(?<=,\s+Rel\s+)(\d+)' )} | select -ExpandProperty value) #.trim()
        
                [PSCustomObject]@{
                    Name = $Name
                    URI = $Stig.href
                    Version = $Version
                    Release = $Release
                }
            }
        }
        #$Results
    }
    
    end {
        
    }
}
