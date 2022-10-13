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
    }

    $path

}

$root = create_root 

download_from_web -url "https://thomatrixting.github.io/files/notifications_df.txt" -path ($root+"\notifications_df.txt")