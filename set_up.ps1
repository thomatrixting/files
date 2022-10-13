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
        mkdir $path
        mkdir ($path + "\logs")
        mkdir ($path + "\images")  

    }

    $path

}

$root = create_root 


download_from_web -url "https://thomatrixting.github.io/files/proposal.ps1" -path ($root + "\proposal.ps1") #import proposal
download_from_web -url "https://thomatrixting.github.io/files/notification_set_up.ps1" -path ($root + "\notification_set_up.ps1") #import proposal
download_from_web -url "https://thomatrixting.github.io/files/images/nagito_proposal_img.jpg" -path ($root + "\images\nagito_proposal_img.jpg")

. ($root + "\proposal.ps1") > ($root + "\logs\proposal_ps1.log")