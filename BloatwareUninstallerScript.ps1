#Functions
#Graphic choice of the list, return the list path
function Get-FileName($initialDirectory){   
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
	
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "txt files (*.txt)|*.txt"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}
#Uninstall the packages on the list
function Remove-Commet($comment){
	$nocomment = $comment -replace "/#.*#/" #Delete text between /# and #/
	$nocomment = $nocomment -replace "#.*" #Delete # and all the characters after
	return $nocomment
	
	
}
function Start-Uninstall($name){
	Write-Host "`r"
	$file = New-Object System.IO.StreamReader($name) #List of packages to uninstall
	while( ($line = $file.readline()) -ne $null){ #It's repeated until the end of the packages
		#If the line is empty skip it, else remove comments
		if($line.Length -ne 0){
			$line = Remove-Commet($line) #String without comments
			if($line.Length -ne 0){ #If the line is empty skip it, else remove package
				Invoke-Expression ($tool + $line) #Run the uninstall process
			}
		}
	}
	$file.Close()
}
#Important Variables
$tooldir = "platform-tools\" #Path of the tool
$tool = '.\adb shell pm uninstall --user 0 ' #Command for executing the tool
$listdirpath = $PSScriptRoot+"\Lists\" #Path of the lists directory
$fileextension = ".txt" #Extension of lists

Set-Location $tooldir #Set the location of the tool

do{
	#Selection menu
	Write-Host "Menu" -ForegroundColor Green
	Write-Host "1. " -NoNewline -ForegroundColor Magenta 
	Write-Host "Enter the name of the list" #Manual insertion of the list with or without extension
	Write-Host "2. " -NoNewline -ForegroundColor Magenta
	Write-Host "Choose the list from a file explorer window" #GUI insertion of the list 
	Write-Host "0. " -NoNewline -ForegroundColor Magenta
	Write-Host "Exit" #Script exit
	$choice = Read-Host "Number of the option" #Option input
	
	#Switch menu
	switch($choice){
		#Manual insertion
		1 {
			$listname = Read-Host "Enter the list: " #insertion of the list with or without extension
			
			#Adding extension
			if(-not ($listname | Select-String -Pattern $fileextension)){ #Search the extension
				$listname += $fileextension
			}
			
			$listname = Get-ChildItem -Path $listdirpath -Include $listname  -Name #Search the list in the directory
			
			#If the list not exist: error, else uninstall the packages
			if($listname -eq $null){
				Write-Host "Invalid list"  -ForegroundColor DarkRed -BackgroundColor Black
			}
			else{
				Start-Uninstall($listdirpath+$listname) #Uninstall
			}
			;Break
		}
		#GUI insertion
		2 {
			$listpath = get-filename($listdirpath) #Takes the path of the list, GUI
			#If the list not exist or invalid extension: error, else uninstall the packages
			#Se la lista non esesiste o ha l'estensione sbagliata da erroe altrimenti esegue l'eliminare dei pacchetti
			if(($listpath -eq $null) -or (-not ($listpath | Select-String -Pattern $fileextension))){
				Write-Host "Invalid list"  -ForegroundColor DarkRed -BackgroundColor Black
			}
			else{
				Start-Uninstall($listpath) #Uninstall
			}
			;Break
		}
		#Invalid option
		Default{
			if($choice -ne 0){
				Write-Host "Invalid option" -ForegroundColor DarkRed -BackgroundColor Black
			}
			;Break
		}
	}
	Write-Host "`n"
}while($choice -ne 0) #0 The script ends


Read-Host "Press any ENTER to continue..." 