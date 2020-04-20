function Get-StigFile {
    <#
    .SYNOPSIS
    Pulls list of STIG benchmarks

    .DESCRIPTION
    Get list of STIG benchmark files from https://public.cyber.mil/stigs/downloads/

    .EXAMPLE
    Get-StigFile

    .NOTES
    Date doesn't work.
    #>
    [CmdletBinding()]
    param (

    )

    begin {
        $StigLibrary = Invoke-WebRequest -Uri 'https://public.cyber.mil/stigs/downloads/' -UseBasicParsing
    }

    process {
        foreach ($Stig in $StigLibrary.links) {
            if ($Stig.href -like "*/zip/*") {

                [string]$Name = (($Stig.outerHTML) | % { [regex]::matches( $_ , '(?<=</span>\s+)(.*?)(?=\s+</a>)' ) } | select -ExpandProperty value).trim()
                [int]$Version = (($Name) | % { [regex]::matches( $_ , '(?<=Ver\s+)(\d+)' ) } | select -ExpandProperty value)
                [int]$Release = (($Name) | % { [regex]::matches( $_ , '(?<=,\s+Rel\s+)(\d+)' ) } | select -ExpandProperty value) #.trim()
                [string]$Date = $null#(($Stig.outerHTML) | % { [regex]::matches( $_ , '(?<=<td class="updated_column">\s+)(.*?)(?=\s+</span>)' ) } | select -ExpandProperty value) #-replace "<span style=""display:none;"">",""

                [PSCustomObject]@{
                    Name    = $Name -replace '[^ -x7e]', ''
                    URI     = $Stig.href
                    Version = $Version
                    Release = $Release
                    Date    = $Date
                }
            }
        }
    }

    end {

    }
}
