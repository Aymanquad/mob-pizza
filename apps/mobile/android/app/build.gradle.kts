plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Load keystore properties manually
fun loadKeystoreProperties(): Map<String, String> {
    val keystorePropertiesFile = rootProject.file("key.properties")
    val properties = mutableMapOf<String, String>()
    if (keystorePropertiesFile.exists()) {
        keystorePropertiesFile.readLines().forEach { line ->
            val trimmed = line.trim()
            if (trimmed.isNotEmpty() && !trimmed.startsWith("#")) {
                val parts = trimmed.split("=", limit = 2)
                if (parts.size == 2) {
                    properties[parts[0].trim()] = parts[1].trim()
                }
            }
        }
    }
    return properties
}

val keystoreProperties = loadKeystoreProperties()

android {
    namespace = "com.mobpizza.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.mobpizza.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val keystorePropertiesFile = rootProject.file("key.properties")
            val keystoreFile = rootProject.file("upload-keystore.jks")
            if (keystorePropertiesFile.exists() && keystoreFile.exists() && keystoreProperties.isNotEmpty()) {
                val keyAliasValue = keystoreProperties["keyAlias"] ?: ""
                val keyPasswordValue = keystoreProperties["keyPassword"] ?: ""
                val storeFileProperty = keystoreProperties["storeFile"] ?: ""
                val storePasswordValue = keystoreProperties["storePassword"] ?: ""
                
                if (keyAliasValue.isNotEmpty() && keyPasswordValue.isNotEmpty() && 
                    storeFileProperty.isNotEmpty() && storePasswordValue.isNotEmpty()) {
                    keyAlias = keyAliasValue
                    keyPassword = keyPasswordValue
                    storeFile = rootProject.file(storeFileProperty)
                    storePassword = storePasswordValue
                }
            }
        }
    }

    buildTypes {
        release {
            val keystorePropertiesFile = rootProject.file("key.properties")
            val keystoreFile = rootProject.file("upload-keystore.jks")
            val hasValidSigning = keystorePropertiesFile.exists() && 
                                   keystoreFile.exists() && 
                                   keystoreProperties.isNotEmpty() &&
                                   keystoreProperties["keyAlias"]?.isNotEmpty() == true &&
                                   keystoreProperties["keyPassword"]?.isNotEmpty() == true &&
                                   keystoreProperties["storeFile"]?.isNotEmpty() == true &&
                                   keystoreProperties["storePassword"]?.isNotEmpty() == true
            
            signingConfig = if (hasValidSigning) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
