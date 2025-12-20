# PowerShell script to get SHA-1 fingerprint for Google Sign-In setup

Write-Host "Getting SHA-1 fingerprint for Google Sign-In..." -ForegroundColor Cyan
Write-Host ""

# Check if debug keystore exists
$debugKeystore = "$env:USERPROFILE\.android\debug.keystore"

if (Test-Path $debugKeystore) {
    Write-Host "Debug keystore found. Getting SHA-1..." -ForegroundColor Green
    Write-Host ""
    
    # Get SHA-1 from debug keystore
    $result = keytool -list -v -keystore $debugKeystore -alias androiddebugkey -storepass android -keypass android 2>&1
    
    # Extract SHA-1
    $sha1Line = $result | Select-String "SHA1:"
    if ($sha1Line) {
        $sha1 = ($sha1Line -split "SHA1:")[1].Trim()
        Write-Host "SHA-1 Fingerprint:" -ForegroundColor Yellow
        Write-Host $sha1 -ForegroundColor White
        Write-Host ""
        Write-Host "Copy this SHA-1 and add it to:" -ForegroundColor Cyan
        Write-Host "1. Google Cloud Console > APIs & Services > Credentials" -ForegroundColor White
        Write-Host "2. Create OAuth 2.0 Client ID for Android" -ForegroundColor White
        Write-Host "3. Package name: com.mobpizza.app" -ForegroundColor White
        Write-Host ""
    } else {
        Write-Host "Could not extract SHA-1. Please run manually:" -ForegroundColor Red
        Write-Host "keytool -list -v -keystore $debugKeystore -alias androiddebugkey -storepass android -keypass android" -ForegroundColor Yellow
    }
} else {
    Write-Host "Debug keystore not found at: $debugKeystore" -ForegroundColor Red
    Write-Host ""
    Write-Host "For release builds, use:" -ForegroundColor Yellow
    Write-Host "keytool -list -v -keystore upload-keystore.jks -alias <your-key-alias>" -ForegroundColor White
}

Write-Host ""
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

