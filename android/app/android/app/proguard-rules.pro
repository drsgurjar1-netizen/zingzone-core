# Flutter Core Obfuscation
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Google Play Services & AdMob
-keep public class com.google.android.gms.ads.** {
   public *;
}
-keep public class com.google.ads.** {
   public *;
}

# WebRTC P2P Voice & Video Engine
-keep class org.webrtc.** { *; }
-dontwarn org.webrtc.**

# Firebase & Firestore Rules
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-dontwarn com.google.firebase.**
-keep class com.google.firebase.** { *; }

# Security: Scramble Names & Remove Line Numbers in Release
-repackageclasses ''
-allowaccessmodification
