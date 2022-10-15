[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
Add-Type -AssemblyName System.Drawing
function play_audio {
    param (
        $path
    )

    Add-Type -AssemblyName presentationCore
    $mediaPlayer = New-Object system.windows.media.mediaplayer
    $mediaPlayer.open($path)
    $mediaPlayer.Play()

}

function generate_df {
    param (
        $file_location

    )

        $df = (Get-Content $file_location -Encoding UTF8) 
        $df.Split([regex]::Unescape("\u000D"))

}

function notification {
    param (
        $title,
        $mesage,
        $question=$True,
        $path_icon,
        $path_audio

    )


    $objNotifyIcon = New-Object System.Windows.Forms.NotifyIcon
    if ( $question) {
        $objNotifyIcon.Icon = [System.Drawing.SystemIcons]::Question
    }
    else {
        $objNotifyIcon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path_icon)
    }

    $objNotifyIcon.BalloonTipText = $mesage
    $objNotifyIcon.BalloonTipTitle = $title
    $objNotifyIcon.Visible = $True

    $objNotifyIcon.ShowBalloonTip(50000)
    Start-Sleep 1
    play_audio -path $path_audio
    Start-Sleep 2


}

function date_is_today {
    param (
        $date
    )
    $Today = (Get-Date).ToString("dd-MM-yyyy")
    $date = (Get-Date "$date").ToString("dd-MM-yyyy")
    
    ($date -eq $Today)
}

$user_name = $env:UserName
$root = "C:\Users\" + $user_name + "\.proposal_thomas"

$df = (generate_df -file_location ($root + "\notifications_df.txt"))
Foreach ($raw_row in $df)
{
    $row = $raw_row.split(",")
    $is_today = date_is_today -date $row[0]
    if ($is_today) {
        try{
            notification -title $row[1] -mesage $row[2] -question $False -path_icon ($root + "\images\nagito_notification.ico")  -path_audio ($root + "\audios\notification_audio.mp3")
        }
        catch{
            break
        }
        exit        
    }
}


#if no notification is send
function rmd_notification {
    $rmd_index = (Get-Random -Minimum 0 -Maximum ($df.length)) 
    $rmd_row = $df[$rmd_index].split(",")

    try{
        notification -title $rmd_row[1] -mesage $rmd_row[2] -question $False -path_icon ($root + "\images\nagito_notification.ico") -path_audio ($root + "\audios\notification_audio.mp3")

    }
    catch {
        rmd_notification
    }
}

rmd_notification
