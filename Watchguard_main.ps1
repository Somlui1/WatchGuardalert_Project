Import-Module PowerHTML
. .\watchguard_function.ps1
#$clientId =  "ec1e5f36-4262-4ead-a5d7-9ab8892a950b"
#$tenantId =  "a4722e58-ec99-4c3b-a34c-38620f1c4288"
#$graphScopes = "User.Read.All mail.read mail.send Mail.ReadWrite"
# Authenticate the user
#Connect-MgGraph -ClientId $clientId -TenantId $tenantId -Scopes $graphScopes -UseDeviceAuthentication
Connect-MgGraph 
$context = Get-MgContext
$today = (Get-Date).ToString("yyyy-MM-dd")
$user = Get-MgUser -UserId $context.Account -Select 'displayName, id, mail, userPrincipalName'
$emailAddress = "WGThreatAlert@pandasecurity.com"

$messages = Get-MgUserMailFolderMessage -UserId $user.Id -MailFolderId 'inbox' -Filter "from/emailAddress/address eq '$emailAddress' and receivedDateTime ge $today" 
#$filteredMessages = $messages | Where-Object { $_.subject -match "block" }
$data =@()
foreach ($ms in $messages) {
    $data += WatchGuard-tableD1 -htmlContent $ms.Body.Content
}
