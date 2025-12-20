#!/bin/bash
# Script to get SHA-1 fingerprint for Google Sign-In setup

echo "Getting SHA-1 fingerprint for Google Sign-In..."
echo ""

# Check if debug keystore exists
DEBUG_KEYSTORE="$HOME/.android/debug.keystore"

if [ -f "$DEBUG_KEYSTORE" ]; then
    echo "Debug keystore found. Getting SHA-1..."
    echo ""
    
    # Get SHA-1 from debug keystore
    keytool -list -v -keystore "$DEBUG_KEYSTORE" -alias androiddebugkey -storepass android -keypass android 2>/dev/null | grep -A 1 "SHA1:" | head -2
    
    echo ""
    echo "Copy the SHA-1 fingerprint above and add it to:"
    echo "1. Google Cloud Console > APIs & Services > Credentials"
    echo "2. Create OAuth 2.0 Client ID for Android"
    echo "3. Package name: com.mobpizza.app"
    echo ""
else
    echo "Debug keystore not found at: $DEBUG_KEYSTORE"
    echo ""
    echo "For release builds, use:"
    echo "keytool -list -v -keystore upload-keystore.jks -alias <your-key-alias>"
fi

