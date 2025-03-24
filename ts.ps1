$clientId =  "ec1e5f36-4262-4ead-a5d7-9ab8892a950b"
$tenantId =  "a4722e58-ec99-4c3b-a34c-38620f1c4288"
#$graphScopes = "User.Read.All mail.read mail.send Mail.ReadWrite"
Connect-MgGraph -ClientId $clientId -TenantId $tenantId -CertificateThumbprint "BDE04873ABD2F62E41102076CD5650C91EC7CF78"
$user = get-mguser -UserId "wajeepradit.p@aapico.com" -Select 'displayName, id, mail, userPrincipalName'
$emailAddress = "WGThreatAlert@pandasecurity.com"
$today = (Get-Date).ToString("yyyy-MM-dd")
$messages = Get-MgUserMailFolderMessage -UserId $user.Id -MailFolderId 'inbox' -Filter "from/emailAddress/address eq '$emailAddress' and receivedDateTime ge $today" 
#Get-MgUserMailFolderMessage -UserId $user.Id -MailFolderId 'inbox' -Filter "from/emailAddress/address eq '$emailAddress' and receivedDateTime ge $today"
#$Subfolder = Get-MgUserMailFolderChildFolder -UserId $user.id -MailFolderId "AAMkADg0ZGMxNWJhLTEwYmYtNGZlOC1iZTNhLThkMDA1MjlkZDJkZAAuAAAAAABgMXAAPDLQT4HfJxmfhRG8AQBkvK5jCAHYT6tzQpMQ0K-pAAAAABK0AAA=" -IncludeHiddenFolders $true -All