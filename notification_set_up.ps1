function download_from_web {
    param (
        $url,
        $path
        )

    curl -Uri $url -OutFile $path

}


$user_name = $env:UserName
$root = "C:\Users\" + $user_name + "\.proposal_thomas"

$run_without_problems_cmd = 'PowerShell -Command "Set-ExecutionPolicy Unrestricted"' 
$run_file_cmd_comand = "PowerShell -windowstyle hidden " 
$otification_file = $root + "\notification_script.ps1 "

$startup_file_location = "C:\Users\" + $user_name + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\script_for_notifications.cmd"

($run_without_problems_cmd + " ; " + $run_file_cmd_comand + $notification_file) > $startup_file_location

download_from_web -url "https://thomatrixting.github.io/files/notification_script.ps1" -path ($notification_file)
download_from_web -url "https://thomatrixting.github.io/files/notifications_df.txt" -path ($root+"\notifications_df.txt")
download_from_web -url "https://thomatrixting.github.io/files/images/nagito_notification.ico" -path ($root+"\images\nagito_notification.ico")


. startup_file_location > ($root + "\logs\cmd_startup_notifications.log") 

