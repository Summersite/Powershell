#--------------------------------------
# Declare constants used later
# If any changes are done to the folder
# name, they should be updated here
#--------------------------------------
#$SrcSystemsTeamFolder="C:\Windows\Temp\eupdownload\eNAEPUpdater\Step98-StudentToSupervisorConversion\StudentToSupervisorConversion"
$DestSystemsTeamFolder = "c:\systemsteam"
$DestSystemsTeamFoldereNAEPDocs = "c:\systemsteam\eNAEPDocs"
$DestSystemsTeamFoldereNAEPDocsNAEPDocuments = "c:\systemsteam\eNAEPDocs\NAEPDocuments"
$DestSystemsTeamFoldereNAEPDocsNAEPVideos = "c:\systemsteam\eNAEPDocs\NAEPVideos"
$DestSystemsTeamFoldereNAEPDocsNAEPQxQs = "c:\systemsteam\eNAEPDocs\NAEPQxQs"
#--------------------------------------


#--------------------------------------
# Copy new files over to c:\systemsteam\scripts\tablet
#--------------------------------------
#" Copying folder: " + $SrcSystemsTeamFolder
#if((Test-Path $DestSystemsTeamFolder) -eq $false)
#{
    "Creating folder: "+$DestSystemsTeamFolder
    New-Item -ItemType Directory -Path $DestSystemsTeamFolder

    "Creating folder: "+$DestSystemsTeamFoldereNAEPDocs
    New-Item -ItemType Directory -Path $DestSystemsTeamFoldereNAEPDocs

    "Creating folder: "+$DestSystemsTeamFoldereNAEPDocsNAEPDocuments
    New-Item -ItemType Directory -Path $DestSystemsTeamFoldereNAEPDocsNAEPDocuments

        "Creating folder: "+$DestSystemsTeamFoldereNAEPDocsNAEPVideos
    New-Item -ItemType Directory -Path $DestSystemsTeamFoldereNAEPDocsNAEPVideos

        "Creating folder: "+$DestSystemsTeamFoldereNAEPDocsNAEPQxQs
    New-Item -ItemType Directory -Path $DestSystemsTeamFoldereNAEPDocsNAEPQxQs
#}
#$SrcSystemsTeamFolder = $SrcSystemsTeamFolder + "\**"
#Copy-Item $SrcSystemsTeamFolder $DestSystemsTeamFolder -Recurse -Force
#--------------------------------------

exit 0
