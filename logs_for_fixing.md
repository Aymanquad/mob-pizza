[onboarding] validation check {
  isOAuthFlow: undefined,
  isPhoneFlow: true,
  hasEmail: false,
  hasGoogleId: false,
  hasPhone: true
}
[onboarding] error MongoServerError: E11000 duplicate key error collection: mob-pizza.users index: email_1 dup key: { email: null }
    at /opt/render/project/src/apps/backend/node_modules/mongodb/lib/operations/insert.js:50:33
    at /opt/render/project/src/apps/backend/node_modules/mongodb/lib/operations/command.js:84:64
    at process.processTicksAndRejections (node:internal/process/task_queues:105:5) {
  index: 0,
  code: 11000,
  keyPattern: { email: 1 },
  keyValue: { email: null },
  [Symbol(errorLabels)]: Set(0) {}
}
MongoServerError: E11000 duplicate key error collection: mob-pizza.users index: email_1 dup key: { email: null }
    at /opt/render/project/src/apps/backend/node_modules/mongodb/lib/operations/insert.js:50:33
    at /opt/render/project/src/apps/backend/node_modules/mongodb/lib/operations/command.js:84:64
    at process.processTicksAndRejections (node:internal/process/task_queues:105:5)
[user] fetching profile for identifier: 8106020051
[user] fetching profile for identifier: 8106020051
[user] fetching profile for identifier: 8106020051
[onboarding] payload {
  phone: '8106020049',
  email: undefined,
  googleId: undefined,
  firstName: undefined,
  lastName: undefined,
  locale: 'en',
  allowLocation: true,
  allowNotifications: true,
  ts: '2026-01-18T10:31:33.468Z'
}
[onboarding] validation check {
  isOAuthFlow: undefined,
  isPhoneFlow: true,
  hasEmail: false,
  hasGoogleId: false,
  hasPhone: true
}
[onboarding] error MongoServerError: E11000 duplicate key error collection: mob-pizza.users index: email_1 dup key: { email: null }
    at /opt/render/project/src/apps/backend/node_modules/mongodb/lib/operations/insert.js:50:33
    at /opt/render/project/src/apps/backend/node_modules/mongodb/lib/operations/command.js:84:64
    at process.processTicksAndRejections (node:internal/process/task_queues:105:5) {
  index: 0,
  code: 11000,
  keyPattern: { email: 1 },
  keyValue: { email: null },
  [Symbol(errorLabels)]: Set(0) {}
}
MongoServerError: E11000 duplicate key error collection: mob-pizza.users index: email_1 dup key: { email: null }
    at /opt/render/project/src/apps/backend/node_modules/mongodb/lib/operations/insert.js:50:33
    at /opt/render/project/src/apps/backend/node_modules/mongodb/lib/operations/command.js:84:64
    at process.processTicksAndRejections (node:internal/process/task_queues:105:5)







frontend ::
W/FrameTracker( 4878): Missed SF frame:JANK_COMPOSER, 106671, 9544320, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 4878): Missed SF frame:JANK_COMPOSER, 106693, 6286854, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 4878): Missed SF frame:JANK_COMPOSER, 106722, 14743488, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 4878): Missed SF frame:JANK_COMPOSER, 106744, 9569722, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 4878): Missed SF frame:JANK_COMPOSER, 106773, 12894256, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
V/PerfettoTrigger( 4878): Not triggering com.android.telemetry.interaction-jank-monitor-80 - not enough time since last trigger
I/ImeTracker( 4878): com.mobpizza.app:8c29c6ef: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 4878): show(ime(), fromIme=false)
I/ImeTracker( 4878): com.mobpizza.app:8c29c6ef: onCancelled at PHASE_CLIENT_APPLY_ANIMATION
I/ImeTracker( 4878): com.mobpizza.app:359141f1: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 4878): show(ime(), fromIme=false)
I/ImeTracker( 4878): com.mobpizza.app:359141f1: onCancelled at PHASE_CLIENT_APPLY_ANIMATION
I/ImeTracker( 4878): com.mobpizza.app:536de11d: onRequestHide at ORIGIN_CLIENT reason HIDE_SOFT_INPUT fromUser false
D/InsetsController( 4878): hide(ime(), fromIme=false)
D/InsetsController( 4878): Setting requestedVisibleTypes to -9 (was -1)
I/ImeTracker( 4878): system_server:a6fbd9d: onCancelled at PHASE_CLIENT_ON_CONTROLS_CHANGED
W/FrameTracker( 4878): Missed App frame:UNKNOWN: 3, 108153, 37019866, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4878): Missed SF frame:UNKNOWN: 3, 108153, 37019866, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4878): Missed SF frame:JANK_COMPOSER, 108189, 33066868, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4878): Missed SF frame:JANK_COMPOSER, 108226, 27481636, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4878): Missed SF frame:JANK_COMPOSER, 108248, 36772570, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4878): Missed SF frame:JANK_COMPOSER, 108263, 31053104, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4878): Missed SF frame:JANK_COMPOSER, 108285, 28418638, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4878): Missed SF frame:JANK_COMPOSER, 108322, 15335206, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4878): Missed SF frame:JANK_COMPOSER, 108337, 13396340, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4878): Missed SF frame:JANK_COMPOSER, 108366, 18567174, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 4878): Missed SF frame:JANK_COMPOSER, 108381, 13865708, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
V/PerfettoTrigger( 4878): Not triggering com.android.telemetry.interaction-jank-monitor-81 - not enough time since last trigger
I/flutter ( 4878): [onboarding_2] submitting...
I/flutter ( 4878): [onboarding] POST https://mob-pizza.onrender.com/api/v1/onboarding payload={locale: en, allowLocation: true, allowNotifications: true, phone: 8106020049}
I/flutter ( 4878): [onboarding] status=500 body=<!DOCTYPE html>
I/flutter ( 4878): <html lang="en">
I/flutter ( 4878): <head>
I/flutter ( 4878): <meta charset="utf-8">
I/flutter ( 4878): <title>Error</title>
I/flutter ( 4878): </head>
I/flutter ( 4878): <body>
I/flutter ( 4878): <pre>Internal Server Error</pre>
I/flutter ( 4878): </body>
I/flutter ( 4878): </html>
I/flutter ( 4878): 
I/flutter ( 4878): [onboarding_2] error: Exception: Onboarding failed (500)

