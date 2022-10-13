[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
Add-Type -AssemblyName System.Drawing

function generate_df {
    param (
        $file_location

    )

        $df = (Get-Content $file_location) 
        $df.Split("
    ")

}

function notification {
    param (
        $title,
        $mesage,
        $question=$True,
        $path_icon

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
    Start-Sleep 5
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
        notification -title $row[1] -mesage $row[2] -question $False -path_icon ($root + "\images\nagito_notification.ico")        
    }
}



