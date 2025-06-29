plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // ✅ Google services plugin applied here
}

android {
    namespace = "com.example.dapur_mak_long_app"
    compileSdk = flutter.compileSdkVersion  // Use Flutter's compile SDK version

    ndkVersion = "27.0.12077973"  // Use the specific NDK version if needed

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()  // Ensure compatibility with Java 11
    }

    defaultConfig {
        namespace = "com.example.dapur_mak_long_app"
        minSdk = flutter.minSdkVersion  // Use Flutter's minimum SDK version
        targetSdk = flutter.targetSdkVersion  // Use Flutter's target SDK version
        versionCode = flutter.versionCode  // Version code from Flutter
        versionName = flutter.versionName  // Version name from Flutter
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")  // Use debug signing for now
        }
    }
}

flutter {
    source = "../.."  // Ensure this points to the correct Flutter project source
}