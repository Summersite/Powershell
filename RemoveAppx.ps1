#Remove APPX from PC
trap 
{ 
    Write-Host("Line{0}:{1}: {2} `nInner: {3}" -f 
        $_.InvocationInfo.ScriptLineNumber, 
        $_.InvocationInfo.OffsetInLine,
        $_.Exception.Message,
        $_.Exception.GetBaseException().Message
        );    
  exit 1 
}

# Remove applications - games from OS
 [System.Collections.ArrayList] $array = @(
		"*CandyCrushSodaSaga*"
		,"*BubbleWitch3Saga*"
		 ,"*SpotifyAB.SpotifyMusic*"
	#	 ,"*Microsoft.Advertising*"
		 ,"*DolbyLaboratories.DolbyAccess*"
		 ,"Xbox.TCUI"		 
		 ,"*Microsoft.XboxSpeechToTextOverlay*"
		 ,"*Microsoft.XboxGameOverlay*"
		 ,"*Microsoft.XboxIdentityProvider*"
		 ,"*XboxOneSmartGlass*"
		 ,"*Microsoft.Xboxapp*"
		 ,"*A278AB0D.DisneyMagicKingdoms*"
		 ,"*AutodeskSketchBook*"
		 ,"*A278AB0D.MarchofEmpires*"
		 ,"*Microsoft.BingNews*"
		 ,"*Microsoft.BingWeather*"
		 ,"*Microsoft.People*"
         ,"*HiddenCityMysteryofShadows*"
#		 ,"*Microsoft.Services.Store.Engagement*"
		 ,"*Microsoft.MicrosoftSolitaireCollection*"
		 )

	foreach ($Appx in $array) {

		#Get-AppxPackage -Allusers -Name $Appx | Remove-AppxPackage -verbose

		$Packages = Get-AppxPackage -AllUsers $Appx 
		foreach($Package in $Packages)
		{
			Write-Host ("Package: $Package.Name")
			$Package.PackageUserInformation | %{if ($_.InstallState -eq "Installed"){Remove-AppxPackage -User $_.UserSecurityId.Sid -Package $Package.PackageFullName -verbose} } 
		}
		Get-appxprovisionedpackage –online | where-object {$_.packagename –like "$Appx"} | remove-appxprovisionedpackage –online -verbose
	}
	
# remove-appxpackage -package "king.com.CandyCrushSodaSaga_1.106.700.0_x86__kgqvnymyfvs32" -verbose
# remove-appxpackage -package "king.com.BubbleWitch3Saga_4.2.2.0_x86__kgqvnymyfvs32" -verbose
# remove-appxpackage -package "SpotifyAB.SpotifyMusic_1.74.380.0_x86__zpdnekdrzrea0" -verbose
# remove-appxpackage -package "Microsoft.BingNews_4.22.10183.0_x64__8wekyb3d8bbwe" -verbose
# remove-appxpackage -package "Microsoft.Advertising.Xaml_10.1801.2.0_x64__8wekyb3d8bbwe" -verbose
# remove-appxpackage -package "Microsoft.Advertising.Xaml_10.1801.2.0_x86__8wekyb3d8bbwe" -verbose
# remove-appxpackage -package "DolbyLaboratories.DolbyAccess_2.1.30.0_x64__rz1tebttyb220" -verbose
# remove-appxpackage -package "Microsoft.Services.Store.Engagement_10.0.17112.0_x64__8wekyb3d8bbwe" -verbose
# remove-appxpackage -package "Microsoft.Services.Store.Engagement_10.0.17112.0_x86__8wekyb3d8bbwe" -verbose
# remove-appxpackage -package "A278AB0D.DisneyMagicKingdoms_2.7.1.4_x86__h6adky7gbf63m" -verbose
# remove-appxpackage -package "89006A2E.AutodeskSketchBook_1.7.1.0_x64__tf1gferkr813w" -verbose
# remove-appxpackage -package "A278AB0D.MarchofEmpires_3.0.0.12_x86__h6adky7gbf63m"  -verbose
# remove-appxpackage -package "Microsoft.BingWeather_4.21.2492.0_x64__8wekyb3d8bbwe" -verbose

# if (! $?)
# {
	# $host.ui.WriteErrorLine("the removeAppx script exited with failure")
	# exit 1
# }
# exit 0
