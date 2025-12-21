frontend logs :::

Running Gradle task 'assembleDebug'...                             52.5s
√ Built build\app\outputs\flutter-apk\app-debug.apk
Installing build\app\outputs\flutter-apk\app-debug.apk...        1,664ms
D/FlutterJNI( 5020): Beginning load of flutter...
D/FlutterJNI( 5020): flutter (null) was loaded normally!
I/flutter ( 5020): [IMPORTANT:flutter/shell/platform/android/android_context_gl_impeller.cc(104)] Using the Impeller rendering backend (OpenGLES).
Syncing files to device sdk gphone64 x86 64...                     187ms

Flutter run key commands.
r Hot reload.
R Hot restart.
h List all available interactive commands.
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
q Quit (terminate the application on the device).

A Dart VM Service on sdk gphone64 x86 64 is available at: http://127.0.0.1:53779/-pnkTMH8uMU=/
The Flutter DevTools debugger and profiler on sdk gphone64 x86 64 is available at: http://127.0.0.1:9101?uri=http://127.0.0.1:53779/-pnkTMH8uMU=/
I/Choreographer( 5020): Skipped 217 frames!  The application may be doing too much work on its main thread.
I/om.mobpizza.app( 5020): Compiler allocated 5042KB to compile void android.view.ViewRootImpl.performTraversals()
I/WindowExtensionsImpl( 5020): Initializing Window Extensions, vendor API level=9, activity embedding enabled=true
I/om.mobpizza.app( 5020): AssetManager2(0x73c68d829d38) locale list changing from [] to [en-US]
D/ProfileInstaller( 5020): Installing profile for com.mobpizza.app
I/Choreographer( 5020): Skipped 74 frames!  The application may be doing too much work on its main thread.
D/WindowLayoutComponentImpl( 5020): Register WindowLayoutInfoListener on Context=com.mobpizza.app.MainActivity@4db2f19, of which baseContext=android.app.ContextImpl@de9ef90
I/HWUI    ( 5020): Davey! duration=1380ms; Flags=1, FrameTimelineVsyncId=12955, IntendedVsync=418059251716, Vsync=419292585000, InputEventId=0, HandleInputStart=419303009400, Anima
tionStart=419303041300, PerformTraversalsStart=419303081900, DrawStart=419320951600, FrameDeadline=418075918382, FrameStartTime=419301291600, FrameInterval=16666666, WorkloadTarget
=16666666, SyncQueued=419324415600, SyncStart=419326090700, IssueDrawCommandsStart=419328524400, SwapBuffers=419379063600, FrameCompleted=419441573700, DequeueBufferDuration=59470900, QueueBufferDuration=549600, GpuCompleted=419438384700, SwapBuffersCompleted=419441573700, DisplayPresentTime=0, CommandSubmissionCompleted=419379063600,
D/InsetsController( 5020): hide(ime(), fromIme=false)
I/ImeTracker( 5020): com.mobpizza.app:d796863: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
D/AutofillManager( 5020): Fill dialog is enabled:false, hints=[]
D/InsetsController( 5020): hide(ime(), fromIme=false)
I/ImeTracker( 5020): com.mobpizza.app:fba8d67: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/flutter ( 5020): [onboarding_ui] submitting...
I/flutter ( 5020): [onboarding] POST https://mob-pizza.onrender.com/api/v1/onboarding payload={locale: en, allowLocation: false, allowNotifications: false, email: aymanbod04@gmail.com, googleId: 109847488579231149428, firstName: Ayman}
D/VRI[SignInHubActivity]( 5020): visibilityChanged oldVisibility=true newVisibility=false
W/WindowOnBackDispatcher( 5020): sendCancelIfRunning: isInProgress=false callback=android.app.Activity$$ExternalSyntheticLambda0@ec6757f
D/ViewRootImpl( 5020): Skipping stats log for color mode
D/InsetsController( 5020): hide(ime(), fromIme=false)
I/ImeTracker( 5020): com.mobpizza.app:3c179b9: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/flutter ( 5020): [onboarding] status=500 body=<!DOCTYPE html>
I/flutter ( 5020): <html lang="en">
I/flutter ( 5020): <head>
I/flutter ( 5020): <meta charset="utf-8">
I/flutter ( 5020): <title>Error</title>
I/flutter ( 5020): </head>
I/flutter ( 5020): <body>
I/flutter ( 5020): <pre>Internal Server Error</pre>
I/flutter ( 5020): </body>
I/flutter ( 5020): </html>
I/flutter ( 5020):
I/flutter ( 5020): [onboarding_ui] error: Exception: Onboarding failed (500)



backend logs ::::

==> Your service is live 🎉
==> 
==> ///////////////////////////////////////////////////////////
==> 
==> Available at your primary URL https://mob-pizza.onrender.com
==> 
==> ///////////////////////////////////////////////////////////
==> Detected service running on port 10000
==> Docs on specifying a port: https://render.com/docs/web-services#port-binding
[onboarding] payload {
  phone: undefined,
  email: 'aymanbod04@gmail.com',
  googleId: '109847488579231149428',
  firstName: 'Ayman',
  lastName: undefined,
  locale: 'en',
  allowLocation: false,
  allowNotifications: false,
  ts: '2025-12-21T08:18:37.804Z'
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
    clusterTime: new Timestamp({ t: 1766305115, i: 3 }),
    signature: {
      hash: Binary.createFromBase64("NHa0BQdRR4YVrjqsdM9jIy1Sqn0=", 0),
      keyId: new Long("7522352073225011201")
    }
  },
  operationTime: new Timestamp({ t: 1766305115, i: 3 }),
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