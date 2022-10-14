function download_from_web {
    param (
        $url,
        $path
        )

    curl -Uri $url -OutFile $path

}

function create_root {
    $user_name = $env:UserName
    $path = "C:\Users\" + $user_name + "\.proposal_thomas"
 
    if (-not (Test-Path $path)) {
        $_ = mkdir $path 
        $_ = mkdir ($path + "\logs") 
        $_ = mkdir ($path + "\images") 
        $_ = mkdir ($path + "\audios") 

    }

    $path 
}

$root = create_root 

Write-Output $root

download_from_web -url "https://thomatrixting.github.io/files/proposal.ps1" -path ($root + "\proposal.ps1") #import proposal
download_from_web -url "https://thomatrixting.github.io/files/notification_set_up.ps1" -path ($root + "\notification_set_up.ps1") #import not

download_from_web -url "https://thomatrixting.github.io/files/images/nagito_proposal_img.jpg" -path ($root + "\images\nagito_proposal_img.jpg")
download_from_web -url "https://thomatrixting.github.io/files/images/sad_nagito.jpg" -path ($root + "\images\sad_nagito.jpg")
download_from_web -url "https://thomatrixting.github.io/files/images/angry_nagito.jpg" -path ($root + "\images\angry_nagito.jpg")

download_from_web -url "https://thomatrixting.github.io/files/audios/nagito_audio.mp3" -path ($root + "\audios\nagito_audio.mp3")

. ($root + "\proposal.ps1") > ($root + "\logs\proposal_ps1.log")