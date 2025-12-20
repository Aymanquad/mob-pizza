frontend logs :::

warning: [options] source value 8 is obsolete and will be removed in a future release
warning: [options] target value 8 is obsolete and will be removed in a future release
warning: [options] To suppress warnings about obsolete options, use -Xlint:-options.
3 warnings
Running Gradle task 'assembleDebug'...                             32.1s
√ Built build\app\outputs\flutter-apk\app-debug.apk
Installing build\app\outputs\flutter-apk\app-debug.apk...        1,378ms
D/FlutterJNI( 7279): Beginning load of flutter...
D/FlutterJNI( 7279): flutter (null) was loaded normally!
I/flutter ( 7279): [IMPORTANT:flutter/shell/platform/android/android_context_gl_impeller.cc(104)] Using the Impeller rendering backend (OpenGLES).
Syncing files to device sdk gphone64 x86 64...                     159ms

Flutter run key commands.
r Hot reload.
R Hot restart.
h List all available interactive commands.
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
q Quit (terminate the application on the device).

A Dart VM Service on sdk gphone64 x86 64 is available at: http://127.0.0.1:57790/LY5YgYVh_Oo=/
I/Choreographer( 7279): Skipped 168 frames!  The application may be doing too much work on its main thread.
The Flutter DevTools debugger and profiler on sdk gphone64 x86 64 is available at: http://127.0.0.1:9101?uri=http://127.0.0.1:57790/LY5YgYVh_Oo=/
I/om.mobpizza.app( 7279): Compiler allocated 5042KB to compile void android.view.ViewRootImpl.performTraversals()
I/WindowExtensionsImpl( 7279): Initializing Window Extensions, vendor API level=9, activity embedding enabled=true
I/om.mobpizza.app( 7279): AssetManager2(0x759b56a9ed58) locale list changing from [] to [en-US]
I/Choreographer( 7279): Skipped 57 frames!  The application may be doing too much work on its main thread.
D/ProfileInstaller( 7279): Installing profile for com.mobpizza.app
D/WindowLayoutComponentImpl( 7279): Register WindowLayoutInfoListener on Context=com.mobpizza.app.MainActivity@965f6cd, of which baseContext=android.app.ContextImpl@a76d10b        
D/InsetsController( 7279): hide(ime(), fromIme=false)
I/ImeTracker( 7279): com.mobpizza.app:dffb218e: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
D/AutofillManager( 7279): Fill dialog is enabled:false, hints=[]
D/InsetsController( 7279): hide(ime(), fromIme=false)
I/ImeTracker( 7279): com.mobpizza.app:3c3e101b: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/flutter ( 7279): [onboarding_ui] submitting...
I/flutter ( 7279): [onboarding] POST https://mob-pizza.onrender.com/api/v1/onboarding payload={locale: en, allowLocation: false, allowNotifications: false, email: aymanbod04@gmail.com, googleId: 109847488579231149428, firstName: Ayman}
D/VRI[SignInHubActivity]( 7279): visibilityChanged oldVisibility=true newVisibility=false
W/WindowOnBackDispatcher( 7279): sendCancelIfRunning: isInProgress=false callback=android.app.Activity$$ExternalSyntheticLambda0@8802f90
D/ViewRootImpl( 7279): Skipping stats log for color mode
D/InsetsController( 7279): hide(ime(), fromIme=false)
I/ImeTracker( 7279): com.mobpizza.app:747f94bb: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/flutter ( 7279): [onboarding] status=500 body=<!DOCTYPE html>
I/flutter ( 7279): <html lang="en">
I/flutter ( 7279): <head>
I/flutter ( 7279): <meta charset="utf-8">
I/flutter ( 7279): <title>Error</title>
I/flutter ( 7279): </head>
I/flutter ( 7279): <body>
I/flutter ( 7279): <pre>Internal Server Error</pre>
I/flutter ( 7279): </body>
I/flutter ( 7279): </html>
I/flutter ( 7279):
I/flutter ( 7279): [onboarding_ui] error: Exception: Onboarding failed (500)



backend logs ::::

==> Running 'npm run dev'
> mob-pizza-backend@0.1.0 dev
> node server.js
Mongoose connected to MongoDB
MongoDB connected to: ac-vjygqnf-shard-00-00.ax0nlid.mongodb.net
Database: mob-pizza
API listening on port 10000
==> Your service is live 🎉
==> 
==> ///////////////////////////////////////////////////////////
==> 
==> Available at your primary URL https://mob-pizza.onrender.com
==> 
==> ///////////////////////////////////////////////////////////
[onboarding] payload {
  phone: undefined,
  email: 'aymanbod04@gmail.com',
  googleId: '109847488579231149428',
  firstName: 'Ayman',
  lastName: undefined,
  locale: 'en',
  allowLocation: false,
  allowNotifications: false,
  ts: '2025-12-20T20:23:47.633Z'
}
[onboarding] validation check {
  isOAuthFlow: true,
  isPhoneFlow: false,
  hasEmail: true,
  hasGoogleId: true,
  hasPhone: false
}
[onboarding] error MongoServerError: Plan executor error during findAndModify :: caused by :: E11000 duplicate key error collection: mob-pizza.users index: phone_1 dup key: { phone: null }
    at Connection.onMessage (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/connection.js:202:26)
    at MessageStream.<anonymous> (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/connection.js:61:60)
    at MessageStream.emit (node:events:518:28)
    at processIncomingData (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/message_stream.js:124:16)
    at MessageStream._write (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/message_stream.js:33:9)
    at writeOrBuffer (node:internal/streams/writable:572:12)
    at _write (node:internal/streams/writable:501:10)
    at Writable.write (node:internal/streams/writable:510:10)
    at TLSSocket.ondata (node:internal/streams/readable:1009:22)
    at TLSSocket.emit (node:events:518:28) {
  ok: 0,
  code: 11000,
  codeName: 'DuplicateKey',
  keyPattern: { phone: 1 },
  keyValue: { phone: null },
  '$clusterTime': {
    clusterTime: new Timestamp({ t: 1766262224, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("NoFOCqEywVZwtJcmb4jeBL6DQNY=", 0),
      keyId: new Long("7522352073225011201")
    }
  },
  operationTime: new Timestamp({ t: 1766262224, i: 1 }),
  [Symbol(errorLabels)]: Set(0) {}
}
MongoServerError: Plan executor error during findAndModify :: caused by :: E11000 duplicate key error collection: mob-pizza.users index: phone_1 dup key: { phone: null }
    at Connection.onMessage (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/connection.js:202:26)
    at MessageStream.<anonymous> (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/connection.js:61:60)
    at MessageStream.emit (node:events:518:28)
    at processIncomingData (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/message_stream.js:124:16)
    at MessageStream._write (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/message_stream.js:33:9)
    at writeOrBuffer (node:internal/streams/writable:572:12)
    at _write (node:internal/streams/writable:501:10)
    at Writable.write (node:internal/streams/writable:510:10)
    at TLSSocket.ondata (node:internal/streams/readable:1009:22)
    at TLSSocket.emit (node:events:518:28)