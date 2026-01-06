A Dart VM Service on sdk gphone64 x86 64 is available at: http://127.0.0.1:60680/32LOhcXTu1M=/
I/flutter ( 7286): [cart_service] GET https://mob-pizza.onrender.com/api/v1/cart/aymanbod04@gmail.com
The Flutter DevTools debugger and profiler on sdk gphone64 x86 64 is available at: http://127.0.0.1:9101?uri=http://127.0.0.1:60680/32LOhcXTu1M=/
I/Choreographer( 7286): Skipped 31 frames!  The application may be doing too much work on its main thread.
I/WindowExtensionsImpl( 7286): Initializing Window Extensions, vendor API level=9, activity embedding enabled=true
I/om.mobpizza.app( 7286): Compiler allocated 5042KB to compile void android.view.ViewRootImpl.performTraversals()
I/Choreographer( 7286): Skipped 52 frames!  The application may be doing too much work on its main thread.
D/WindowLayoutComponentImpl( 7286): Register WindowLayoutInfoListener on Context=com.mobpizza.app.MainActivity@6682386, of which baseContext=android.app.ContextImpl@7bebde3
D/ProfileInstaller( 7286): Installing profile for com.mobpizza.app
I/flutter ( 7286): [cart_service] status=404 body={"success":false,"message":"User not found"}
I/flutter ( 7286): [cart_service] error fetching cart: Exception: Failed to fetch cart: 404
I/flutter ( 7286): [CartProvider] API error, loading from cache: Exception: Failed to fetch cart: 404
I/flutter ( 7286): [CartProvider] Cart loaded from cache (0 items)
I/flutter ( 7286): [OrderProvider] Fetching orders from API for identifier: aymanbod04@gmail.com
I/flutter ( 7286): [order_service] GET https://mob-pizza.onrender.com/api/v1/orders/aymanbod04%40gmail.com (identifier: aymanbod04@gmail.com)
I/flutter ( 7286): [order_service] status=200 body={"success":true,"data":[{"_id":"6947c890daa650d7f9ba699e","customer":{"_id":"6947b5a807ff0675c609dffe","firstName":"Ayman","lastName":"User","email":"aymanbod04@gmail.com","fullName":"Ayman User","defaultAddress":null,"id":"6947b5a807ff0675c609dffe"},"items":[{"name":"Turkish Pide","image":"assets/images/turkish-pide-pizza.webp","size":"large","quantity":2,"addOns":[{"name":"Extra Lamb (+3.50)","price":0,"quantity":1,"_id":"6947c890daa650d7f9ba69a0","id":"6947c890daa650d7f9ba69a0"},{"name":"Feta Cheese (+2.00)","price":0,"quantity":1,"_id":"6947c890daa650d7f9ba69a1","id":"6947c890daa650d7f9ba69a1"},{"name":"Hot Sauce (+1.00)","price":0,"quantity":1,"_id":"6947c890daa650d7f9ba69a2","id":"6947c890daa650d7f9ba69a2"}],"specialInstructions":"","pricePerUnit":17.5,"total":35,"_id":"6947c890daa650d7f9ba699f","id":"6947c890daa650d7f9ba699f"}],"orderType":"delivery","deliveryAddress":null,"pickupLocation":null,"subtotal":35,"deliveryCharges":0,"tax":7,"discount":0,"promoCode":null,"tot
I/flutter ( 7286): [OrderProvider] Received 1 orders from API
I/flutter ( 7286): [user_service] GET https://mob-pizza.onrender.com/api/v1/users/aymanbod04@gmail.com
I/flutter ( 7286): [user_service] status=200 body={"success":true,"data":{"preferences":{"dietary":[],"spiceLevel":"medium","allergies":[]},"consents":{"location":false,"notifications":false},"_id":"6947b5a807ff0675c609dffe","firstName":"Ayman","lastName":"User","email":"aymanbod04@gmail.com","googleId":"109847488579231149428","profileImage":null,"role":"customer","loyaltyPoints":0,"isActive":true,"emailVerified":true,"phoneVerified":false,"locale":"en","onboardingCompleted":true,"onboardingAt":"2025-12-21T10:16:11.686Z","favorites":[],"ordersCount":1,"lastOrderAt":"2025-12-21T10:14:40.724Z","addresses":[{"coordinates":{"type":"Point","coordinates":[]},"label":"home","street":"Hyderabad","city":"","state":"","zipCode":"","isDefault":true,"_id":"6947c0e04edae3ec1a6f2ada"}],"paymentMethods":[],"cart":[],"createdAt":"2025-12-21T08:54:00.677Z","updatedAt":"2025-12-21T10:16:11.916Z","fullName":"Ayman User","defaultAddress":{"coordinates":{"type":"Point","coordinates":[]},"label":"home","street":"Hyderabad","city":"","state":"","zip
I/flutter ( 7286): [OrderProvider] User role: customer, isHost: false
I/flutter ( 7286): [OrderProvider] Filtered 1 orders to 1 orders for user (identifier: aymanbod04@gmail.com, role: customer)
I/flutter ( 7286): [OrderProvider] Orders loaded from API (1 orders)
I/Choreographer( 7286): Skipped 166 frames!  The application may be doing too much work on its main thread.
I/om.mobpizza.app( 7286): AssetManager2(0x72566bf2ea18) locale list changing from [] to [en-US]
D/InsetsController( 7286): hide(ime(), fromIme=false)
I/ImeTracker( 7286): com.mobpizza.app:2b4e61cb: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
D/AutofillManager( 7286): Fill dialog is enabled:false, hints=[]
D/InsetsController( 7286): hide(ime(), fromIme=false)
I/ImeTracker( 7286): com.mobpizza.app:cb1bb423: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/flutter ( 7286): [onboarding_ui] submitting...
I/flutter ( 7286): [onboarding] POST https://mob-pizza.onrender.com/api/v1/onboarding payload={locale: en, allowLocation: false, allowNotifications: false, email: aymanbod04@gmail.com, googleId: 109847488579231149428, firstName: Ayman}
D/VRI[SignInHubActivity]( 7286): visibilityChanged oldVisibility=true newVisibility=false
W/WindowOnBackDispatcher( 7286): sendCancelIfRunning: isInProgress=false callback=android.app.Activity$$ExternalSyntheticLambda0@d20c0a0
D/ViewRootImpl( 7286): Skipping stats log for color mode
D/InsetsController( 7286): hide(ime(), fromIme=false)
I/ImeTracker( 7286): com.mobpizza.app:3548b0ab: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/flutter ( 7286): [onboarding] status=200 body={"success":true,"message":"Onboarding saved","data":{"preferences":{"dietary":[],"spiceLevel":"medium","allergies":[]},"consents":{"location":false,"notifications":false},"_id":"6947b5a807ff0675c609dffe","firstName":"Ayman","lastName":"User","email":"aymanbod04@gmail.com","googleId":"109847488579231149428","profileImage":null,"role":"customer","loyaltyPoints":0,"isActive":true,"emailVerified":true,"phoneVerified":false,"locale":"en","onboardingCompleted":true,"onboardingAt":"2025-12-21T10:23:17.589Z","favorites":[],"ordersCount":1,"lastOrderAt":"2025-12-21T10:14:40.724Z","addresses":[{"coordinates":{"type":"Point","coordinates":[]},"label":"home","street":"Hyderabad","city":"","state":"","zipCode":"","isDefault":true,"_id":"6947c0e04edae3ec1a6f2ada"}],"paymentMethods":[],"cart":[],"createdAt":"2025-12-21T08:54:00.677Z","updatedAt":"2025-12-21T10:23:17.819Z","fullName":"Ayman User","defaultAddress":{"coordinates":{"type":"Point","coordinates":[]},"label":"home","street":"Hyderabad
I/flutter ( 7286): [onboarding_ui] saved locally, navigating home
I/flutter ( 7286): [user_service] GET https://mob-pizza.onrender.com/api/v1/users/aymanbod04@gmail.com
W/WindowOnBackDispatcher( 7286): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@c8afde7
I/flutter ( 7286): [user_service] status=200 body={"success":true,"data":{"preferences":{"dietary":[],"spiceLevel":"medium","allergies":[]},"consents":{"location":false,"notifications":false},"_id":"6947b5a807ff0675c609dffe","firstName":"Ayman","lastName":"User","email":"aymanbod04@gmail.com","googleId":"109847488579231149428","profileImage":null,"role":"customer","loyaltyPoints":0,"isActive":true,"emailVerified":true,"phoneVerified":false,"locale":"en","onboardingCompleted":true,"onboardingAt":"2025-12-21T10:23:17.589Z","favorites":[],"ordersCount":1,"lastOrderAt":"2025-12-21T10:14:40.724Z","addresses":[{"coordinates":{"type":"Point","coordinates":[]},"label":"home","street":"Hyderabad","city":"","state":"","zipCode":"","isDefault":true,"_id":"6947c0e04edae3ec1a6f2ada"}],"paymentMethods":[],"cart":[],"createdAt":"2025-12-21T08:54:00.677Z","updatedAt":"2025-12-21T10:23:17.819Z","fullName":"Ayman User","defaultAddress":{"coordinates":{"type":"Point","coordinates":[]},"label":"home","street":"Hyderabad","city":"","state":"","zip
I/flutter ( 7286): [AuthService] User role from backend: customer (identifier: aymanbod04@gmail.com)
I/om.mobpizza.app( 7286): AssetManager2(0x72566bf6e4d8) locale list changing from [] to [en-US]
I/flutter ( 7286): [user_service] GET https://mob-pizza.onrender.com/api/v1/users/aymanbod04@gmail.com
I/flutter ( 7286): [user_service] status=200 body={"success":true,"data":{"preferences":{"dietary":[],"spiceLevel":"medium","allergies":[]},"consents":{"location":false,"notifications":false},"_id":"6947b5a807ff0675c609dffe","firstName":"Ayman","lastName":"User","email":"aymanbod04@gmail.com","googleId":"109847488579231149428","profileImage":null,"role":"customer","loyaltyPoints":0,"isActive":true,"emailVerified":true,"phoneVerified":false,"locale":"en","onboardingCompleted":true,"onboardingAt":"2025-12-21T10:23:17.589Z","favorites":[],"ordersCount":1,"lastOrderAt":"2025-12-21T10:14:40.724Z","addresses":[{"coordinates":{"type":"Point","coordinates":[]},"label":"home","street":"Hyderabad","city":"","state":"","zipCode":"","isDefault":true,"_id":"6947c0e04edae3ec1a6f2ada"}],"paymentMethods":[],"cart":[],"createdAt":"2025-12-21T08:54:00.677Z","updatedAt":"2025-12-21T10:23:17.819Z","fullName":"Ayman User","defaultAddress":{"coordinates":{"type":"Point","coordinates":[]},"label":"home","street":"Hyderabad","city":"","state":"","zip
W/om.mobpizza.app( 7286): Cleared Reference was only reachable from finalizer (only reported once)
I/om.mobpizza.app( 7286): AssetManager2(0x72566bf6e4d8) locale list changing from [] to [en-US]
W/WindowOnBackDispatcher( 7286): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@c8afde7
I/ImeTracker( 7286): com.mobpizza.app:f4c242ac: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 7286): show(ime(), fromIme=false)
D/InsetsController( 7286): Setting requestedVisibleTypes to -1 (was -9)
D/InputConnectionAdaptor( 7286): The input method toggled cursor monitoring on
W/InteractionJankMonitor( 7286): Initializing without READ_DEVICE_CONFIG permission. enabled=true, interval=1, missedFrameThreshold=3, frameTimeThreshold=64, package=com.mobpizza.app
I/ImeTracker( 7286): com.mobpizza.app:f4c242ac: onShown
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 176220, 42851856, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 176286, 38830358, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 176323, 19442826, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 176374, 20342894, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 176403, 35671328, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 176425, 28943362, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 176447, 44843096, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 176469, 46216230, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 176499, 32686298, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
V/PerfettoTrigger( 7286): Triggering /system/bin/trigger_perfetto com.android.telemetry.interaction-jank-monitor-80
I/flutter ( 7286): [onboarding_ui] submitting...
I/flutter ( 7286): [onboarding] POST https://mob-pizza.onrender.com/api/v1/onboarding payload={locale: en, allowLocation: false, allowNotifications: false, phone: 1234567890}      
I/flutter ( 7286): [onboarding] status=200 body={"success":true,"message":"Onboarding saved","data":{"preferences":{"allergies":[],"dietary":[],"spiceLevel":"medium"},"consents":{"location":false,"notifications":false},"_id":"694449bcd3c5938e7b903aa6","phone":"1234567890","addresses":[],"cart":[],"createdAt":"2025-12-18T18:36:44.100Z","email":null,"emailVerified":false,"favorites":[],"firstName":"Guest","isActive":true,"lastName":"User","lastOrderAt":null,"locale":"en","loyaltyPoints":0,"onboardingAt":"2025-12-21T10:23:42.520Z","onboardingCompleted":true,"ordersCount":0,"paymentMethods":[],"phoneVerified":true,"profileImage":null,"role":"admin","updatedAt":"2025-12-21T10:23:44.772Z","fullName":"Guest User","defaultAddress":null,"id":"694449bcd3c5938e7b903aa6"}}
I/flutter ( 7286): [onboarding_ui] saved locally, navigating home
I/flutter ( 7286): [user_service] GET https://mob-pizza.onrender.com/api/v1/users/1234567890
W/WindowOnBackDispatcher( 7286): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@c8afde7
I/ImeTracker( 7286): com.mobpizza.app:155f7567: onRequestHide at ORIGIN_CLIENT reason HIDE_SOFT_INPUT fromUser false
D/InsetsController( 7286): hide(ime(), fromIme=false)
W/WindowOnBackDispatcher( 7286): sendCancelIfRunning: isInProgress=false callback=android.view.ImeBackAnimationController@3a521cf
D/InsetsController( 7286): Setting requestedVisibleTypes to -9 (was -1)
D/CompatChangeReporter( 7286): Compat change id reported: 395521150; UID 10221; state: ENABLED
I/ImeTracker( 7286): system_server:dfa48386: onCancelled at PHASE_CLIENT_ON_CONTROLS_CHANGED
W/FrameTracker( 7286): Missed App frame:UNKNOWN: 3, 178545, 68781538, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:UNKNOWN: 3, 178545, 68781538, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 178568, 23979474, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed App frame:UNKNOWN: 3, 178583, 72561308, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:UNKNOWN: 3, 178583, 72561308, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 178605, 61984076, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 178626, 58926710, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 178648, 49383478, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 178686, 32252980, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 178709, 9886848, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
V/PerfettoTrigger( 7286): Triggering /system/bin/trigger_perfetto com.android.telemetry.interaction-jank-monitor-81
I/flutter ( 7286): [user_service] status=200 body={"success":true,"data":{"preferences":{"allergies":[],"dietary":[],"spiceLevel":"medium"},"consents":{"location":false,"notifications":false},"_id":"694449bcd3c5938e7b903aa6","phone":"1234567890","addresses":[],"cart":[],"createdAt":"2025-12-18T18:36:44.100Z","email":null,"emailVerified":false,"favorites":[],"firstName":"Guest","isActive":true,"lastName":"User","lastOrderAt":null,"locale":"en","loyaltyPoints":0,"onboardingAt":"2025-12-21T10:23:42.520Z","onboardingCompleted":true,"ordersCount":0,"paymentMethods":[],"phoneVerified":true,"profileImage":null,"role":"admin","updatedAt":"2025-12-21T10:23:44.772Z","fullName":"Guest User","defaultAddress":null,"id":"694449bcd3c5938e7b903aa6"}}
I/flutter ( 7286): [AuthService] User role from backend: admin (identifier: 1234567890)
I/flutter ( 7286): [OrderProvider] Fetching orders from API for identifier: 1234567890
I/flutter ( 7286): [order_service] GET https://mob-pizza.onrender.com/api/v1/orders/1234567890 (identifier: 1234567890)
I/flutter ( 7286): [order_service] status=200 body={"success":true,"data":[{"_id":"6947c890daa650d7f9ba699e","customer":{"_id":"6947b5a807ff0675c609dffe","firstName":"Ayman","lastName":"User","email":"aymanbod04@gmail.com","fullName":"Ayman User","defaultAddress":null,"id":"6947b5a807ff0675c609dffe"},"items":[{"name":"Turkish Pide","image":"assets/images/turkish-pide-pizza.webp","size":"large","quantity":2,"addOns":[{"name":"Extra Lamb (+3.50)","price":0,"quantity":1,"_id":"6947c890daa650d7f9ba69a0","id":"6947c890daa650d7f9ba69a0"},{"name":"Feta Cheese (+2.00)","price":0,"quantity":1,"_id":"6947c890daa650d7f9ba69a1","id":"6947c890daa650d7f9ba69a1"},{"name":"Hot Sauce (+1.00)","price":0,"quantity":1,"_id":"6947c890daa650d7f9ba69a2","id":"6947c890daa650d7f9ba69a2"}],"specialInstructions":"","pricePerUnit":17.5,"total":35,"_id":"6947c890daa650d7f9ba699f","id":"6947c890daa650d7f9ba699f"}],"orderType":"delivery","deliveryAddress":null,"pickupLocation":null,"subtotal":35,"deliveryCharges":0,"tax":7,"discount":0,"promoCode":null,"tot
I/flutter ( 7286): [OrderProvider] Received 3 orders from API
I/flutter ( 7286): [user_service] GET https://mob-pizza.onrender.com/api/v1/users/1234567890
I/flutter ( 7286): [user_service] status=200 body={"success":true,"data":{"preferences":{"allergies":[],"dietary":[],"spiceLevel":"medium"},"consents":{"location":false,"notificati
ons":false},"_id":"694449bcd3c5938e7b903aa6","phone":"1234567890","addresses":[],"cart":[],"createdAt":"2025-12-18T18:36:44.100Z","email":null,"emailVerified":false,"favorites":[],
"firstName":"Guest","isActive":true,"lastName":"User","lastOrderAt":null,"locale":"en","loyaltyPoints":0,"onboardingAt":"2025-12-21T10:23:42.520Z","onboardingCompleted":true,"order
sCount":0,"paymentMethods":[],"phoneVerified":true,"profileImage":null,"role":"admin","updatedAt":"2025-12-21T10:23:44.772Z","fullName":"Guest User","defaultAddress":null,"id":"694449bcd3c5938e7b903aa6"}}
I/flutter ( 7286): [OrderProvider] User role: admin, isHost: true
I/flutter ( 7286): [OrderProvider] Showing all 3 orders for host/admin (role: admin/delivery)
I/flutter ( 7286): [OrderProvider] Orders loaded from API (3 orders)
I/ImeTracker( 7286): com.mobpizza.app:65c2a210: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 7286): show(ime(), fromIme=false)
D/InsetsController( 7286): Setting requestedVisibleTypes to -1 (was -9)
D/InputConnectionAdaptor( 7286): The input method toggled cursor monitoring on
I/AssistStructure( 7286): Flattened final assist data: 484 bytes, containing 1 windows, 3 views
I/ImeTracker( 7286): com.mobpizza.app:65c2a210: onShown
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 180797, 38701180, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 180833, 34544214, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed App frame:UNKNOWN: 3, 180855, 54487848, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:UNKNOWN: 3, 180855, 54487848, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 180870, 40681682, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 180913, 32489050, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 180935, 48428584, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 180979, 19521052, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 181001, 33859586, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 181023, 64314420, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 181059, 39687388, CUJ=J<IME_INSETS_SHOW_ANIMATION::0@1@com.mobpizza.app>
V/PerfettoTrigger( 7286): Not triggering com.android.telemetry.interaction-jank-monitor-80 - not enough time since last trigger
I/ImeTracker( 7286): com.mobpizza.app:1c87cac6: onRequestHide at ORIGIN_CLIENT reason HIDE_SOFT_INPUT fromUser false
D/InsetsController( 7286): hide(ime(), fromIme=false)
W/WindowOnBackDispatcher( 7286): sendCancelIfRunning: isInProgress=false callback=android.view.ImeBackAnimationController@3a521cf
D/InsetsController( 7286): Setting requestedVisibleTypes to -9 (was -1)
W/WindowOnBackDispatcher( 7286): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@c8afde7
I/ImeTracker( 7286): system_server:3863b3b9: onCancelled at PHASE_CLIENT_ON_CONTROLS_CHANGED
W/FrameTracker( 7286): Missed App frame:JANK_APPLICATION, 181765, 17885892, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 181779, 29601826, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 181802, 12599494, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed App frame:UNKNOWN: 3, 181831, 47565228, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:UNKNOWN: 3, 181831, 47565228, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 181891, 13224064, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed App frame:JANK_APPLICATION, 181906, 37733298, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:JANK_COMPOSER, 181943, 38880466, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed App frame:UNKNOWN: 3, 181958, 58836600, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
W/FrameTracker( 7286): Missed SF frame:UNKNOWN: 3, 181958, 58836600, CUJ=J<IME_INSETS_HIDE_ANIMATION::1@1@com.mobpizza.app>
V/PerfettoTrigger( 7286): Not triggering com.android.telemetry.interaction-jank-monitor-81 - not enough time since last trigger
I/flutter ( 7286): [order_service] PUT https://mob-pizza.onrender.com/api/v1/orders/1234567890/6947c890daa650d7f9ba699e/status with status: ready (identifier: 1234567890)
W/WindowOnBackDispatcher( 7286): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@c8afde7
I/flutter ( 7286): [order_service] status=200 body={"success":true,"message":"Order status updated","data":{"_id":"6947c890daa650d7f9ba699e","customer":{"_id":"6947b5a807ff0675c609dffe","firstName":"Ayman","lastName":"User","fullName":"Ayman User","defaultAddress":null,"id":"6947b5a807ff0675c609dffe"},"items":[{"name":"Turkish Pide","image":"assets/images/turkish-pide-pizza.webp","size":"large","quantity":2,"addOns":[{"name":"Extra Lamb (+3.50)","price":0,"quantity":1,"_id":"6947c890daa650d7f9ba69a0","id":"6947c890daa650d7f9ba69a0"},{"name":"Feta Cheese (+2.00)","price":0,"quantity":1,"_id":"6947c890daa650d7f9ba69a1","id":"6947c890daa650d7f9ba69a1"},{"name":"Hot Sauce (+1.00)","price":0,"quantity":1,"_id":"6947c890daa650d7f9ba69a2","id":"6947c890daa650d7f9ba69a2"}],"specialInstructions":"","pricePerUnit":17.5,"total":35,"_id":"6947c890daa650d7f9ba699f","id":"6947c890daa650d7f9ba699f"}],"orderType":"delivery","deliveryAddress":null,"pickupLocation":null,"subtotal":35,"deliveryCharges":0,"tax":7,"discount":0,"promoCode":null,"to
I/flutter ( 7286): [OrderProvider] Order status updated via API
I/flutter ( 7286): [user_service] GET https://mob-pizza.onrender.com/api/v1/users/1234567890
I/flutter ( 7286): [user_service] status=200 body={"success":true,"data":{"preferences":{"allergies":[],"dietary":[],"spiceLevel":"medium"},"consents":{"location":false,"notifications":false},"_id":"694449bcd3c5938e7b903aa6","phone":"1234567890","addresses":[],"cart":[],"createdAt":"2025-12-18T18:36:44.100Z","email":null,"emailVerified":false,"favorites":[],"firstName":"Guest","isActive":true,"lastName":"User","lastOrderAt":null,"locale":"en","loyaltyPoints":0,"onboardingAt":"2025-12-21T10:23:42.520Z","onboardingCompleted":true,"ordersCount":0,"paymentMethods":[],"phoneVerified":true,"profileImage":null,"role":"admin","updatedAt":"2025-12-21T10:23:44.772Z","fullName":"Guest User","defaultAddress":null,"id":"694449bcd3c5938e7b903aa6"}}
I/om.mobpizza.app( 7286): Background concurrent mark compact GC freed 1613KB AllocSpace bytes, 20(1040KB) LOS objects, 49% free, 2880KB/5761KB, paused 1.323ms,5.968ms total 41.840ms
I/om.mobpizza.app( 7286): AssetManager2(0x72566bf26098) locale list changing from [] to [en-US]
W/WindowOnBackDispatcher( 7286): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@c8afde7
D/AutofillManager( 7286): Fill dialog is enabled:false, hints=[]
I/flutter ( 7286): [onboarding_ui] submitting...
I/flutter ( 7286): [onboarding] POST https://mob-pizza.onrender.com/api/v1/onboarding payload={locale: en, allowLocation: false, allowNotifications: false, email: aymanbod04@gmail.com, googleId: 109847488579231149428, firstName: Ayman}
D/VRI[SignInHubActivity]( 7286): visibilityChanged oldVisibility=true newVisibility=false
D/InsetsController( 7286): hide(ime(), fromIme=false)
I/ImeTracker( 7286): com.mobpizza.app:84b19eeb: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
W/WindowOnBackDispatcher( 7286): sendCancelIfRunning: isInProgress=false callback=android.app.Activity$$ExternalSyntheticLambda0@987c787
D/ViewRootImpl( 7286): Skipping stats log for color mode
D/InsetsController( 7286): hide(ime(), fromIme=false)
I/ImeTracker( 7286): com.mobpizza.app:4749d4fe: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/flutter ( 7286): [onboarding] status=200 body={"success":true,"message":"Onboarding saved","data":{"preferences":{"dietary":[],"spiceLevel":"medium","allergies":[]},"consents":{"
location":false,"notifications":false},"_id":"6947b5a807ff0675c609dffe","firstName":"Ayman","lastName":"User","email":"aymanbod04@gmail.com","googleId":"109847488579231149428","pro
fileImage":null,"role":"customer","loyaltyPoints":0,"isActive":true,"emailVerified":true,"phoneVerified":false,"locale":"en","onboardingCompleted":true,"onboardingAt":"2025-12-21T1
0:24:40.617Z","favorites":[],"ordersCount":1,"lastOrderAt":"2025-12-21T10:14:40.724Z","addresses":[{"coordinates":{"type":"Point","coordinates":[]},"label":"home","street":"Hyderab
ad","city":"","state":"","zipCode":"","isDefault":true,"_id":"6947c0e04edae3ec1a6f2ada"}],"paymentMethods":[],"cart":[],"createdAt":"2025-12-21T08:54:00.677Z","updatedAt":"2025-12-21T10:24:40.847Z","fullName":"Ayman User","defaultAddress":{"coordinates":{"type":"Point","coordinates":[]},"label":"home","street":"Hyderabad
I/flutter ( 7286): [onboarding_ui] saved locally, navigating home
I/flutter ( 7286): [user_service] GET https://mob-pizza.onrender.com/api/v1/users/aymanbod04@gmail.com
W/WindowOnBackDispatcher( 7286): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@c8afde7
I/flutter ( 7286): [user_service] status=200 body={"success":true,"data":{"preferences":{"dietary":[],"spiceLevel":"medium","allergies":[]},"consents":{"location":false,"notificati
ons":false},"_id":"6947b5a807ff0675c609dffe","firstName":"Ayman","lastName":"User","email":"aymanbod04@gmail.com","googleId":"109847488579231149428","profileImage":null,"role":"customer","loyaltyPoints":0,"isActive":true,"emailVerified":true,"phoneVerified":false,"locale":"en","onboardingCompleted":true,"onboardingAt":"2025-12-21T10:24:40.617Z","favorites":[],"ordersCount":1,"lastOrderAt":"2025-12-21T10:14:40.724Z","addresses":[{"coordinates":{"type":"Point","coordinates":[]},"label":"home","street":"Hyderabad","city":"","state":"","zipCode":"","isDefault":true,"_id":"6947c0e04edae3ec1a6f2ada"}],"paymentMethods":[],"cart":[],"createdAt":"2025-12-21T08:54:00.677Z","updatedAt":"2025-12-21T10:24:40.847Z","fullName":"Ayman User","defaultAddress":{"coordinates":{"type":"Point","coordinates":[]},"label":"home","street":"Hyderabad","city":"","state":"","zip
I/flutter ( 7286): [AuthService] User role from backend: customer (identifier: aymanbod04@gmail.com)
