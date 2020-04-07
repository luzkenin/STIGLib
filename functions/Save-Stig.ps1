function Save-StigFile {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [string[]]
        $URI,
        # Parameter help description
        [Parameter(Mandatory)]
        [System.IO.Path]
        $Path
    )
    
    begin {
        
    }
    
    process {
        foreach($Resource in $URI){
            Invoke-WebRequest -Uri $Resource -OutFile $Path
        }
    }
    
    end {
        
    }
}