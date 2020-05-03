#JG - April 2020. Got this from a FB post on PowerShell
# n SharePoint I need to run a script that returns :
# 1) All files / images / videos.
# 2) Who has permission to read or write
# 3) When the files were last edited (and by whom)


#Output path
$outputpath = "C:\Scripts\resultfiles.csv"

#Variable for storing all the document libraries in the site
$DocLibs = Get-PnPList | Where-Object {$_.BaseTemplate -eq 101}

#Loop through each document library adn folders
$results = @()
foreach ($DocLib in $DocLibs) {
    $AllItems = Get-PnPListItem -List $DocLib -Fields "FileRef", "File-x00200_Type", "FileLeafRef"

        #Loop through each item
        foreach ($item in $AllItems) {

            #Write-Host ("File found. Path: $Item["FileRef"]) -foregroundcolor Green
            #Creating new object to export to the .csv file
            $results += New-Object PSObject -property @{
                Path = $Item["FileRef"]
                FileName = $item["FileLeafRef"]
                FileExtension = $item["File_x0020_Type"]
            }

        }


}
$results | export-csv - path $outputpath -NoTypeInformation