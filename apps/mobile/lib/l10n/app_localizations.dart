import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Mob Pizza'**
  String get appName;

  /// No description provided for @homeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'The Don\'s Briefing'**
  String get homeScreenTitle;

  /// No description provided for @homeScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mob Pizza'**
  String get homeScreenSubtitle;

  /// No description provided for @homeScreenDescription.
  ///
  /// In en, this message translates to:
  /// **'Cinematic pies. Speakeasy service. Whisper your order.'**
  String get homeScreenDescription;

  /// No description provided for @orderNow.
  ///
  /// In en, this message translates to:
  /// **'Order Now'**
  String get orderNow;

  /// No description provided for @trackOrders.
  ///
  /// In en, this message translates to:
  /// **'Track Orders'**
  String get trackOrders;

  /// No description provided for @familyShortcuts.
  ///
  /// In en, this message translates to:
  /// **'Family Shortcuts'**
  String get familyShortcuts;

  /// No description provided for @theHitList.
  ///
  /// In en, this message translates to:
  /// **'The Hit List'**
  String get theHitList;

  /// No description provided for @theHitListDesc.
  ///
  /// In en, this message translates to:
  /// **'Browse signature pies'**
  String get theHitListDesc;

  /// No description provided for @orderSummaryCard.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummaryCard;

  /// No description provided for @orderSummaryCardDesc.
  ///
  /// In en, this message translates to:
  /// **'Your cart, Mob-styled'**
  String get orderSummaryCardDesc;

  /// No description provided for @pastOrders.
  ///
  /// In en, this message translates to:
  /// **'Past Orders'**
  String get pastOrders;

  /// No description provided for @pastOrdersDesc.
  ///
  /// In en, this message translates to:
  /// **'Track & re-order'**
  String get pastOrdersDesc;

  /// No description provided for @yourFile.
  ///
  /// In en, this message translates to:
  /// **'Your File'**
  String get yourFile;

  /// No description provided for @yourFileDesc.
  ///
  /// In en, this message translates to:
  /// **'Profile & safehouses'**
  String get yourFileDesc;

  /// No description provided for @customizePizza.
  ///
  /// In en, this message translates to:
  /// **'Customize Pizza'**
  String get customizePizza;

  /// No description provided for @customizePizzaDesc.
  ///
  /// In en, this message translates to:
  /// **'Build your own pizza'**
  String get customizePizzaDesc;

  /// No description provided for @selectBaseItems.
  ///
  /// In en, this message translates to:
  /// **'Select Base Items'**
  String get selectBaseItems;

  /// No description provided for @selectBaseItemsDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose up to 8 items for your pizza'**
  String get selectBaseItemsDesc;

  /// No description provided for @selectToppings.
  ///
  /// In en, this message translates to:
  /// **'Select Toppings'**
  String get selectToppings;

  /// No description provided for @selectDips.
  ///
  /// In en, this message translates to:
  /// **'Select Dips'**
  String get selectDips;

  /// No description provided for @customPizza.
  ///
  /// In en, this message translates to:
  /// **'Custom Pizza'**
  String get customPizza;

  /// No description provided for @customPizzaDesc.
  ///
  /// In en, this message translates to:
  /// **'Your personalized creation'**
  String get customPizzaDesc;

  /// No description provided for @selectedItems.
  ///
  /// In en, this message translates to:
  /// **'Selected Items'**
  String get selectedItems;

  /// No description provided for @selectedToppings.
  ///
  /// In en, this message translates to:
  /// **'Selected Toppings'**
  String get selectedToppings;

  /// No description provided for @selectedDips.
  ///
  /// In en, this message translates to:
  /// **'Selected Dips'**
  String get selectedDips;

  /// No description provided for @basePrice.
  ///
  /// In en, this message translates to:
  /// **'Base Price'**
  String get basePrice;

  /// No description provided for @toppingsPrice.
  ///
  /// In en, this message translates to:
  /// **'Toppings Price'**
  String get toppingsPrice;

  /// No description provided for @dipsPrice.
  ///
  /// In en, this message translates to:
  /// **'Dips Price'**
  String get dipsPrice;

  /// No description provided for @languageToggle.
  ///
  /// In en, this message translates to:
  /// **'Convert to Spanish?'**
  String get languageToggle;

  /// No description provided for @languageToggleDesc.
  ///
  /// In en, this message translates to:
  /// **'Toggle app language'**
  String get languageToggleDesc;

  /// No description provided for @languageToggleSpanish.
  ///
  /// In en, this message translates to:
  /// **'Convertir a Inglés?'**
  String get languageToggleSpanish;

  /// No description provided for @ordersClosed.
  ///
  /// In en, this message translates to:
  /// **'Orders Closed'**
  String get ordersClosed;

  /// No description provided for @safehouses.
  ///
  /// In en, this message translates to:
  /// **'Safehouses'**
  String get safehouses;

  /// No description provided for @familyBulletin.
  ///
  /// In en, this message translates to:
  /// **'Family Bulletin'**
  String get familyBulletin;

  /// No description provided for @bossPick.
  ///
  /// In en, this message translates to:
  /// **'Boss Pick'**
  String get bossPick;

  /// No description provided for @houseSecret.
  ///
  /// In en, this message translates to:
  /// **'House Secret'**
  String get houseSecret;

  /// No description provided for @familyCombo.
  ///
  /// In en, this message translates to:
  /// **'Family Combo'**
  String get familyCombo;

  /// No description provided for @margheritaBoss.
  ///
  /// In en, this message translates to:
  /// **'Margherita – The Mistress'**
  String get margheritaBoss;

  /// No description provided for @smokyCapo.
  ///
  /// In en, this message translates to:
  /// **'Smoky Capo BBQ'**
  String get smokyCapo;

  /// No description provided for @crewFeast.
  ///
  /// In en, this message translates to:
  /// **'Crew Feast'**
  String get crewFeast;

  /// No description provided for @bossPicksDesc.
  ///
  /// In en, this message translates to:
  /// **'Boss Picks • Under-the-Table Deals • Family Combos'**
  String get bossPicksDesc;

  /// No description provided for @houseSecrets.
  ///
  /// In en, this message translates to:
  /// **'House Secrets'**
  String get houseSecrets;

  /// No description provided for @houseSecretsDesc.
  ///
  /// In en, this message translates to:
  /// **'Boss Picks • Under-the-Table Deals • Family Combos'**
  String get houseSecretsDesc;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @searchMenu.
  ///
  /// In en, this message translates to:
  /// **'Search the Hit List…'**
  String get searchMenu;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'CHECKOUT'**
  String get checkout;

  /// No description provided for @orderHistory.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get orderHistory;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfo;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get navMenu;

  /// No description provided for @navCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get navCart;

  /// No description provided for @navOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get navOrders;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navHomeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Go home'**
  String get navHomeTooltip;

  /// No description provided for @navMenuTooltip.
  ///
  /// In en, this message translates to:
  /// **'Browse menu'**
  String get navMenuTooltip;

  /// No description provided for @navCartTooltip.
  ///
  /// In en, this message translates to:
  /// **'View cart'**
  String get navCartTooltip;

  /// No description provided for @navOrdersTooltip.
  ///
  /// In en, this message translates to:
  /// **'View orders'**
  String get navOrdersTooltip;

  /// No description provided for @navProfileTooltip.
  ///
  /// In en, this message translates to:
  /// **'View profile'**
  String get navProfileTooltip;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Mob Pizza'**
  String get welcome;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continueAsGuest;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @noOrders.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get noOrders;

  /// No description provided for @orderPlaced.
  ///
  /// In en, this message translates to:
  /// **'Order Placed Successfully'**
  String get orderPlaced;

  /// No description provided for @orderFailed.
  ///
  /// In en, this message translates to:
  /// **'Order Failed'**
  String get orderFailed;

  /// No description provided for @paymentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentSuccessful;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentFailed;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @eta.
  ///
  /// In en, this message translates to:
  /// **'ETA'**
  String get eta;

  /// No description provided for @runner.
  ///
  /// In en, this message translates to:
  /// **'Runner'**
  String get runner;

  /// No description provided for @familyTip.
  ///
  /// In en, this message translates to:
  /// **'Family Tip'**
  String get familyTip;

  /// No description provided for @keepLineOpen.
  ///
  /// In en, this message translates to:
  /// **'Keep your line open; runners may call on arrival.'**
  String get keepLineOpen;

  /// No description provided for @kitchenInMotion.
  ///
  /// In en, this message translates to:
  /// **'Kitchen in Motion → On the Streets → Delivered'**
  String get kitchenInMotion;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInformation;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'ORDER SUMMARY'**
  String get orderSummary;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get deliveryFee;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrder;

  /// No description provided for @cashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get cashOnDelivery;

  /// No description provided for @creditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get creditCard;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @specialInstructions.
  ///
  /// In en, this message translates to:
  /// **'Special Instructions'**
  String get specialInstructions;

  /// No description provided for @dropLocation.
  ///
  /// In en, this message translates to:
  /// **'Drop Location'**
  String get dropLocation;

  /// No description provided for @lockInTheOrder.
  ///
  /// In en, this message translates to:
  /// **'Lock In the Order'**
  String get lockInTheOrder;

  /// No description provided for @joinTheFamily.
  ///
  /// In en, this message translates to:
  /// **'Join the Family'**
  String get joinTheFamily;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @allowLocation.
  ///
  /// In en, this message translates to:
  /// **'Allow Location'**
  String get allowLocation;

  /// No description provided for @allowNotifications.
  ///
  /// In en, this message translates to:
  /// **'Allow Notifications'**
  String get allowNotifications;

  /// No description provided for @locationHelps.
  ///
  /// In en, this message translates to:
  /// **'Helps confirm delivery area'**
  String get locationHelps;

  /// No description provided for @notificationsHelps.
  ///
  /// In en, this message translates to:
  /// **'Order updates & offers'**
  String get notificationsHelps;

  /// No description provided for @requestPermissions.
  ///
  /// In en, this message translates to:
  /// **'Request Permissions'**
  String get requestPermissions;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone is required'**
  String get phoneRequired;

  /// No description provided for @enterValidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter valid phone'**
  String get enterValidPhone;

  /// No description provided for @onboardingSuccess.
  ///
  /// In en, this message translates to:
  /// **'Onboarding saved'**
  String get onboardingSuccess;

  /// No description provided for @onboardingSuccessOffline.
  ///
  /// In en, this message translates to:
  /// **'Onboarding saved (offline)'**
  String get onboardingSuccessOffline;

  /// No description provided for @networkIssue.
  ///
  /// In en, this message translates to:
  /// **'Network issue'**
  String get networkIssue;

  /// No description provided for @networkIssueMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the server. Continue offline? (Data will be stored locally and will sync when online.)'**
  String get networkIssueMessage;

  /// No description provided for @continueOffline.
  ///
  /// In en, this message translates to:
  /// **'Continue offline'**
  String get continueOffline;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @streetAddress.
  ///
  /// In en, this message translates to:
  /// **'Street Address'**
  String get streetAddress;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdated;

  /// No description provided for @profileUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile'**
  String get profileUpdateFailed;

  /// No description provided for @loggedOut.
  ///
  /// In en, this message translates to:
  /// **'Logged out'**
  String get loggedOut;

  /// No description provided for @noPizzasFound.
  ///
  /// In en, this message translates to:
  /// **'No pizzas found'**
  String get noPizzasFound;

  /// No description provided for @tryDifferentKeywords.
  ///
  /// In en, this message translates to:
  /// **'Try searching with different keywords'**
  String get tryDifferentKeywords;

  /// No description provided for @heatLevel.
  ///
  /// In en, this message translates to:
  /// **'Heat Level:'**
  String get heatLevel;

  /// No description provided for @veg.
  ///
  /// In en, this message translates to:
  /// **'VEG'**
  String get veg;

  /// No description provided for @nonVeg.
  ///
  /// In en, this message translates to:
  /// **'NON-VEG'**
  String get nonVeg;

  /// No description provided for @yourCartIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get yourCartIsEmpty;

  /// No description provided for @addPizzasToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Add some delicious pizzas to get started'**
  String get addPizzasToGetStarted;

  /// No description provided for @browseMenu.
  ///
  /// In en, this message translates to:
  /// **'BROWSE MENU'**
  String get browseMenu;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size:'**
  String get size;

  /// No description provided for @toppings.
  ///
  /// In en, this message translates to:
  /// **'Toppings:'**
  String get toppings;

  /// No description provided for @selectedSlices.
  ///
  /// In en, this message translates to:
  /// **'Selected slices:'**
  String get selectedSlices;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'item'**
  String get item;

  /// No description provided for @addMore.
  ///
  /// In en, this message translates to:
  /// **'ADD MORE'**
  String get addMore;

  /// No description provided for @proceedToDeal.
  ///
  /// In en, this message translates to:
  /// **'PROCEED TO DEAL'**
  String get proceedToDeal;

  /// No description provided for @orderHistoryWillAppear.
  ///
  /// In en, this message translates to:
  /// **'Your order history will appear here'**
  String get orderHistoryWillAppear;

  /// No description provided for @orderNotFound.
  ///
  /// In en, this message translates to:
  /// **'ORDER NOT FOUND'**
  String get orderNotFound;

  /// No description provided for @orderNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'Order not found'**
  String get orderNotFoundMessage;

  /// No description provided for @orderItems.
  ///
  /// In en, this message translates to:
  /// **'ORDER ITEMS'**
  String get orderItems;

  /// No description provided for @orderInformation.
  ///
  /// In en, this message translates to:
  /// **'ORDER INFORMATION'**
  String get orderInformation;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order #'**
  String get orderNumber;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @orderDate.
  ///
  /// In en, this message translates to:
  /// **'Order Date'**
  String get orderDate;

  /// No description provided for @estimatedDelivery.
  ///
  /// In en, this message translates to:
  /// **'Estimated Delivery'**
  String get estimatedDelivery;

  /// No description provided for @stripeOnlinePayment.
  ///
  /// In en, this message translates to:
  /// **'Stripe Online Payment'**
  String get stripeOnlinePayment;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'Added to Cart'**
  String get addedToCart;

  /// No description provided for @cartItems.
  ///
  /// In en, this message translates to:
  /// **'Cart items'**
  String get cartItems;

  /// No description provided for @viewCart.
  ///
  /// In en, this message translates to:
  /// **'VIEW CART'**
  String get viewCart;

  /// No description provided for @aboutThisPizza.
  ///
  /// In en, this message translates to:
  /// **'ABOUT THIS PIZZA'**
  String get aboutThisPizza;

  /// No description provided for @aboutThisItem.
  ///
  /// In en, this message translates to:
  /// **'ABOUT THIS ITEM'**
  String get aboutThisItem;

  /// No description provided for @aboutTheseWings.
  ///
  /// In en, this message translates to:
  /// **'ABOUT THESE WINGS'**
  String get aboutTheseWings;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'INGREDIENTS'**
  String get ingredients;

  /// No description provided for @specialToppings.
  ///
  /// In en, this message translates to:
  /// **'SPECIAL TOPPINGS'**
  String get specialToppings;

  /// No description provided for @sizeOptions.
  ///
  /// In en, this message translates to:
  /// **'SIZE OPTIONS'**
  String get sizeOptions;

  /// No description provided for @addToCartButton.
  ///
  /// In en, this message translates to:
  /// **'ADD TO CART'**
  String get addToCartButton;

  /// No description provided for @houseNotes.
  ///
  /// In en, this message translates to:
  /// **'House Notes:'**
  String get houseNotes;

  /// No description provided for @addTruffleDrizzle.
  ///
  /// In en, this message translates to:
  /// **'Add truffle drizzle for a small upcharge.'**
  String get addTruffleDrizzle;

  /// No description provided for @bossPicks.
  ///
  /// In en, this message translates to:
  /// **'Boss Picks'**
  String get bossPicks;

  /// No description provided for @underTheTableDeals.
  ///
  /// In en, this message translates to:
  /// **'Under-the-Table Deals'**
  String get underTheTableDeals;

  /// No description provided for @familyCombos.
  ///
  /// In en, this message translates to:
  /// **'Family Combos'**
  String get familyCombos;

  /// No description provided for @cinematicPiesSpeakeasy.
  ///
  /// In en, this message translates to:
  /// **'Cinematic pies, speakeasy service.'**
  String get cinematicPiesSpeakeasy;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterName;

  /// No description provided for @pleaseEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterPhone;

  /// No description provided for @deliveryAddressRequired.
  ///
  /// In en, this message translates to:
  /// **'Delivery address is required'**
  String get deliveryAddressRequired;

  /// No description provided for @enterCompleteAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter a complete address'**
  String get enterCompleteAddress;

  /// No description provided for @enterCompleteDeliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your complete delivery address'**
  String get enterCompleteDeliveryAddress;

  /// No description provided for @orderPlacedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order Placed Successfully!'**
  String get orderPlacedSuccessfully;

  /// No description provided for @errorPlacingOrder.
  ///
  /// In en, this message translates to:
  /// **'Error placing order:'**
  String get errorPlacingOrder;

  /// No description provided for @internationalVariations.
  ///
  /// In en, this message translates to:
  /// **'International Variations'**
  String get internationalVariations;

  /// No description provided for @specialityAndAlternativeBases.
  ///
  /// In en, this message translates to:
  /// **'Speciality and Alternative Bases'**
  String get specialityAndAlternativeBases;

  /// No description provided for @americanRegionalStyle.
  ///
  /// In en, this message translates to:
  /// **'American Regional Style'**
  String get americanRegionalStyle;

  /// No description provided for @italianStyle.
  ///
  /// In en, this message translates to:
  /// **'Italian Style'**
  String get italianStyle;

  /// No description provided for @classicAndWidelySoldPizzas.
  ///
  /// In en, this message translates to:
  /// **'Classic and Widely Sold Pizzas'**
  String get classicAndWidelySoldPizzas;

  /// No description provided for @solo.
  ///
  /// In en, this message translates to:
  /// **'Solo'**
  String get solo;

  /// No description provided for @crew.
  ///
  /// In en, this message translates to:
  /// **'Crew'**
  String get crew;

  /// No description provided for @family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get family;

  /// No description provided for @pizzaJapaneseInspired.
  ///
  /// In en, this message translates to:
  /// **'Japanese-Inspired'**
  String get pizzaJapaneseInspired;

  /// No description provided for @pizzaJapaneseInspiredDesc.
  ///
  /// In en, this message translates to:
  /// **'Seafood, mayo, teriyaki elements.'**
  String get pizzaJapaneseInspiredDesc;

  /// No description provided for @pizzaJapaneseInspiredFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A fusion masterpiece blending Japanese flavors with Italian technique. Fresh sushi-grade tuna, creamy mayo, and teriyaki glaze create an unexpected harmony. The nori and sesame seeds add texture and umami depth that will transport your taste buds to new territories.'**
  String get pizzaJapaneseInspiredFullDesc;

  /// No description provided for @pizzaIndianInspired.
  ///
  /// In en, this message translates to:
  /// **'Indian-Inspired'**
  String get pizzaIndianInspired;

  /// No description provided for @pizzaIndianInspiredDesc.
  ///
  /// In en, this message translates to:
  /// **'Paneer, tandoori toppings, spiced sauces.'**
  String get pizzaIndianInspiredDesc;

  /// No description provided for @pizzaIndianInspiredFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Experience the vibrant flavors of India reimagined on a crispy crust. Tandoori-marinated paneer, pickled onions, and cilantro chutney create a symphony of spice and freshness. This pizza bridges two culinary worlds with remarkable harmony and bold character.'**
  String get pizzaIndianInspiredFullDesc;

  /// No description provided for @pizzaTurkishPide.
  ///
  /// In en, this message translates to:
  /// **'Turkish Pide'**
  String get pizzaTurkishPide;

  /// No description provided for @pizzaTurkishPideDesc.
  ///
  /// In en, this message translates to:
  /// **'Boat-shaped flatbread with toppings.'**
  String get pizzaTurkishPideDesc;

  /// No description provided for @pizzaTurkishPideFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Authentic Turkish pide featuring a boat-shaped crust filled with seasoned ground lamb, onions, and peppers. The dough is stretched thin and folded to create the perfect vessel for these aromatic fillings. A taste of Istanbul\'s bustling streets in every bite.'**
  String get pizzaTurkishPideFullDesc;

  /// No description provided for @pizzaBrazilian.
  ///
  /// In en, this message translates to:
  /// **'Brazilian'**
  String get pizzaBrazilian;

  /// No description provided for @pizzaBrazilianDesc.
  ///
  /// In en, this message translates to:
  /// **'Sweet/dessert-style options alongside savory.'**
  String get pizzaBrazilianDesc;

  /// No description provided for @pizzaBrazilianFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A celebration of Brazilian flavors featuring tropical hearts of palm, corn, and coconut flakes. The unique combination of sweet and savory elements reflects Brazil\'s diverse culinary heritage. Light, refreshing, and utterly unique.'**
  String get pizzaBrazilianFullDesc;

  /// No description provided for @pizzaGlutenFree.
  ///
  /// In en, this message translates to:
  /// **'Gluten-Free Pizza'**
  String get pizzaGlutenFree;

  /// No description provided for @pizzaGlutenFreeDesc.
  ///
  /// In en, this message translates to:
  /// **'Alternative flours, crafted for a lighter base.'**
  String get pizzaGlutenFreeDesc;

  /// No description provided for @pizzaGlutenFreeFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Our gluten-free crust uses a special blend of rice and tapioca flours for that perfect texture. Topped with fresh vegetables and our signature sauce, this pizza proves that dietary restrictions don\'t mean compromising on flavor.'**
  String get pizzaGlutenFreeFullDesc;

  /// No description provided for @pizzaVegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan Pizza'**
  String get pizzaVegan;

  /// No description provided for @pizzaVeganDesc.
  ///
  /// In en, this message translates to:
  /// **'Plant-based cheese and toppings; no animal products.'**
  String get pizzaVeganDesc;

  /// No description provided for @pizzaVeganFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A compassionate creation featuring plant-based cheese, fresh vegetables, and house-made vegan tomato sauce. Every ingredient is carefully selected to ensure both flavor and ethics are satisfied. Delicious food that does good.'**
  String get pizzaVeganFullDesc;

  /// No description provided for @pizzaStuffedCrust.
  ///
  /// In en, this message translates to:
  /// **'Stuffed Crust'**
  String get pizzaStuffedCrust;

  /// No description provided for @pizzaStuffedCrustDesc.
  ///
  /// In en, this message translates to:
  /// **'Cheese-filled crust edge for the indulgent.'**
  String get pizzaStuffedCrustDesc;

  /// No description provided for @pizzaStuffedCrustFullDesc.
  ///
  /// In en, this message translates to:
  /// **'The ultimate indulgence featuring a crust stuffed with gooey mozzarella cheese. Every bite includes that extra stretch of melted cheese. Topped with pepperoni and our signature sauce, this is pizza\'s answer to a warm hug.'**
  String get pizzaStuffedCrustFullDesc;

  /// No description provided for @pizzaWhite.
  ///
  /// In en, this message translates to:
  /// **'White Pizza'**
  String get pizzaWhite;

  /// No description provided for @pizzaWhiteDesc.
  ///
  /// In en, this message translates to:
  /// **'Ricotta, mozzarella, olive oil, garlic—no tomato sauce.'**
  String get pizzaWhiteDesc;

  /// No description provided for @pizzaWhiteFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A sophisticated departure from the red sauce crowd. Creamy ricotta and mozzarella mingle with roasted garlic and fresh herbs on a perfectly baked crust. The absence of tomato sauce lets the pure, dairy-forward flavors shine through.'**
  String get pizzaWhiteFullDesc;

  /// No description provided for @pizzaNewYorkStyle.
  ///
  /// In en, this message translates to:
  /// **'New York Style'**
  String get pizzaNewYorkStyle;

  /// No description provided for @pizzaNewYorkStyleDesc.
  ///
  /// In en, this message translates to:
  /// **'Large, foldable slices; thin but sturdy crust.'**
  String get pizzaNewYorkStyleDesc;

  /// No description provided for @pizzaNewYorkStyleFullDesc.
  ///
  /// In en, this message translates to:
  /// **'The quintessential New York slice that made pizza famous worldwide. Thin, foldable crust with just the right amount of char. Premium pepperoni and our house tomato sauce create that perfect ratio of crust to topping that defines NYC pizza perfection.'**
  String get pizzaNewYorkStyleFullDesc;

  /// No description provided for @pizzaChicagoDeepDish.
  ///
  /// In en, this message translates to:
  /// **'Chicago Deep Dish'**
  String get pizzaChicagoDeepDish;

  /// No description provided for @pizzaChicagoDeepDishDesc.
  ///
  /// In en, this message translates to:
  /// **'Thick, pie-like crust with layered cheese and sauce.'**
  String get pizzaChicagoDeepDishDesc;

  /// No description provided for @pizzaChicagoDeepDishFullDesc.
  ///
  /// In en, this message translates to:
  /// **'The king of deep dish pizzas, built in a cast-iron skillet for that perfect buttery crust. Layered cheese and chunky tomato sauce create a hearty, satisfying pie that\'s more casserole than pizza. A Chicago institution worth every calorie.'**
  String get pizzaChicagoDeepDishFullDesc;

  /// No description provided for @pizzaDetroitStyle.
  ///
  /// In en, this message translates to:
  /// **'Detroit Style'**
  String get pizzaDetroitStyle;

  /// No description provided for @pizzaDetroitStyleDesc.
  ///
  /// In en, this message translates to:
  /// **'Rectangular pan, caramelized cheese edges.'**
  String get pizzaDetroitStyleDesc;

  /// No description provided for @pizzaDetroitStyleFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Detroit\'s answer to the deep dish, featuring a rectangular pan that creates those legendary caramelized cheese edges. The crispy bottom and cheesy perimeter make this style uniquely addictive. Brick cheese and pepperoni create the perfect Motor City experience.'**
  String get pizzaDetroitStyleFullDesc;

  /// No description provided for @pizzaCaliforniaStyle.
  ///
  /// In en, this message translates to:
  /// **'California Style'**
  String get pizzaCaliforniaStyle;

  /// No description provided for @pizzaCaliforniaStyleDesc.
  ///
  /// In en, this message translates to:
  /// **'Thin crust with unconventional fresh toppings.'**
  String get pizzaCaliforniaStyleDesc;

  /// No description provided for @pizzaCaliforniaStyleFullDesc.
  ///
  /// In en, this message translates to:
  /// **'California dreaming on a crust featuring goat cheese, walnuts, and fresh figs. This innovative style broke all the rules when it debuted, proving that pizza could be both gourmet and approachable. A celebration of fresh, seasonal ingredients.'**
  String get pizzaCaliforniaStyleFullDesc;

  /// No description provided for @pizzaNeapolitan.
  ///
  /// In en, this message translates to:
  /// **'Neapolitan'**
  String get pizzaNeapolitan;

  /// No description provided for @pizzaNeapolitanDesc.
  ///
  /// In en, this message translates to:
  /// **'Thin, soft, wood-fired with blistered edges.'**
  String get pizzaNeapolitanDesc;

  /// No description provided for @pizzaNeapolitanFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Authentic Neapolitan pizza as it\'s meant to be eaten. High-hydration dough creates that perfect leopard spotting when cooked at 900°F in our wood-fired oven. Fresh, simple ingredients that capture the essence of Naples in every tender bite.'**
  String get pizzaNeapolitanFullDesc;

  /// No description provided for @pizzaRomanAlTaglio.
  ///
  /// In en, this message translates to:
  /// **'Roman al Taglio'**
  String get pizzaRomanAlTaglio;

  /// No description provided for @pizzaRomanAlTaglioDesc.
  ///
  /// In en, this message translates to:
  /// **'Rectangular, thin, crisp; sold by the slice.'**
  String get pizzaRomanAlTaglioDesc;

  /// No description provided for @pizzaRomanAlTaglioFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Roman-style pizza that\'s all about sharing. Thin, crisp crust topped with seasonal ingredients and cut into rectangles. The perfect canvas for creative toppings and communal dining. Each slice tells its own story of Roman culinary tradition.'**
  String get pizzaRomanAlTaglioFullDesc;

  /// No description provided for @pizzaSicilian.
  ///
  /// In en, this message translates to:
  /// **'Sicilian (Sfinciuni)'**
  String get pizzaSicilian;

  /// No description provided for @pizzaSicilianDesc.
  ///
  /// In en, this message translates to:
  /// **'Thick, airy crust; onion-forward sauce.'**
  String get pizzaSicilianDesc;

  /// No description provided for @pizzaSicilianFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Thick, focaccia-like crust topped with sweet onions, anchovies, and herbs. This Sicilian classic features a bread-like base that\'s perfect for soaking up the savory tomato sauce. A hearty, flavorful experience that\'s uniquely Sicilian.'**
  String get pizzaSicilianFullDesc;

  /// No description provided for @pizzaMargherita.
  ///
  /// In en, this message translates to:
  /// **'Margherita – The Mistress'**
  String get pizzaMargherita;

  /// No description provided for @pizzaMargheritaDesc.
  ///
  /// In en, this message translates to:
  /// **'Thin crust trusted by the Don.'**
  String get pizzaMargheritaDesc;

  /// No description provided for @pizzaMargheritaFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A masterpiece of simplicity, this classic Margherita combines the freshest San Marzano tomatoes, creamy mozzarella di bufala, and fragrant basil leaves. Each bite tells a story of Italian tradition, where the perfect balance of flavors creates an unforgettable experience that has stood the test of time.'**
  String get pizzaMargheritaFullDesc;

  /// No description provided for @pizzaPepperoniClassic.
  ///
  /// In en, this message translates to:
  /// **'Pepperoni Classic'**
  String get pizzaPepperoniClassic;

  /// No description provided for @pizzaPepperoniClassicDesc.
  ///
  /// In en, this message translates to:
  /// **'Tomato sauce, mozzarella, pepperoni slices.'**
  String get pizzaPepperoniClassicDesc;

  /// No description provided for @pizzaPepperoniClassicFullDesc.
  ///
  /// In en, this message translates to:
  /// **'The pizza that started it all. Simple, perfect, and utterly satisfying. Our house tomato sauce, premium mozzarella, and classic pepperoni slices come together in perfect harmony. Sometimes the classics are classics for a reason.'**
  String get pizzaPepperoniClassicFullDesc;

  /// No description provided for @pizzaCheeseClassic.
  ///
  /// In en, this message translates to:
  /// **'Cheese Classic'**
  String get pizzaCheeseClassic;

  /// No description provided for @pizzaCheeseClassicDesc.
  ///
  /// In en, this message translates to:
  /// **'Tomato sauce and mozzarella; minimalist and comforting.'**
  String get pizzaCheeseClassicDesc;

  /// No description provided for @pizzaCheeseClassicFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Pure, unadulterated pizza perfection. Just our house tomato sauce, premium mozzarella, and a kiss of olive oil. This minimalist approach lets the quality of our ingredients shine through. Simple ingredients, simply extraordinary.'**
  String get pizzaCheeseClassicFullDesc;

  /// No description provided for @pizzaVeggieClassic.
  ///
  /// In en, this message translates to:
  /// **'Veggie Classic'**
  String get pizzaVeggieClassic;

  /// No description provided for @pizzaVeggieClassicDesc.
  ///
  /// In en, this message translates to:
  /// **'Peppers, onions, olives, mushrooms.'**
  String get pizzaVeggieClassicDesc;

  /// No description provided for @pizzaVeggieClassicFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A garden-fresh celebration of vegetables done right. Crisp bell peppers, sweet onions, briny olives, and earthy mushrooms create a symphony of textures and flavors. Our vegetarian masterpiece proves that meat isn\'t necessary for extraordinary pizza.'**
  String get pizzaVeggieClassicFullDesc;

  /// No description provided for @pizzaCapreseHitman.
  ///
  /// In en, this message translates to:
  /// **'Caprese Hitman'**
  String get pizzaCapreseHitman;

  /// No description provided for @pizzaCapreseHitmanDesc.
  ///
  /// In en, this message translates to:
  /// **'Fresh mozz, basil, olive mafia drizzle.'**
  String get pizzaCapreseHitmanDesc;

  /// No description provided for @pizzaCapreseHitmanFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A Sicilian-inspired masterpiece featuring the classic Caprese combination elevated to perfection. Juicy heirloom tomatoes, creamy fresh mozzarella, and fragrant basil come together with our signature olive oil reduction. Each slice captures the essence of Mediterranean sunshine.'**
  String get pizzaCapreseHitmanFullDesc;

  /// No description provided for @pizzaTruffleWhiteHit.
  ///
  /// In en, this message translates to:
  /// **'Truffle White Hit'**
  String get pizzaTruffleWhiteHit;

  /// No description provided for @pizzaTruffleWhiteHitDesc.
  ///
  /// In en, this message translates to:
  /// **'White sauce, parmesan rain.'**
  String get pizzaTruffleWhiteHitDesc;

  /// No description provided for @pizzaTruffleWhiteHitFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Indulge in luxury with our truffle-infused white pizza. Creamy ricotta and parmesan create a velvety canvas for earthy black truffles and fresh herbs. This sophisticated creation elevates the simple white pizza to a gourmet experience worthy of the finest Italian trattorias.'**
  String get pizzaTruffleWhiteHitFullDesc;

  /// No description provided for @pizzaBrickOvenDon.
  ///
  /// In en, this message translates to:
  /// **'Brick Oven Don'**
  String get pizzaBrickOvenDon;

  /// No description provided for @pizzaBrickOvenDonDesc.
  ///
  /// In en, this message translates to:
  /// **'Fire-kissed crust, basil oil.'**
  String get pizzaBrickOvenDonDesc;

  /// No description provided for @pizzaBrickOvenDonFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Experience the authentic taste of Naples with our wood-fired pizza baked in a traditional brick oven. The high-heat cooking creates that perfect leopard spotting on the crust while preserving the delicate balance of fresh ingredients and aromatic basil-infused olive oil.'**
  String get pizzaBrickOvenDonFullDesc;

  /// No description provided for @pizzaSmokyCapoBBQ.
  ///
  /// In en, this message translates to:
  /// **'Smoky Capo BBQ'**
  String get pizzaSmokyCapoBBQ;

  /// No description provided for @pizzaSmokyCapoBBQDesc.
  ///
  /// In en, this message translates to:
  /// **'Brick oven, sweet heat.'**
  String get pizzaSmokyCapoBBQDesc;

  /// No description provided for @pizzaSmokyCapoBBQFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Our signature BBQ pizza brings together the smoky depth of slow-cooked brisket with tangy house-made BBQ sauce and caramelized onions. The perfect marriage of Southern comfort and Italian tradition creates a flavor profile that\'s equal parts comforting and crave-worthy.'**
  String get pizzaSmokyCapoBBQFullDesc;

  /// No description provided for @pizzaVelvetPepperoni.
  ///
  /// In en, this message translates to:
  /// **'Velvet Pepperoni'**
  String get pizzaVelvetPepperoni;

  /// No description provided for @pizzaVelvetPepperoniDesc.
  ///
  /// In en, this message translates to:
  /// **'Loaded curls, velvet cheese pull.'**
  String get pizzaVelvetPepperoniDesc;

  /// No description provided for @pizzaVelvetPepperoniFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Our take on the classic pepperoni pizza features premium pepperoni cups that curl perfectly during baking, creating crispy edges and juicy centers. Combined with our house tomato sauce and stretchy mozzarella, this is comfort food at its finest.'**
  String get pizzaVelvetPepperoniFullDesc;

  /// No description provided for @pizzaHawaiianBacon.
  ///
  /// In en, this message translates to:
  /// **'Hawaiian Bacon'**
  String get pizzaHawaiianBacon;

  /// No description provided for @pizzaHawaiianBaconDesc.
  ///
  /// In en, this message translates to:
  /// **'Ham, bacon, pineapple, and green onions.'**
  String get pizzaHawaiianBaconDesc;

  /// No description provided for @pizzaHawaiianBaconFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A tropical paradise on a pizza! Sweet and savory collide with juicy pineapple, diced ham, crispy bacon, and fresh green onions. This island-inspired classic combines the best of both worlds - the sweetness of pineapple with the rich, smoky flavors of ham and bacon. Perfect for those who love bold, contrasting flavors.'**
  String get pizzaHawaiianBaconFullDesc;

  /// No description provided for @pizzaSupreme.
  ///
  /// In en, this message translates to:
  /// **'Supreme'**
  String get pizzaSupreme;

  /// No description provided for @pizzaSupremeDesc.
  ///
  /// In en, this message translates to:
  /// **'Loaded with pepperoni, sausage, peppers, onions, and mushrooms.'**
  String get pizzaSupremeDesc;

  /// No description provided for @pizzaSupremeFullDesc.
  ///
  /// In en, this message translates to:
  /// **'The ultimate pizza loaded with all your favorites. Premium pepperoni, Italian sausage, bell peppers, onions, and mushrooms come together on our house tomato sauce and mozzarella. A hearty, satisfying classic that never disappoints.'**
  String get pizzaSupremeFullDesc;

  /// No description provided for @pizzaMeatLover.
  ///
  /// In en, this message translates to:
  /// **'Meat Lover'**
  String get pizzaMeatLover;

  /// No description provided for @pizzaMeatLoverDesc.
  ///
  /// In en, this message translates to:
  /// **'Pepperoni, sausage, bacon, and ham.'**
  String get pizzaMeatLoverDesc;

  /// No description provided for @pizzaMeatLoverFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A carnivore\'s dream come true! This hearty pizza is loaded with premium pepperoni, Italian sausage, crispy bacon, and savory ham. Every bite delivers a protein-packed punch of flavor. Perfect for those who believe more meat is always better.'**
  String get pizzaMeatLoverFullDesc;

  /// No description provided for @pizzaMexicali.
  ///
  /// In en, this message translates to:
  /// **'Mexicali'**
  String get pizzaMexicali;

  /// No description provided for @pizzaMexicaliDesc.
  ///
  /// In en, this message translates to:
  /// **'Spicy Mexican-inspired toppings with jalapeños.'**
  String get pizzaMexicaliDesc;

  /// No description provided for @pizzaMexicaliFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A fiesta of flavors on a pizza! Our Mexicali pizza brings together the bold spices of Mexico with classic Italian pizza. Featuring spicy ground beef, jalapeños, bell peppers, onions, and our signature Mexican cheese blend. A fusion that\'s as exciting as it is delicious.'**
  String get pizzaMexicaliFullDesc;

  /// No description provided for @pizzaChickenTikkaMasala.
  ///
  /// In en, this message translates to:
  /// **'Chicken Tikka Masala'**
  String get pizzaChickenTikkaMasala;

  /// No description provided for @pizzaChickenTikkaMasalaDesc.
  ///
  /// In en, this message translates to:
  /// **'Indian-inspired with tikka masala chicken.'**
  String get pizzaChickenTikkaMasalaDesc;

  /// No description provided for @pizzaChickenTikkaMasalaFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Experience the rich, aromatic flavors of India on a perfectly baked pizza crust. Tender marinated chicken tikka, creamy masala sauce, red onions, and fresh cilantro create an unforgettable fusion. This bold creation brings the warmth of Indian spices to Italian tradition.'**
  String get pizzaChickenTikkaMasalaFullDesc;

  /// No description provided for @pizzaAlfredoChicken.
  ///
  /// In en, this message translates to:
  /// **'Alfredo Chicken'**
  String get pizzaAlfredoChicken;

  /// No description provided for @pizzaAlfredoChickenDesc.
  ///
  /// In en, this message translates to:
  /// **'Creamy alfredo sauce with grilled chicken.'**
  String get pizzaAlfredoChickenDesc;

  /// No description provided for @pizzaAlfredoChickenFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Indulge in creamy perfection with our Alfredo Chicken pizza. Tender grilled chicken breast, rich alfredo sauce, and mozzarella cheese come together on a golden crust. A white pizza that\'s as comforting as it is elegant. Pure creamy satisfaction in every bite.'**
  String get pizzaAlfredoChickenFullDesc;

  /// No description provided for @combosDeals.
  ///
  /// In en, this message translates to:
  /// **'Combos / Deals'**
  String get combosDeals;

  /// No description provided for @combo2SlicesDrink.
  ///
  /// In en, this message translates to:
  /// **'Buy 2 Slices + Drink'**
  String get combo2SlicesDrink;

  /// No description provided for @combo2SlicesDrinkDesc.
  ///
  /// In en, this message translates to:
  /// **'Two slices of pizza with your choice of drink.'**
  String get combo2SlicesDrinkDesc;

  /// No description provided for @combo2SlicesDrinkFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Great value combo! Get two slices of pizza from our selection and a refreshing drink to complete your meal.'**
  String get combo2SlicesDrinkFullDesc;

  /// No description provided for @comboSliceDrink.
  ///
  /// In en, this message translates to:
  /// **'Slice + Drink'**
  String get comboSliceDrink;

  /// No description provided for @comboSliceDrinkDesc.
  ///
  /// In en, this message translates to:
  /// **'One slice of pizza with a drink.'**
  String get comboSliceDrinkDesc;

  /// No description provided for @comboSliceDrinkFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Perfect for a quick meal! One delicious slice of pizza paired with your favorite drink.'**
  String get comboSliceDrinkFullDesc;

  /// No description provided for @comboSliceWingsSoda.
  ///
  /// In en, this message translates to:
  /// **'Slice Pizza + Wings + Soda'**
  String get comboSliceWingsSoda;

  /// No description provided for @comboSliceWingsSodaDesc.
  ///
  /// In en, this message translates to:
  /// **'One slice of pizza, wings, and a soda.'**
  String get comboSliceWingsSodaDesc;

  /// No description provided for @comboSliceWingsSodaFullDesc.
  ///
  /// In en, this message translates to:
  /// **'The perfect combo for the hungry! One slice of pizza, crispy wings with your choice of sauce, and a refreshing soda.'**
  String get comboSliceWingsSodaFullDesc;

  /// No description provided for @combo10WingsDrink.
  ///
  /// In en, this message translates to:
  /// **'10 Wings + Drink'**
  String get combo10WingsDrink;

  /// No description provided for @combo10WingsDrinkDesc.
  ///
  /// In en, this message translates to:
  /// **'Ten wings with your choice of sauce and a drink.'**
  String get combo10WingsDrinkDesc;

  /// No description provided for @combo10WingsDrinkFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Wing lover\'s delight! Ten crispy wings tossed in your favorite sauce, paired with a refreshing drink.'**
  String get combo10WingsDrinkFullDesc;

  /// No description provided for @wingsBoneless.
  ///
  /// In en, this message translates to:
  /// **'Wings / Boneless'**
  String get wingsBoneless;

  /// No description provided for @wingsBuffalo.
  ///
  /// In en, this message translates to:
  /// **'Buffalo Wings'**
  String get wingsBuffalo;

  /// No description provided for @wingsBuffaloDesc.
  ///
  /// In en, this message translates to:
  /// **'Classic spicy buffalo wings.'**
  String get wingsBuffaloDesc;

  /// No description provided for @wingsBuffaloFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Crispy chicken wings tossed in our signature spicy buffalo sauce. Tangy, hot, and perfectly balanced - the ultimate wing experience.'**
  String get wingsBuffaloFullDesc;

  /// No description provided for @wingsGarlicParmesan.
  ///
  /// In en, this message translates to:
  /// **'Garlic Parmesan Wings'**
  String get wingsGarlicParmesan;

  /// No description provided for @wingsGarlicParmesanDesc.
  ///
  /// In en, this message translates to:
  /// **'Crispy wings with garlic parmesan sauce.'**
  String get wingsGarlicParmesanDesc;

  /// No description provided for @wingsGarlicParmesanFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Perfectly crispy wings coated in a rich, savory garlic parmesan sauce. Buttery, garlicky, and cheesy - a flavor explosion in every bite.'**
  String get wingsGarlicParmesanFullDesc;

  /// No description provided for @wingsBBQ.
  ///
  /// In en, this message translates to:
  /// **'BBQ Wings'**
  String get wingsBBQ;

  /// No description provided for @wingsBBQDesc.
  ///
  /// In en, this message translates to:
  /// **'Sweet and smoky BBQ wings.'**
  String get wingsBBQDesc;

  /// No description provided for @wingsBBQFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Tender wings glazed with our house-made BBQ sauce. Sweet, smoky, and slightly tangy - finger-licking good!'**
  String get wingsBBQFullDesc;

  /// No description provided for @wingsMangoHabanero.
  ///
  /// In en, this message translates to:
  /// **'Mango Habanero Wings'**
  String get wingsMangoHabanero;

  /// No description provided for @wingsMangoHabaneroDesc.
  ///
  /// In en, this message translates to:
  /// **'Spicy wings with sweet mango habanero sauce.'**
  String get wingsMangoHabaneroDesc;

  /// No description provided for @wingsMangoHabaneroFullDesc.
  ///
  /// In en, this message translates to:
  /// **'For those who love heat! Crispy wings tossed in a fiery mango habanero sauce that brings the perfect balance of sweet tropical fruit and intense spice.'**
  String get wingsMangoHabaneroFullDesc;

  /// No description provided for @wingsLemonPepper.
  ///
  /// In en, this message translates to:
  /// **'Lemon Pepper Wings'**
  String get wingsLemonPepper;

  /// No description provided for @wingsLemonPepperDesc.
  ///
  /// In en, this message translates to:
  /// **'Zesty lemon pepper seasoned wings.'**
  String get wingsLemonPepperDesc;

  /// No description provided for @wingsLemonPepperFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Bright and zesty wings seasoned with fresh lemon and cracked black pepper. Light, refreshing, and packed with flavor.'**
  String get wingsLemonPepperFullDesc;

  /// No description provided for @wingsHotHoney.
  ///
  /// In en, this message translates to:
  /// **'Hot Honey Wings'**
  String get wingsHotHoney;

  /// No description provided for @wingsHotHoneyDesc.
  ///
  /// In en, this message translates to:
  /// **'Sweet and spicy hot honey glazed wings.'**
  String get wingsHotHoneyDesc;

  /// No description provided for @wingsHotHoneyFullDesc.
  ///
  /// In en, this message translates to:
  /// **'The perfect sweet and heat combination! Crispy wings glazed with our hot honey sauce - sweet honey meets fiery heat for an unforgettable taste.'**
  String get wingsHotHoneyFullDesc;

  /// No description provided for @dips.
  ///
  /// In en, this message translates to:
  /// **'Dips'**
  String get dips;

  /// No description provided for @dipHoneyMustard.
  ///
  /// In en, this message translates to:
  /// **'Honey Mustard'**
  String get dipHoneyMustard;

  /// No description provided for @dipHoneyMustardDesc.
  ///
  /// In en, this message translates to:
  /// **'Sweet and tangy honey mustard dip.'**
  String get dipHoneyMustardDesc;

  /// No description provided for @dipHoneyMustardFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A perfect blend of sweet honey and tangy mustard creating a delightful dipping sauce that complements any dish.'**
  String get dipHoneyMustardFullDesc;

  /// No description provided for @dipGarlic.
  ///
  /// In en, this message translates to:
  /// **'Garlic Dip'**
  String get dipGarlic;

  /// No description provided for @dipGarlicDesc.
  ///
  /// In en, this message translates to:
  /// **'Creamy garlic dip with herbs.'**
  String get dipGarlicDesc;

  /// No description provided for @dipGarlicFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Rich and creamy garlic dip infused with fresh herbs, perfect for fries, wings, and more.'**
  String get dipGarlicFullDesc;

  /// No description provided for @dipParmesan.
  ///
  /// In en, this message translates to:
  /// **'Parmesan Dip'**
  String get dipParmesan;

  /// No description provided for @dipParmesanDesc.
  ///
  /// In en, this message translates to:
  /// **'Creamy parmesan cheese dip.'**
  String get dipParmesanDesc;

  /// No description provided for @dipParmesanFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Luxurious parmesan cheese dip with a smooth, creamy texture that elevates any side dish.'**
  String get dipParmesanFullDesc;

  /// No description provided for @dipItalianDressing.
  ///
  /// In en, this message translates to:
  /// **'Italian Dressing'**
  String get dipItalianDressing;

  /// No description provided for @dipItalianDressingDesc.
  ///
  /// In en, this message translates to:
  /// **'Classic Italian dressing dip.'**
  String get dipItalianDressingDesc;

  /// No description provided for @dipItalianDressingFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Traditional Italian dressing with herbs and spices, perfect as a dip or dressing.'**
  String get dipItalianDressingFullDesc;

  /// No description provided for @dipRanch.
  ///
  /// In en, this message translates to:
  /// **'Ranch'**
  String get dipRanch;

  /// No description provided for @dipRanchDesc.
  ///
  /// In en, this message translates to:
  /// **'Creamy ranch dip with herbs.'**
  String get dipRanchDesc;

  /// No description provided for @dipRanchFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Classic creamy ranch dip with a perfect blend of herbs and spices. Cool, tangy, and refreshing - the ultimate dipping sauce for wings, fries, and more.'**
  String get dipRanchFullDesc;

  /// No description provided for @dipBlueCheese.
  ///
  /// In en, this message translates to:
  /// **'Blue Cheese'**
  String get dipBlueCheese;

  /// No description provided for @dipBlueCheeseDesc.
  ///
  /// In en, this message translates to:
  /// **'Rich and tangy blue cheese dip.'**
  String get dipBlueCheeseDesc;

  /// No description provided for @dipBlueCheeseFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Bold and tangy blue cheese dip with chunks of real blue cheese. Rich, creamy, and full of flavor - a sophisticated choice for wings and vegetables.'**
  String get dipBlueCheeseFullDesc;

  /// No description provided for @fries.
  ///
  /// In en, this message translates to:
  /// **'Fries'**
  String get fries;

  /// No description provided for @friesGarlic.
  ///
  /// In en, this message translates to:
  /// **'Garlic Fries'**
  String get friesGarlic;

  /// No description provided for @friesGarlicDesc.
  ///
  /// In en, this message translates to:
  /// **'Crispy fries tossed with garlic and herbs.'**
  String get friesGarlicDesc;

  /// No description provided for @friesGarlicFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Golden crispy fries tossed with fresh minced garlic, parsley, and a hint of parmesan. A flavorful twist on the classic side.'**
  String get friesGarlicFullDesc;

  /// No description provided for @friesPlain.
  ///
  /// In en, this message translates to:
  /// **'Plain Fries'**
  String get friesPlain;

  /// No description provided for @friesPlainDesc.
  ///
  /// In en, this message translates to:
  /// **'Classic crispy golden fries.'**
  String get friesPlainDesc;

  /// No description provided for @friesPlainFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Perfectly seasoned golden fries, crispy on the outside and fluffy on the inside. The classic side dish that never disappoints.'**
  String get friesPlainFullDesc;

  /// No description provided for @salads.
  ///
  /// In en, this message translates to:
  /// **'Salads'**
  String get salads;

  /// No description provided for @saladCaesar.
  ///
  /// In en, this message translates to:
  /// **'Caesar Salad'**
  String get saladCaesar;

  /// No description provided for @saladCaesarDesc.
  ///
  /// In en, this message translates to:
  /// **'Classic Caesar salad with romaine lettuce.'**
  String get saladCaesarDesc;

  /// No description provided for @saladCaesarFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Crisp romaine lettuce tossed with our house-made Caesar dressing, parmesan cheese, and crunchy croutons. A timeless classic that never goes out of style.'**
  String get saladCaesarFullDesc;

  /// No description provided for @saladGreen.
  ///
  /// In en, this message translates to:
  /// **'Green Salad'**
  String get saladGreen;

  /// No description provided for @saladGreenDesc.
  ///
  /// In en, this message translates to:
  /// **'Fresh mixed greens with your choice of dressing.'**
  String get saladGreenDesc;

  /// No description provided for @saladGreenFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A refreshing mix of fresh greens, vegetables, and your choice of house dressing. Light, healthy, and delicious.'**
  String get saladGreenFullDesc;

  /// No description provided for @small.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get small;

  /// No description provided for @large.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get large;

  /// No description provided for @pasta.
  ///
  /// In en, this message translates to:
  /// **'Pasta'**
  String get pasta;

  /// No description provided for @pastaChickenAlfredo.
  ///
  /// In en, this message translates to:
  /// **'Chicken Alfredo'**
  String get pastaChickenAlfredo;

  /// No description provided for @pastaChickenAlfredoDesc.
  ///
  /// In en, this message translates to:
  /// **'Creamy alfredo pasta with tender chicken.'**
  String get pastaChickenAlfredoDesc;

  /// No description provided for @pastaChickenAlfredoFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Tender grilled chicken breast served over fettuccine pasta in a rich, creamy alfredo sauce. Garnished with parmesan cheese and fresh parsley for a comforting, indulgent meal.'**
  String get pastaChickenAlfredoFullDesc;

  /// No description provided for @desserts.
  ///
  /// In en, this message translates to:
  /// **'Desserts'**
  String get desserts;

  /// No description provided for @dessertChocolateChipCookiePizza.
  ///
  /// In en, this message translates to:
  /// **'Chocolate Chip Cookie Pizza'**
  String get dessertChocolateChipCookiePizza;

  /// No description provided for @dessertChocolateChipCookiePizzaDesc.
  ///
  /// In en, this message translates to:
  /// **'Decadent chocolate chip cookie baked pizza-style.'**
  String get dessertChocolateChipCookiePizzaDesc;

  /// No description provided for @dessertChocolateChipCookiePizzaFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A giant warm chocolate chip cookie baked to perfection and served pizza-style. Gooey, chocolatey, and absolutely irresistible. Perfect for sharing or enjoying solo.'**
  String get dessertChocolateChipCookiePizzaFullDesc;

  /// No description provided for @dessertChocolateChurros.
  ///
  /// In en, this message translates to:
  /// **'Chocolate Churros'**
  String get dessertChocolateChurros;

  /// No description provided for @dessertChocolateChurrosDesc.
  ///
  /// In en, this message translates to:
  /// **'Crispy churros with chocolate dipping sauce.'**
  String get dessertChocolateChurrosDesc;

  /// No description provided for @dessertChocolateChurrosFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Golden, crispy churros dusted with cinnamon sugar, served with a rich chocolate dipping sauce. A sweet treat that satisfies every craving.'**
  String get dessertChocolateChurrosFullDesc;

  /// No description provided for @dessertCheesecake.
  ///
  /// In en, this message translates to:
  /// **'Cheesecake'**
  String get dessertCheesecake;

  /// No description provided for @dessertCheesecakeDesc.
  ///
  /// In en, this message translates to:
  /// **'Classic creamy New York-style cheesecake.'**
  String get dessertCheesecakeDesc;

  /// No description provided for @dessertCheesecakeFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Rich and creamy New York-style cheesecake with a buttery graham cracker crust. Smooth, decadent, and the perfect ending to any meal.'**
  String get dessertCheesecakeFullDesc;

  /// No description provided for @dessertFreshCannoli.
  ///
  /// In en, this message translates to:
  /// **'Fresh Cannoli'**
  String get dessertFreshCannoli;

  /// No description provided for @dessertFreshCannoliDesc.
  ///
  /// In en, this message translates to:
  /// **'Crispy shell filled with sweet ricotta cream.'**
  String get dessertFreshCannoliDesc;

  /// No description provided for @dessertFreshCannoliFullDesc.
  ///
  /// In en, this message translates to:
  /// **'Authentic Italian cannoli with a crispy, golden shell filled with sweet, creamy ricotta cheese. Topped with chocolate chips and dusted with powdered sugar. A traditional Sicilian treat that\'s both elegant and indulgent.'**
  String get dessertFreshCannoliFullDesc;

  /// No description provided for @drinks.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get drinks;

  /// No description provided for @drink2Liter.
  ///
  /// In en, this message translates to:
  /// **'2 Liter'**
  String get drink2Liter;

  /// No description provided for @drink2LiterDesc.
  ///
  /// In en, this message translates to:
  /// **'2 liter bottle of soft drink.'**
  String get drink2LiterDesc;

  /// No description provided for @drink2LiterFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A large 2 liter bottle of your favorite soft drink, perfect for sharing with family and friends.'**
  String get drink2LiterFullDesc;

  /// No description provided for @drink16oz.
  ///
  /// In en, this message translates to:
  /// **'16oz Drink'**
  String get drink16oz;

  /// No description provided for @drink16ozDesc.
  ///
  /// In en, this message translates to:
  /// **'16 ounce soft drink.'**
  String get drink16ozDesc;

  /// No description provided for @drink16ozFullDesc.
  ///
  /// In en, this message translates to:
  /// **'A refreshing 16 ounce soft drink to quench your thirst and complement your meal perfectly.'**
  String get drink16ozFullDesc;

  /// No description provided for @selectPizzaSlice.
  ///
  /// In en, this message translates to:
  /// **'Select Pizza Slice'**
  String get selectPizzaSlice;

  /// No description provided for @chooseFromOptions.
  ///
  /// In en, this message translates to:
  /// **'Choose from the options below'**
  String get chooseFromOptions;

  /// No description provided for @pizza10Inch.
  ///
  /// In en, this message translates to:
  /// **'10\" Pizza'**
  String get pizza10Inch;

  /// No description provided for @pizza18Inch.
  ///
  /// In en, this message translates to:
  /// **'18\" Pizza'**
  String get pizza18Inch;

  /// No description provided for @slice.
  ///
  /// In en, this message translates to:
  /// **'Slice'**
  String get slice;

  /// No description provided for @extraToppings.
  ///
  /// In en, this message translates to:
  /// **'Extra Toppings'**
  String get extraToppings;

  /// No description provided for @perTopping.
  ///
  /// In en, this message translates to:
  /// **'per topping'**
  String get perTopping;

  /// No description provided for @twoToppingsIncluded.
  ///
  /// In en, this message translates to:
  /// **'2 toppings included'**
  String get twoToppingsIncluded;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
