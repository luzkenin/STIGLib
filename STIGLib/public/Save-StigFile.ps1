function Save-StigFile {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
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
        foreach($Resource in $URI){
            $FileName = ($Resource -split "/")[-1]
            Invoke-WebRequest -Uri $Resource -OutFile $Path\$FileName
        }
    }
    
    end {
        
    }
}