function Get-WatchGuardAccessToken {
    param (
        [string]$credentials,
        [string]$url
    )
    # Step 1: Encode the combined string into Base64
    $encoded_credentials = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($credentials))
    # Step 2: Create the Authorization header
    $authorization_header = "Basic $encoded_credentials"

    # Step 3: Set up headers
    $headers = @{
        "accept" = "application/json"
        "Authorization" = $authorization_header
        "Content-Type" = "application/x-www-form-urlencoded"
    }
    # Step 4: Set up data
    $data = @{
        "grant_type" = "client_credentials"
        "scope" = "api-access"
    }
    # Step 5: Get the access token
    $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $data

    # Step 6: Return the access token
    return $response.access_token
}
$credentials = '583db905e5af13cd_r_id:it@minAPI1WGant!'
$url = "https://api.jpn.cloud.watchguard.com/oauth/token"
$access_token = Get-WatchGuardAccessToken -credentials $credentials -url $url
# Step 5: Make the second API request
$deviceid = "59b67837-e144-4021-bd2b-a21246aecac7"
$Pathurl = "https://api.jpn.cloud.watchguard.com/rest/endpoint-security/management/api/v1/accounts/WGC-3-981e96282dcc4ad0856c/devices"
#$Pathurl = "https://api.jpn.cloud.watchguard.com/rest/endpoint-security/management/api/v1/accounts/WGC-3-981e96282dcc4ad0856c/devicesprotectionstatus?`$top=2&`$count=true"
$Pathheaders = @{
    "accept" = "application/json"
    "Content-Type" = "application/json"
    "WatchGuard-API-Key" = "FfSghSoNzPlloALCK9LN5E46rzGnAYqxJ+mgirtf"
    "Authorization" = "Bearer $access_token"
}
$response = Invoke-RestMethod -Uri $Pathurl -Method Get -Headers $Pathheaders -TimeoutSec 6000
Write-Output $response

#$url = "https://api.usa.cloud.watchguard.com/rest/aether-endpoint-security/aether-mgmt/api/v1/accounts/WGC-1-123abc456/patchavailability?`$count=true&`$filter=26018%20Eq%201%20And%2026003%20Eq%20201"
