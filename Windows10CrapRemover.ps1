$crap_app_clues = "3dbuilder",
  "3dviewer",
  "bingnews",
  "bingweather",
  "dtsheadphonex",
  "getHelp",
  "getstarted",
  "messaging",
  "microsoft.people",
  "officehub",
  "oneconnect",
  "onenote",
  "photos",
  "print3d",
  "settings",
  "skypeapp",
  "solitairecollection",
  "soundrecorder",
  "windowsalarms",
  "windowscalculator",
  "windowscamera",
  "windowscommunicationapps",
  "windowsmaps",
  "windowsphone",
  "windowsstore",
  "xboxapp",
  "xboxgameoverlay",
  "xboxgamingoverlay",
  "yourphone",
  "zunemusic",
  "zunevideo"

$KeyOption = 'Y', 'N'


Function RemoveApp($crap_app) {
  $name = $crap_app.Name
  Write-Host "Deleting $name..."
  Remove-AppxPackage -Package $crap_app -AllUsers
  Write-Host "Done"
}

Function GetApp($clue) {
  Get-AppxPackage -AllUsers -Name *$clue*
}

Function AskToDelete($prompt_text) {
  Write-Host $prompt_text
  while ($KeyOption -notcontains $KeyPress.Key) {
    $KeyPress = [console]::ReadKey("NoEcho")
  }
  $KeyPress.Key -eq 'Y'
}

Function Main {
  foreach($crap_clue in $crap_app_clues) {
    $crap_app = GetApp($crap_clue)
    if ($crap_app -ne $null) {
      $prompt_text = "Do you want to remove '$crap_clue' ? (y/n)"
      if(AskToDelete($prompt_text)) {
        RemoveApp($crap_app)
      }
    } else {
      Write-Host "Couldn't find '$crap_clue'. Skipping."
    }
  }
}

Main