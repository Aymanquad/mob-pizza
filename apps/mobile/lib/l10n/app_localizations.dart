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

  /// No description provided for @trackJobs.
  ///
  /// In en, this message translates to:
  /// **'Track Jobs'**
  String get trackJobs;

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

  /// No description provided for @jobSummary.
  ///
  /// In en, this message translates to:
  /// **'Job Summary'**
  String get jobSummary;

  /// No description provided for @jobSummaryDesc.
  ///
  /// In en, this message translates to:
  /// **'Your cart, Mob-styled'**
  String get jobSummaryDesc;

  /// No description provided for @pastJobs.
  ///
  /// In en, this message translates to:
  /// **'Past Jobs'**
  String get pastJobs;

  /// No description provided for @pastJobsDesc.
  ///
  /// In en, this message translates to:
  /// **'Track & re-order'**
  String get pastJobsDesc;

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

  /// No description provided for @jobsClosed.
  ///
  /// In en, this message translates to:
  /// **'Jobs Closed'**
  String get jobsClosed;

  /// No description provided for @familyPoints.
  ///
  /// In en, this message translates to:
  /// **'Family Points'**
  String get familyPoints;

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
  /// **'Checkout'**
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
  /// **'Items'**
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
  /// **'Order Summary'**
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

  /// No description provided for @lockInTheJob.
  ///
  /// In en, this message translates to:
  /// **'Lock In the Job'**
  String get lockInTheJob;
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
