function Save-StigFile {
    <#
    .SYNOPSIS
    Saves STIG benchmark files

    .DESCRIPTION
    Saves STIG benchmark files. Accepts pipeline input

    .PARAMETER URI
    URI to file. Accepts pipeline input

    .PARAMETER Path
    Path to save file

    .EXAMPLE
    Get-StigFile | Save-StigFile -Path ".\"

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string[]]
        $URI,
        # Parameter help description
        [Parameter(Mandatory)]
        [String]
        $Path
    )

    begin {

    }

    process {
        foreach ($Resource in $URI) {
            $FileName = ($Resource -split "/")[-1]
            Invoke-WebRequest -Uri $Resource -OutFile $Path\$FileName
        }
    }

    end {

    }
}