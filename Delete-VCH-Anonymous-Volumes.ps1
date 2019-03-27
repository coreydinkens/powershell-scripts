<# This script will list the volumes on a vSphere VCH and allow you to select which volumes you would like to delete. #>
<# 
*This script assumes the following is true of the environment from which this script will execute:*

Powershell ISE is installed on your system
You are using vSphere Integrated Containers (VIC)
You are using --tlsverify to connect to your VCH host

You have the following Docker ENV's set:
DOCKER_HOST
COMPOSE_TLS_VERSION
DOCKER_CERT_PATH 

You will need to modify the docker command on the next line accordingly if you are not using the above settings
#>
$getvolumes = docker --tlsverify volume ls | select -Skip 1 | Out-GridView -Title 'Choose a volume' -PassThru | ForEach-Object { $_ } | ConvertFrom-string -Delimiter "\s+" -PropertyNames Driver,VolumeName -Outvariable matching

$volumestoremove = $getvolumes.VolumeName

foreach ($vol in $volumestoremove){ 
write-warning "About to delete docker volume: $vol" 
Read-Host -Prompt "Press any key to continue or CTRL+C to quit"
docker --tlsverify volume rm $vol  
}



