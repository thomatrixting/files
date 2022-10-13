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

sleep 5

#continue with main
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationFramework

$user_name = $env:UserName
$root = "C:\Users\" + $user_name + "\.proposal_thomas"

$result = [System.Windows.MessageBox]::Show('Do you want to proceed?', 'None', 'YesNo','information')

if ($result -eq "Yes") {
    
    . ($root + "\notification_set_up.ps1") > ($root + "\logs\notification_set_up.log")
} 