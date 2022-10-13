[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
Add-Type -AssemblyName System.Drawing


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

notification -title "titulo_ya" -mesage "mensaje" -question $False -path_icon "C:\Users\thoma\driv\programacion\proyectos\structurated\present\notifications\nagito.ico"

$Button = New-BTButton -Content 'Picture' -Arguments 'C:\Users\thoma\driv\programacion\proyectos\structurated\present\notifications\nagito.ico'

