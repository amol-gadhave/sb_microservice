$param1=$args[0]
# Path to the file
$filePath1 = "C:\xstore\xstore.properties"
$filePath2 = "C:\xstore\updates\xstore_$param1.properties"
$filePath3 = "C:\xstore-mobile\xstore_mobile.properties"

# Read all lines
$content1 = Get-Content $filePath1
$content2 = Get-Content $filePath2
$content3 = Get-Content $filePath3

# Define the exact keys to flip values for
$keysToUpdate1 = @(
    "lev.shipping.rtv.enable",
    "lev.shipping.rtvfromecom.enable",
    "lev.shipping.rtvfromdamaged.enable"
)
$keysToUpdate2 = @(
    "lev.shipping.rtdc.enable",
    "lev.shipping.rtdcfromecom.enable",
    "lev.shipping.rtdcfromdamaged.enable"
)

# Update only the matching lines
$updatedContent1 = $content1 | ForEach-Object {
    $line = $_
    foreach ($key in $keysToUpdate1) {
        if ($line -like "$key=*") {
            if ($line -match '= true$' -or $line -match '=true$') {
                $line = "$key=false"
            } 
            break
        }
    }
    $line
}
$updatedContent11 = $updatedContent1 | ForEach-Object {
    $line = $_
    foreach ($key in $keysToUpdate2) {
        if ($line -like "$key=*") {
            if ($line -match '= false$' -or $line -match '=false$') {
                $line = "$key=true"
            } 
            break
        }
    }
    $line
}
$updatedContent2 = $content2 | ForEach-Object {
    $line = $_
    foreach ($key in $keysToUpdate1) {
        if ($line -like "$key=*") {
            if ($line -match '= true$' -or $line -match '=true$') {
                $line = "$key=false"
            } 
            break
        }
    }
    $line
}
$updatedContent22 = $updatedContent2 | ForEach-Object {
    $line = $_
    foreach ($key in $keysToUpdate2) {
        if ($line -like "$key=*") {
            if ($line -match '= false$' -or $line -match '=false$') {
                $line = "$key=true"
            } 
            break
        }
    }
    $line
}

$updatedContent3 = $content3 | ForEach-Object {
    $line = $_
    foreach ($key in $keysToUpdate1) {
        if ($line -like "$key=*") {
            if ($line -match '= true$' -or $line -match '=true$') {
                $line = "$key=false"
            } 
            break
        }
    }
    $line
}
$updatedContent33 = $updatedContent3 | ForEach-Object {
    $line = $_
    foreach ($key in $keysToUpdate2) {
        if ($line -like "$key=*") {
            if ($line -match '= false$' -or $line -match '=false$') {
                $line = "$key=true"
            } 
            break
        }
    }
    $line
}
# Save the modified content back to the file
$updatedContent11 | Set-Content $filePath1
$updatedContent22 | Set-Content $filePath2
$updatedContent33 | Set-Content $filePath3
