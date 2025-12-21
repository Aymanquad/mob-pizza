I/flutter ( 4227): [IMPORTANT:flutter/shell/platform/android/android_context_gl_impeller.cc(104)] Using the Impeller rendering backend (OpenGLES).
Syncing files to device sdk gphone64 x86 64...                     148ms

Flutter run key commands.
r Hot reload.
R Hot restart.
h List all available interactive commands.
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
q Quit (terminate the application on the device).

A Dart VM Service on sdk gphone64 x86 64 is available at: http://127.0.0.1:50913/M0JhmfxS1TA=/
The Flutter DevTools debugger and profiler on sdk gphone64 x86 64 is available at: http://127.0.0.1:9101?uri=http://127.0.0.1:50913/M0JhmfxS1TA=/
I/Choreographer( 4227): Skipped 115 frames!  The application may be doing too much work on its main thread.
I/om.mobpizza.app( 4227): Compiler allocated 5042KB to compile void android.view.ViewRootImpl.performTraversals()
I/WindowExtensionsImpl( 4227): Initializing Window Extensions, vendor API level=9, activity embedding enabled=true
I/om.mobpizza.app( 4227): AssetManager2(0x72566bf2d438) locale list changing from [] to [en-US]
I/Choreographer( 4227): Skipped 40 frames!  The application may be doing too much work on its main thread.
I/HWUI    ( 4227): Davey! duration=734ms; Flags=1, FrameTimelineVsyncId=7171, IntendedVsync=88809941512, Vsync=89476608152, InputEventId=0, HandleInputStart=89481792000, AnimationS
tart=89481987000, PerformTraversalsStart=89482066500, DrawStart=89497245400, FrameDeadline=88826608178, FrameStartTime=89481259400, FrameInterval=16666666, WorkloadTarget=16666666,
 SyncQueued=89498058600, SyncStart=89500986300, IssueDrawCommandsStart=89501230600, SwapBuffers=89523658600, FrameCompleted=89547629000, DequeueBufferDuration=22539500, QueueBufferDuration=391500, GpuCompleted=89528762600, SwapBuffersCompleted=89547629000, DisplayPresentTime=929, CommandSubmissionCompleted=89523658600,
D/WindowLayoutComponentImpl( 4227): Register WindowLayoutInfoListener on Context=com.mobpizza.app.MainActivity@612f212, of which baseContext=android.app.ContextImpl@a467a36        
D/InsetsController( 4227): hide(ime(), fromIme=false)
I/ImeTracker( 4227): com.mobpizza.app:ef588441: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
D/ProfileInstaller( 4227): Installing profile for com.mobpizza.app
D/AutofillManager( 4227): Fill dialog is enabled:false, hints=[]
D/InsetsController( 4227): hide(ime(), fromIme=false)
I/ImeTracker( 4227): com.mobpizza.app:a70356b3: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/flutter ( 4227): [onboarding_ui] submitting...
I/flutter ( 4227): [onboarding] POST https://mob-pizza.onrender.com/api/v1/onboarding payload={locale: en, allowLocation: false, allowNotifications: false, email: mohammedaymanquadri@gmail.com, googleId: 107908793667499473647, firstName: Mohammed, lastName: ayman Quadri}
D/VRI[SignInHubActivity]( 4227): visibilityChanged oldVisibility=true newVisibility=false
W/WindowOnBackDispatcher( 4227): sendCancelIfRunning: isInProgress=false callback=android.app.Activity$$ExternalSyntheticLambda0@ed685a3
D/ViewRootImpl( 4227): Skipping stats log for color mode
D/InsetsController( 4227): hide(ime(), fromIme=false)
I/ImeTracker( 4227): com.mobpizza.app:ca31ed77: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/flutter ( 4227): [onboarding] status=200 body={"success":true,"message":"Onboarding saved","data":{"firstName":"Mohammed","lastName":"ayman Quadri","email":"mohammedaymanquadri@g
mail.com","googleId":"107908793667499473647","profileImage":null,"role":"customer","preferences":{"dietary":[],"spiceLevel":"medium","allergies":[]},"loyaltyPoints":0,"isActive":tr
ue,"emailVerified":true,"phoneVerified":false,"locale":"en","consents":{"location":false,"notifications":false},"onboardingCompleted":true,"onboardingAt":"2025-12-21T08:42:49.784Z"
,"favorites":[],"ordersCount":0,"lastOrderAt":null,"_id":"6947b30a07ff0675c609dff3","addresses":[],"paymentMethods":[],"cart":[],"createdAt":"2025-12-21T08:42:50.021Z","updatedAt":"2025-12-21T08:42:50.021Z","fullName":"Mohammed ayman Quadri","defaultAddress":null,"id":"6947b30a07ff0675c609dff3"}}
I/flutter ( 4227): [onboarding_ui] saved locally, navigating home
W/WindowOnBackDispatcher( 4227): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@b893d7e
I/flutter ( 4227): [user_service] GET https://mob-pizza.onrender.com/api/v1/users/mohammedaymanquadri@gmail.com
I/flutter ( 4227): [user_service] status=200 body={"success":true,"data":{"preferences":{"dietary":[],"spiceLevel":"medium","allergies":[]},"consents":{"location":false,"notificati
ons":false},"_id":"6947b30a07ff0675c609dff3","firstName":"Mohammed","lastName":"ayman Quadri","email":"mohammedaymanquadri@gmail.com","googleId":"107908793667499473647","profileIma
ge":null,"role":"customer","loyaltyPoints":0,"isActive":true,"emailVerified":true,"phoneVerified":false,"locale":"en","onboardingCompleted":true,"onboardingAt":"2025-12-21T08:42:49
.784Z","favorites":[],"ordersCount":0,"lastOrderAt":null,"addresses":[],"paymentMethods":[],"cart":[],"createdAt":"2025-12-21T08:42:50.021Z","updatedAt":"2025-12-21T08:42:50.021Z","fullName":"Mohammed ayman Quadri","defaultAddress":null,"id":"6947b30a07ff0675c609dff3"}}
I/om.mobpizza.app( 4227): AssetManager2(0x72566bf61cd8) locale list changing from [] to [en-US]
W/WindowOnBackDispatcher( 4227): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@b893d7e
W/WindowOnBackDispatcher( 4227): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@b893d7e
I/ImeTracker( 4227): com.mobpizza.app:1afbd68: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 4227): show(ime(), fromIme=false)
D/InsetsController( 4227): Setting requestedVisibleTypes to -1 (was -9)
D/InputConnectionAdaptor( 4227): The input method toggled cursor monitoring on
W/InteractionJankMonitor( 4227): Initializing without READ_DEVICE_CONFIG permission. enabled=true, interval=1, missedFrameThreshold=3, frameTimeThreshold=64, package=com.mobpizza.app
W/om.mobpizza.app( 4227): Cleared Reference was only reachable from finalizer (only reported once)
I/ImeTracker( 4227): com.mobpizza.app:1afbd68: onShown
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 17081, 29619752, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 17117, 28231586, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 17146, 49913820, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 17168, 43125754, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 17198, 13838722, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 17249, 45091390, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 17292, 47104824, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 17342, 30323992, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 17371, 24093726, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 17407, 23506960, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
V/PerfettoTrigger( 4227): Not triggering com.android.telemetry.interaction-jank-monitor-80 - not enough time since last trigger
I/ImeTracker( 4227): com.mobpizza.app:f4883d4d: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 4227): show(ime(), fromIme=false)
I/ImeTracker( 4227): com.mobpizza.app:f4883d4d: onCancelled at PHASE_CLIENT_APPLY_ANIMATION
D/InputConnectionAdaptor( 4227): The input method toggled cursor monitoring on
I/flutter ( 4227): [order_service] POST https://mob-pizza.onrender.com/api/v1/orders/8106020049
I/flutter ( 4227): [order_service] status=404 body={"success":false,"message":"User not found"}
I/flutter ( 4227): [order_service] error creating order: Exception: Failed to create order: 404
I/flutter ( 4227): [OrderProvider] API error, saving locally: Exception: Failed to create order: 404
I/flutter ( 4227): [cart_service] DELETE https://mob-pizza.onrender.com/api/v1/cart/8106020049 (clear)
I/flutter ( 4227): [cart_service] status=404 body={"success":false,"message":"User not found"}
I/flutter ( 4227): [cart_service] error clearing cart: Exception: Failed to clear cart: 404
I/flutter ( 4227): [CartProvider] API error, clearing locally: Exception: Failed to clear cart: 404
I/flutter ( 4227): [user_service] GET https://mob-pizza.onrender.com/api/v1/users/8106020049
W/WindowOnBackDispatcher( 4227): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@b893d7e
I/ImeTracker( 4227): com.mobpizza.app:308f3170: onRequestHide at ORIGIN_CLIENT reason HIDE_SOFT_INPUT fromUser false
D/InsetsController( 4227): hide(ime(), fromIme=false)
W/WindowOnBackDispatcher( 4227): sendCancelIfRunning: isInProgress=false callback=android.view.ImeBackAnimationController@4ba2ad
D/InsetsController( 4227): Setting requestedVisibleTypes to -9 (was -1)
D/CompatChangeReporter( 4227): Compat change id reported: 395521150; UID 10221; state: ENABLED
I/ImeTracker( 4227): system_server:5dabf5e0: onCancelled at PHASE_CLIENT_ON_CONTROLS_CHANGED
W/FrameTracker( 4227): Missed App frame:UNKNOWN: 3, 20673, 25486630, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:UNKNOWN: 3, 20673, 25486630, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 20687, 30794064, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 20709, 24637998, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 20724, 24904532, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 20746, 32860266, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 20769, 6371334, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 20791, 5788568, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 20813, 6278202, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 20835, 6077136, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 20857, 7251770, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 20879, 5954704, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4227): Missed SF frame:JANK_COMPOSER, 20901, 6640538, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
V/PerfettoTrigger( 4227): Not triggering com.android.telemetry.interaction-jank-monitor-81 - not enough time since last trigger
I/flutter ( 4227): [user_service] status=404 body={"success":false,"message":"User not found"}
I/flutter ( 4227): [user_service] error fetching profile: Exception: Failed to fetch profile: 404
I/flutter ( 4227): [AuthService] Error fetching user role, using phone fallback: Exception: Failed to fetch profile: 404
I/flutter ( 4227): [AuthService] Phone check result: false (phone: 8106020049, normalized: 8106020049)
I/flutter ( 4227): [user_service] GET https://mob-pizza.onrender.com/api/v1/users/8106020049
I/flutter ( 4227): [user_service] status=404 body={"success":false,"message":"User not found"}
I/flutter ( 4227): [user_service] error fetching profile: Exception: Failed to fetch profile: 404
I/flutter ( 4227): [profile] Could not fetch from backend: Exception: Failed to fetch profile: 404
I/om.mobpizza.app( 4227): AssetManager2(0x72566bf9c338) locale list changing from [] to [en-US]
I/om.mobpizza.app( 4227): AssetManager2(0x72566bf764f8) locale list changing from [] to [en-US]
W/WindowOnBackDispatcher( 4227): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@b893d7e

