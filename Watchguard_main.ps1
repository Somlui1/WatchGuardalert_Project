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
$datatype  = @(
    "account_id",
    "active_directory_canonical_name",
    "agent_version",
    "custom_group_folder_path",
    "device_id",
    "domain",
    "encryption",
    "host_name",
    "ip_address",
    "isolation_state",
    "last_connection",
    "license_status",
    "logged_on_users_list",
    "mac_addresses",
    "operating_system",
    "platform_id",
    "reboot_requested",
    "reinstall_agent_requested",
    "reinstall_protection_requested",
    "security_configuration_id",
    "security_configuration_name",
    "site_id",
    "site_name",
    "type")
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
foreach ($ms in $messages) {
    $detail = WatchGuard-tableD1 -htmlContent $ms.Body.Content
    if ($detail.computer -eq $null) {
        Write-Output "Not found"
        continue
    }
    foreach ($re in $response.data) {
        if ($detail.Computer -eq $re.host_name) {
            Write-Output "found"
            $API = $re
            break
        } else {
            $API = $null
        }
    }
    if ($API -ne $null) {
        $parts = $API.logged_on_users_list -split '\\'
        $ADaccounts = Get-ADUserInfo -domain $parts[0] -user $parts[1]
    } else {
        $ADaccounts = $null
    }
    $dataItem = [PSCustomObject]@{
        htmlContent = $ms.Body.Content
        detail = $detail
        api = $API
        ADaccounts = $ADaccounts
    }
    $data += $dataItem
}
$htmlresult = @()
foreach($dt in $data)
{
    $htmlContent = $dt.htmlContent 
    $detail = $dt.detail
    $api = $dt.API
    $ADaccounts = $dt.ADaccounts

    $insertData = [PSCustomObject]@{
        User = $ADaccounts.SamAccountName
        Department = $ADaccounts.Department
        Company = $ADaccounts.Company
        domain = $api.domain
        IP = $api.ip_address
        "last_connection" = $api.last_connection
        "operating_system" = $api.operating_system

    }

$htmlDoc = New-Object 'HtmlAgilityPack.HtmlDocument'
$htmlDoc.LoadHtml($htmlContent)
$nodes = $htmlDoc.DocumentNode.SelectNodes("//h2[1]/following-sibling::table[1]//tbody")
$node = $nodes[0]
$trad = ""
foreach($ob in $insertData.PSObject.Properties.name)
{
$newRow = $htmlDoc.CreateElement("tr")
$newRow.InnerHtml = @"
<th style='font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; font-size:15px!important; width:30%'>$($ob):</th>
<td style='font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; font-size:15px!important'>$($insertData.$($ob))</td>
"@
$node.AppendChild($newRow)
}
$htmlresult += $htmlDoc.DocumentNode.OuterHtml
}

#+=================+
#|  Save File       |
#+=================+

# Example usage:

#$filePath = "C:\Users\wajeepradit.p\OneDrive - AAPICO Hitech PCL\project\script\Automation Task\GrphAPI\WatchGuard\main\index.html"

#Save-HTMLToFile -filePath $filePath -htmlContent
# Define the array of user accounts
