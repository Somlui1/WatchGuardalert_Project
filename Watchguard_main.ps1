Import-Module PowerHTML
. .\watchguard_function.ps1
#$clientId =  "ec1e5f36-4262-4ead-a5d7-9ab8892a950b"
#$tenantId =  "a4722e58-ec99-4c3b-a34c-38620f1c4288"
#$graphScopes = "User.Read.All mail.read mail.send Mail.ReadWrite"
# Authenticate the user
#Connect-MgGraph -ClientId $clientId -TenantId $tenantId -Scopes $graphScopes -UseDeviceAuthentication
$apiKey = "FfSghSoNzPlloALCK9LN5E46rzGnAYqxJ+mgirtf"
$deviceid = "59b67837-e144-4021-bd2b-a21246aecac7"
$credentials = '583db905e5af13cd_r_id:it@minAPI1WGant!'
$url = "https://api.jpn.cloud.watchguard.com/oauth/token"
#+=================+
#|  Get WatchGuard  |
#+=================+    

$Pathurl = "https://api.jpn.cloud.watchguard.com/rest/endpoint-security/management/api/v1/accounts/WGC-3-981e96282dcc4ad0856c/devices"
try {
    $response = Get-WatchGuardAPI -credentials $credentials -url $url -deviceid $deviceid -apiKey $apiKey -Pathurl $Pathurl
    if ($response -is [System.Management.Automation.ErrorRecord]) {
        throw $response
    }
} catch {
    Write-Error "Failed to get WatchGuard API response: $_"
    exit 1
}
#+=================+
#|  Connect to Graph | 
#+=================+
Connect-MgGraph 
$context = Get-MgContext
$today = (Get-Date).ToString("yyyy-MM-dd")
$user = Get-MgUser -UserId $context.Account -Select 'displayName, id, mail, userPrincipalName'
$emailAddress = "WGThreatAlert@pandasecurity.com"
$messages = Get-MgUserMailFolderMessage -UserId $user.Id -MailFolderId 'inbox' -Filter "from/emailAddress/address eq '$emailAddress' and receivedDateTime ge $today" 
#$filteredMessages = $messages | Where-Object { $_.subject -match "block" }
$data =@()
foreach ($ms in $messages)
{
    $detail = WatchGuard-tableD1 -htmlContent $ms.Body.Content   
    if ( $detail.computer -eq $null) {
        continue
    }
  $dataItem = [PSCustomObject]@{
        htmlContent = $ms.Body.Content
        detail = $detail
    }
    $data += $dataItem
}

foreach ($dt in $data)
{
    $dt.detail | ForEach-Object {
        $user = Get-ADUserInfo -user $_.user -domain $_.domain
        $user
    }
}
#+=================+
#|  Save File       |
#+=================+
# Example usage:
$filePath = "C:\Users\wajeepradit.p\OneDrive - AAPICO Hitech PCL\project\script\Automation Task\GrphAPI\WatchGuard\main\index.html"
#Save-HTMLToFile -filePath $filePath -htmlContent