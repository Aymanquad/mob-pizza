I/flutter ( 6179): [onboarding] POST https://mob-pizza.onrender.com/api/v1/onboarding payload={locale: en, allowLocation: false, allowNotifications: false, email: kira.note7799@gmail.com, googleId: 116606836138409817343, firstName: Ayman, lastName: Quadri}
D/VRI[SignInHubActivity]( 6179): visibilityChanged oldVisibility=true newVisibility=false
W/WindowOnBackDispatcher( 6179): sendCancelIfRunning: isInProgress=false callback=android.app.Activity$$ExternalSyntheticLambda0@b93265a
D/ViewRootImpl( 6179): Skipping stats log for color mode
D/InsetsController( 6179): hide(ime(), fromIme=false)
I/ImeTracker( 6179): com.mobpizza.app:465cab1e: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/flutter ( 6179): [onboarding] status=200 body={"success":true,"message":"Onboarding saved","data":{"preferences":{"allergies":[],"dietary":[],"spiceLevel":"medium"},"consents":{"location":false,"notifications":false},"_id":"6946fefbd3c5938e7b905c12","googleId":"116606836138409817343","addresses":[],"cart":[],"createdAt":"2025-12-20T19:54:34.959Z","email":"kira.note7799@gmail.com","emailVerified":true,"favorites":[],"firstName":"Ayman","isActive":true,"lastName":"Quadri","lastOrderAt":null,"locale":"en","loyaltyPoints":0,"onboardingAt":"2025-12-20T19:55:05.049Z","onboardingCompleted":true,"ordersCount":0,"paymentMethods":[],"phone":null,"phoneVerified":false,"profileImage":null,"role":"customer","updatedAt":"2025-12-20T19:55:05.049Z","fullName":"Ayman Quadri","defaultAddress":null,"id":"6946fefbd3c5938e7b905c12"}}
I/flutter ( 6179): [onboarding_ui] saved locally, navigating home
W/WindowOnBackDispatcher( 6179): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@23a81a2
Lost connection to device.
Terminate batch job (Y/N)? y
PS C:\Users\MOHMMED AYMAN QUADRI\Desktop\mob-pizza\apps\mobile> flutter clean  
Deleting build...                                                  859ms
Deleting .dart_tool...                                               8ms
Deleting ephemeral...                                                1ms
Deleting Generated.xcconfig...                                       0ms
Deleting flutter_export_environment.sh...                            0ms
Deleting ephemeral...                                                1ms
Deleting ephemeral...                                                1ms
Deleting ephemeral...                                                1ms
Deleting .flutter-plugins-dependencies...                            0ms
PS C:\Users\MOHMMED AYMAN QUADRI\Desktop\mob-pizza\apps\mobile> flutter pub get
Resolving dependencies... 
Downloading packages... 
  characters 1.4.0 (1.4.1 available)
  flutter_lints 3.0.2 (6.0.0 available)
  go_router 14.8.1 (17.0.1 available)
  google_sign_in 6.3.0 (7.2.0 available)
  google_sign_in_android 6.2.1 (7.2.7 available)
  google_sign_in_ios 5.9.0 (6.2.4 available)
  google_sign_in_platform_interface 2.5.0 (3.1.0 available)
  google_sign_in_web 0.12.4+4 (1.1.0 available)
  lints 3.0.0 (6.0.0 available)
  matcher 0.12.17 (0.12.18 available)
  material_color_utilities 0.11.1 (0.13.0 available)
  meta 1.16.0 (1.17.0 available)
  permission_handler 11.4.0 (12.0.1 available)
  permission_handler_android 12.1.0 (13.0.1 available)
  test_api 0.7.6 (0.7.8 available)
Got dependencies!
15 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
PS C:\Users\MOHMMED AYMAN QUADRI\Desktop\mob-pizza\apps\mobile> flutter run
Launching lib\main.dart on sdk gphone64 x86 64 in debug mode...
warning: [options] source value 8 is obsolete and will be removed in a future release
warning: [options] target value 8 is obsolete and will be removed in a future release
warning: [options] To suppress warnings about obsolete options, use -Xlint:-options.
3 warnings
Running Gradle task 'assembleDebug'...                             31.6s
√ Built build\app\outputs\flutter-apk\app-debug.apk
Installing build\app\outputs\flutter-apk\app-debug.apk...        1,261ms
D/FlutterJNI( 6447): Beginning load of flutter...
D/FlutterJNI( 6447): flutter (null) was loaded normally!
I/flutter ( 6447): [IMPORTANT:flutter/shell/platform/android/android_context_gl_impeller.cc(104)] Using the Impeller rendering backend (OpenGLES).
Syncing files to device sdk gphone64 x86 64...                     162ms

Flutter run key commands.
r Hot reload.
R Hot restart.
h List all available interactive commands.
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
q Quit (terminate the application on the device).

A Dart VM Service on sdk gphone64 x86 64 is available at: http://127.0.0.1:59958/0-2bjxo2xvg=/
I/Choreographer( 6447): Skipped 130 frames!  The application may be doing too much work on its main thread.
I/om.mobpizza.app( 6447): Compiler allocated 5042KB to compile void android.view.ViewRootImpl.performTraversals()
I/WindowExtensionsImpl( 6447): Initializing Window Extensions, vendor API level=9, activity embedding enabled=true
The Flutter DevTools debugger and profiler on sdk gphone64 x86 64 is available at: http://127.0.0.1:9101?uri=http://127.0.0.1:59958/0-2bjxo2xvg=/
I/om.mobpizza.app( 6447): AssetManager2(0x759b56aa8038) locale list changing from [] to [en-US]
I/Choreographer( 6447): Skipped 77 frames!  The application may be doing too much work on its main thread.
I/HWUI    ( 6447): Davey! duration=1362ms; Flags=1, FrameTimelineVsyncId=315729, IntendedVsync=5472136539378, Vsync=5473419872660, InputEventId=0, HandleInputStart=5473425969040, A
nimationStart=5473425986640, PerformTraversalsStart=5473426243140, DrawStart=5473435337940, FrameDeadline=5472153206044, FrameStartTime=5473425451540, FrameInterval=16666666, Workl
oadTarget=16666666, SyncQueued=5473437875140, SyncStart=5473440090640, IssueDrawCommandsStart=5473440882740, SwapBuffers=5473474336540, FrameCompleted=5473501564140, DequeueBufferDuration=24418900, QueueBufferDuration=352000, GpuCompleted=5473487244140, SwapBuffersCompleted=5473501564140, DisplayPresentTime=0, CommandSubmissionCompleted=5473474336540,       
D/WindowLayoutComponentImpl( 6447): Register WindowLayoutInfoListener on Context=com.mobpizza.app.MainActivity@6a935f6, of which baseContext=android.app.ContextImpl@74e7201
D/ProfileInstaller( 6447): Installing profile for com.mobpizza.app
D/InsetsController( 6447): hide(ime(), fromIme=false)
I/ImeTracker( 6447): com.mobpizza.app:8f282250: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/om.mobpizza.app( 6447): NativeAlloc concurrent mark compact GC freed 2685KB AllocSpace bytes, 10(308KB) LOS objects, 49% free, 2576KB/5152KB, paused 2.281ms,33.432ms total 76.258ms
D/AutofillManager( 6447): Fill dialog is enabled:false, hints=[]
D/InsetsController( 6447): hide(ime(), fromIme=false)
I/ImeTracker( 6447): com.mobpizza.app:f90a11ee: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/flutter ( 6447): [onboarding_ui] submitting...
I/flutter ( 6447): [onboarding] POST https://mob-pizza.onrender.com/api/v1/onboarding payload={locale: en, allowLocation: false, allowNotifications: false, email: kira.note7799@gmail.com, googleId: 116606836138409817343, firstName: Ayman, lastName: Quadri}
D/VRI[SignInHubActivity]( 6447): visibilityChanged oldVisibility=true newVisibility=false
W/WindowOnBackDispatcher( 6447): sendCancelIfRunning: isInProgress=false callback=android.app.Activity$$ExternalSyntheticLambda0@2d5b88d
D/ViewRootImpl( 6447): Skipping stats log for color mode
D/InsetsController( 6447): hide(ime(), fromIme=false)
I/ImeTracker( 6447): com.mobpizza.app:b6035b6a: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/flutter ( 6447): [onboarding] status=200 body={"success":true,"message":"Onboarding saved","data":{"preferences":{"allergies":[],"dietary":[],"spiceLevel":"medium"},"consents":{"
location":false,"notifications":false},"_id":"6946fefbd3c5938e7b905c12","googleId":"116606836138409817343","addresses":[],"cart":[],"createdAt":"2025-12-20T19:54:34.959Z","email":"
kira.note7799@gmail.com","emailVerified":true,"favorites":[],"firstName":"Ayman","isActive":true,"lastName":"Quadri","lastOrderAt":null,"locale":"en","loyaltyPoints":0,"onboardingA
t":"2025-12-20T20:00:13.867Z","onboardingCompleted":true,"ordersCount":0,"paymentMethods":[],"phone":null,"phoneVerified":false,"profileImage":null,"role":"customer","updatedAt":"2025-12-20T20:00:13.867Z","fullName":"Ayman Quadri","defaultAddress":null,"id":"6946fefbd3c5938e7b905c12"}}
I/flutter ( 6447): [onboarding_ui] saved locally, navigating home
W/WindowOnBackDispatcher( 6447): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@d5fe331
I/om.mobpizza.app( 6447): AssetManager2(0x759b56ad19d8) locale list changing from [] to [en-US]
W/WindowOnBackDispatcher( 6447): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@d5fe331
D/AutofillManager( 6447): Fill dialog is enabled:false, hints=[]
I/flutter ( 6447): [onboarding_ui] submitting...
I/flutter ( 6447): [onboarding] POST https://mob-pizza.onrender.com/api/v1/onboarding payload={locale: en, allowLocation: false, allowNotifications: false, email: aymanbod04@gmail.com, googleId: 109847488579231149428, firstName: Ayman}
D/VRI[SignInHubActivity]( 6447): visibilityChanged oldVisibility=true newVisibility=false
W/om.mobpizza.app( 6447): Cleared Reference was only reachable from finalizer (only reported once)
I/om.mobpizza.app( 6447): Background concurrent mark compact GC freed 1049KB AllocSpace bytes, 24(1248KB) LOS objects, 49% free, 2824KB/5649KB, paused 1.423ms,11.751ms total 169.877ms
D/InsetsController( 6447): hide(ime(), fromIme=false)
I/ImeTracker( 6447): com.mobpizza.app:b9bcf6c8: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
W/WindowOnBackDispatcher( 6447): sendCancelIfRunning: isInProgress=false callback=android.app.Activity$$ExternalSyntheticLambda0@537ec50
D/ViewRootImpl( 6447): Skipping stats log for color mode
I/flutter ( 6447): [onboarding] status=500 body=<!DOCTYPE html>
I/flutter ( 6447): <html lang="en">
I/flutter ( 6447): <head>
I/flutter ( 6447): <meta charset="utf-8">
I/flutter ( 6447): <title>Error</title>
I/flutter ( 6447): </head>
I/flutter ( 6447): <body>
I/flutter ( 6447): <pre>Internal Server Error</pre>
I/flutter ( 6447): </body>
I/flutter ( 6447): </html>
I/flutter ( 6447):
I/flutter ( 6447): [onboarding_ui] error: Exception: Onboarding failed (500)


