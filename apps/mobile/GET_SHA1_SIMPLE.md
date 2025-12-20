# How to Get SHA-1 Key - Simple Steps

## Step 1: Open Command Prompt or PowerShell

Press `Windows + R`, type `cmd` or `powershell`, and press Enter.

## Step 2: Navigate to Java's bin folder (if keytool is not in PATH)

Usually located at:
- `C:\Program Files\Java\jdk-XX\bin`
- Or `C:\Program Files (x86)\Java\jdk-XX\bin`

Or if you have Android Studio, it's usually at:
- `C:\Users\YourName\AppData\Local\Android\Sdk\build-tools\XX.X.X`

**OR** just use the command below - it should work if Java is installed.

## Step 3: Run This Command

Copy and paste this entire command:

```cmd
keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```

Press Enter.

## Step 4: Find the SHA-1

Look for a line that says:
```
SHA1: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
```

Copy the entire SHA-1 value (the part after "SHA1: ")

## Step 5: Use It

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your project
3. Go to **APIs & Services** > **Credentials**
4. Click **Create Credentials** > **OAuth client ID**
5. Choose **Android**
6. Paste your SHA-1 in the **SHA-1 certificate fingerprint** field
7. Package name: `com.mobpizza.app`
8. Click **Create**

---

## Alternative: If the command doesn't work

If you get "keytool is not recognized", find where Java is installed:

1. Open Android Studio
2. Go to **File** > **Project Structure** > **SDK Location**
3. Note the JDK location
4. Navigate to that folder's `bin` folder
5. Run the command from there, or add it to your PATH

---

## Quick Copy-Paste Commands

**For Debug Build (Development):**
```cmd
keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```

**For Release Build (Production):**
```cmd
keytool -list -v -keystore "android\upload-keystore.jks" -alias <your-alias-name>
```
(Replace `<your-alias-name>` with your actual key alias)

