Import-Module PowerHTML

. .\watchguard_function.ps1
#$credential = New-Object Microsoft.Graph.PowerShell.Authentication.DeviceCodeCredential
#Connect-MgGraph -Credential $credential
$clientId =  "ec1e5f36-4262-4ead-a5d7-9ab8892a950b"
$tenantId =  "a4722e58-ec99-4c3b-a34c-38620f1c4288"
$graphScopes = "User.Read.All mail.read mail.send Mail.ReadWrite"
# Authenticate the user
#Connect-MgGraph -ClientId $clientId -TenantId $tenantId -Scopes $graphScopes -UseDeviceAuthentication
Connect-MgGraph
$context = Get-MgContext
$user = Get-MgUser -UserId $context.Account -Select 'displayName, id, mail, userPrincipalName'
$emailAddress = "WGThreatAlert@pandasecurity.com"
$messages = Get-MgUserMailFolderMessage -UserId $user.Id -MailFolderId 'inbox' -Filter "from/emailAddress/address eq '$emailAddress'"  -Top 5
$filteredMessages = $messages | Where-Object { $_.subject -match "block" }
#$result = Get-BlockedItemDetails -htmlContent $usermail.Body.Content
#$data = Get-BlockedItemDetails -htmlContent $usermail.Body.Content
#$result =@()
#$filteredMessages | foreach{ 
#    $usermail = Get-MgUserMessage -UserId $user.Id -MessageId $_.Id
#    $data = Get-BlockedItemDetails -htmlContent $usermail.Body.Content
#    $result += [PSCustomObject]$data.BlockedItemDetails
#}
# ส่งออกผลลัพธ์เป็นไฟล์ CSV
#$result | Export-Csv -Path "D:\Reportmail\WathguardBlockItem.csv" -NoTypeInformation
#
Set-Clipboard -Value $messages[0].Body.Content