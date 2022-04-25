function Import-SyncroModule {
    param (
        #Defaults to the UUID of local system but you can provide the UUID of Any other Syncro Asset instead.
        $UUID = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\RepairTech\Syncro' -Name uuid -ErrorAction Stop).uuid
    )

    # Set up $env: vars for Syncro Module
    if([string]::IsNullOrWhiteSpace($env:SyncroModule)){
        $env:RepairTechFilePusherPath   = 'C:\ProgramData\Syncro\bin\FilePusher.exe'
        $env:RepairTechKabutoApiUrl     = 'https://rmm.syncromsp.com'
        $env:RepairTechSyncroApiUrl     = 'https://{subdomain}.syncroapi.com'
        $env:RepairTechSyncroSubDomain  = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\RepairTech\Syncro' -Name shop_subdomain).shop_subdomain
        $env:RepairTechUUID             = $UUID
        $env:SyncroModule               = "$env:ProgramData\Syncro\bin\module.psm1"
    }
    if (Test-Path -Path $env:SyncroModule) {
        Import-Module -Name $env:SyncroModule -WarningAction SilentlyContinue
    } else {
        [Environment]::SetEnvironmentVariable('SyncroModule',$null)
    }
}
