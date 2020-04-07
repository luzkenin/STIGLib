function Get-StigFile {
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
                [string]$Date = $null#(($Stig.outerHTML) | % { [regex]::matches( $_ , '(?<=<td class="updated_column">\s+)(.*?)(?=\s+</span>)' ) } | select -ExpandProperty value) #-replace "<span style=""display:none;"">",""
        
                [PSCustomObject]@{
                    Name = $Name
                    URI = $Stig.href
                    Version = $Version
                    Release = $Release
                    Date = $Date
                }
            }
        }
        #$Results
    }
    
    end {
        
    }
}