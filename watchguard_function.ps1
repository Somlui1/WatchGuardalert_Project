function Get-ADUserInfo {
    param (
        [string]$user,
        [string]$domain
    )

    # Define domain-specific credentials
    switch ($domain.ToLower()) {
        'aapico' {
            $domainController = 'aapico.com'
            $username = "aapico\ahroot"
            $password = ConvertTo-SecureString "A@pic0it@min" -AsPlainText -Force
        }
        'asico' {
            $domainController = 'asico.co.th'
            $username = "asico\it"
            $password = ConvertTo-SecureString "support" -AsPlainText -Force
        }
        default {
            Write-Output "Invalid domain"
            return
        }
    }

    # Create the PSCredential object
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password

    # Retrieve the user from the specified domain
    try {
        $user1 = Get-ADUser -Identity $user -Server $domainController -Credential $credential -Properties department, company | Select-Object department,company
        if ($user) {
            # Return the user information
            return [PSCustomObject]@{
                SamAccountName = $user1.SamAccountName
                Department     = $user1.Department
                Company        = $user1.Company
            }
        } else {
            Write-Output "User not found"
        }
    } catch {
        Write-Error "An error occurred: $_"
    }
}

function sendmail {
    param (
        [string]$texthtml,
        [string]$subject,
        [string]$sendto
    )
$smtpServer = "smtp.office365.com"
$smtpPort = 587
$smtpUser = "itsupport@aapico.com"
#$smtpPassword = "zyhkkcprwtyhtctv"
$smtpPassword ="support"
# สร้างออบเจ็กต์ SmtpClient
$smtp = New-Object Net.Mail.SmtpClient($smtpServer, $smtpPort)
$smtp.EnableSsl = $true
$smtp.Credentials = New-Object System.Net.NetworkCredential($smtpUser, $smtpPassword)
# สร้างออบเจ็กต์ MailMessage
$mailMessage = New-Object System.Net.Mail.MailMessage
$mailMessage.From = $smtpUser
#$itsupport = "itsupport@aapico.com"
#$mailMessage.To.Add("wachira.y@aapico.com")
#$mailMessage.To.Add("wajeepradit.p@aapico.com")
foreach($account in  $sendto)
{$mailMessage.To.Add($account)}

$mailMessage.Body = $texthtml
$mailMessage.IsBodyHtml = $true
$mailMessage.Subject = $subject
$smtp.Send($mailMessage)
}
function Invoke-MySqlQuery {
    param (
        [string]$Query
    )
    # MySQL connection details
    $DBUser = "wajeepradit.p"
    $DBPassword = ConvertTo-SecureString -String "Az_123456" -AsPlainText -Force
    $creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $DBUser, $DBPassword
    $Server = "10.10.10.196"
    $Database = "glpi"
    $Port = 3306
    # Open MySQL connection
    $sqlConnect = Open-MySqlConnection -ConnectionName MyDBCon -Server $Server -Database $Database -Port $Port -Credential $creds -WarningAction SilentlyContinue
    # Execute the query
    $data = Invoke-SqlQuery -ConnectionName MyDBCon -Query $Query
    # Close the connection
    Close-SqlConnection -ConnectionName MyDBCon
    # Return the data
    return $data
}


function Get-BlockedItemDetails {
    param (
        [string]$htmlContent
    )
# Load the HTML content into an HtmlDocument object
    $htmlDoc = New-Object 'HtmlAgilityPack.HtmlDocument'
    $htmlDoc.LoadHtml($htmlContent)
    # Function to extract Blocked item details
    $details = @{
        BlockedItemDetails = @{}
        BlockedItemLife = @()
        OccurrencesOnTheNetwork = @()
    }
# Extract Blocked item details
    $blockedItemDetailsTable = $htmlDoc.DocumentNode.SelectSingleNode("//h2[text()='Blocked item details']/following-sibling::table[1]")
    $rows = $blockedItemDetailsTable.SelectNodes(".//tr")
    foreach ($row in $rows) {
        $cells = $row.SelectNodes("th|td")
        if ($cells.Count -eq 2) {
            $key = $cells[0].InnerText.TrimEnd(':')
            $value = $cells[1].InnerText
            $details.BlockedItemDetails[$key] = $value
        }
    }
# Extract Blocked item life cycle
    $blockedItemLifeTable = $htmlDoc.DocumentNode.SelectSingleNode("//h2[text()='Blocked item life cycle']/following-sibling::table[1]")
    $trNodes = $blockedItemLifeTable.SelectNodes(".//tr")
    if ($trNodes -ne $null) {
        for ($index = 1; $index -lt $trNodes.Count; $index++) {
            $Detail = $trNodes[$index].SelectNodes(".//td")
            $object = [PSCustomObject]@{
                Date = if ($Detail[0] -ne $null) { $Detail[0].InnerText.Trim() } else { "" }
                Action =if ($Detail[1] -ne $null) { $Detail[1].InnerText.Trim() } else { "" }
                PathURLRegistryKey = if ($Detail[2] -ne $null) { $Detail[2].InnerText.Trim() } else { "" }
                FileHashRegistryValue = if ($Detail[3] -ne $null) { $Detail[3].InnerText.Trim() } else { "" }
                Trusted = if ($Detail[4] -ne $null) { $Detail[4].InnerText.Trim() } else { "" } 
            }
            $details.BlockedItemLife += $object
        }
    }
# Extract Occurrences on the network
    $occurrencesTable = $htmlDoc.DocumentNode.SelectSingleNode("//h2[text()='Occurrences on the network']/following-sibling::table[1]")
    $trNodes = $occurrencesTable.SelectNodes(".//tr")
    if ($trNodes -ne $null) {
        for ($index = 1; $index -lt $trNodes.Count; $index++) {
            $Detail = $trNodes[$index].SelectNodes(".//td")
            $object = [PSCustomObject]@{
                Computer =if ($Detail[0] -ne $null) { $Detail[0].InnerText.Trim() } else { "" }
                Firstseen =if ($Detail[1] -ne $null) { $Detail[1].InnerText.Trim() } else { "" }
                Filepath =if ($Detail[2] -ne $null) { $Detail[2].InnerText.Trim() } else { "" }
            }
            $details.OccurrencesOnTheNetwork += $object
        }
    }
    return $details
}