//! THIS FILE HOLDS ALL APP URLS / END POINT
//! UPDATE  WITH CAUTION
//!

abstract class AppUrls {
  //! RETRO STACK SITE
  static const String retroStackSite = "https://retrostack.retropay.app";
  static const String retroStackTwitter = "https://twitter.com/retrostackhq";
  static const String retroStackMail =
      "mailto:hello@retropay.app?subject=Retro Wallet Inquiry";

  //! BASE URL
  static const String _baseUrl = "https://api.retropay.app";
  static const String _accountBaseUrl = "https://api.retropay.app/account";
  static const _bankingBaseUrl = "https://api.retropay.app/banking";

  //! AUTHENTICATION
  //! USER SIGN UP
  static const String signUp = "$_baseUrl/account/auth/user/signup";

  //! LOGIN
  static const String login = "$_baseUrl/account/auth/user/login";

  //! CHANGE PASSWORD
  static const String changePassword =
      "$_baseUrl/account/auth/user/change-password";

  //! FORGOT PASSWORD
  static const String forgotPassword =
      "$_baseUrl/account/auth/user/forgot-password";

  //! RESET PASSWORD
  static const String resetPassword =
      "$_baseUrl/account/auth/user/reset-password";

  //! RE AUTHENTICATE WITH PIN
  static const String reauthenticateWithPin =
      "$_baseUrl/account/auth/user/reauthenticate";

  //!
  //!
  //! PROFILE
  //! VERIFY AVAILABLE USERNAME
  static String verifyAvailableUsername({required String chosenUserName}) =>
      "$_baseUrl/account/user/profile/account-tag/verify/$chosenUserName";

  //! SET UP USER NAME
  static const String setupUsername =
      "$_baseUrl/account/user/profile/account-tag/setup";

  //! VERIFY EMAIL
  static const String verifyEmail =
      "$_accountBaseUrl/user/profile/verify-email";

  //! EMAIL VERIFICATION TOKEN
  static const String emailVerificationToken =
      "$_accountBaseUrl/user/profile/send-email-token";

  //! VERIFY PHONE
  static const String verifyPhone =
      "$_baseUrl/account/user/profile/verify-phone";

  //! PHONE VERIFICATION TOKEN
  static const String phoneVerificationToken =
      "$_accountBaseUrl/user/profile/send-phone-token";

  //! UPDATE PROFILE PHOTO
  static const String updateProfilePhoto =
      "$_baseUrl/uploads/account/user/profile/upload-photo";

  //! SET TRANSACTION PIN
  static const String setTransactionPin = "$_accountBaseUrl/user/pin/set";
  //! CHANGE TRANSACTION PIN
  static const String changeTransactionPin = "$_accountBaseUrl/user/pin/change";
  //! RESET TRANSACTION PIN
  static const String resetTransactionPin = "$_accountBaseUrl/user/pin/forgot";

  //! DEACTIVATE ACCOUNT
  static const String deactivateAccount = "$_accountBaseUrl/user/deactivate";

  //! VERIFY IDENTITY STATUS
  static const String verifyIdentityStatus =
      "$_accountBaseUrl/user/verification/status?=";

  //! CANCEL VERIFY ID (KYC) PROCESS
  static const String cancelVerifyIdentityStatus =
      "$_accountBaseUrl/user/verification/cancelled";

  //!
  //!
  //! WALLET
  //! TRANSFER
  static const String transfer = "$_bankingBaseUrl/wallet/transfer";

  //! TRANSFER
  static const String withdrawFunds = "$_bankingBaseUrl/wallet/withdraw";

  //! RESOLVE ACCOUNT TAG
  static const String resolveAccountTag =
      "$_bankingBaseUrl/wallet/tag/resolve-account";

  //! TRANSACTION HISTORY BY MONTH
  static String getTransactionHistoryByMonth(
          {required String year, required String month}) =>
      "$_bankingBaseUrl/wallet/transactions/$year/$month";

  //! GET TRANSACTION
  static String getTransaction({required String reference}) =>
      "$_bankingBaseUrl/wallet/transactions/$reference";

  //! GET TRANSACTION STATUS
  static String getTransactionStatus({required String reference}) =>
      "$_bankingBaseUrl/wallet/transactions/$reference/status";

  //! GET TRANSACTION YEARLY SUMMARY
  static String getTransactionYearlySummary({required String year}) =>
      "$_bankingBaseUrl/wallet/transactions-summary/$year";

  //! GET BANK LISTS
  static const String getBankLists = "$_bankingBaseUrl/wallet/banks/list";

  //! RESOLVE BANK ACCOUNTS
  static const String resolveBankAccount =
      "$_bankingBaseUrl/wallet/bank/resolve-account";

  //! GET WALLET BALANCE
  static const String getWalletBalance = "$_bankingBaseUrl/wallet/balance";

  //! FAVORITE A RECIPIENT
  static const String addToFavourites =
      "$_accountBaseUrl/user/profile/favorite-recipients/add";

  //! GET FAVOURITES LIST
  static const String getFavouritesList =
      "$_accountBaseUrl/user/profile/favorite-recipients/list";

  //! REMOVE A RECIPIENT FROM FAVORITES
  static const String removeRecipientFromFavoriteList =
      "$_accountBaseUrl/user/profile/favorite-recipients/delete";

  //! CREATE NUBAN ACCOUNT
  static const String createNubanAccount = "$_accountBaseUrl/user/nuban/create";

  //! GET USER BY TAG - RESOLVE
  static const String getUserByTag = "$_baseUrl/user/:username/resolve";

  //! GET USER INFO
  static const String getUserInfo = "$_accountBaseUrl/user/profile";

  //! GET NOTIFICATIONS
  static const String getNotifications = "$_accountBaseUrl/user/notifications";

  //! EXAMPLE.COM
  static const String example = "example.com";

  //!
  //!
  //! BILLS AND PAYMENTS
  static String listAllBillProviders({required String billCategory}) =>
      "$_bankingBaseUrl/bills/categories/$billCategory/providers";

  //! VERIFY BILL RECIPIENT
  static const String verifyBillRecipient =
      "$_bankingBaseUrl/bills/customer/verify";

  //! PURCHASE BILL
  static const String purchaseBill = "$_bankingBaseUrl/bills/purchase";

  //!
  //!
  //! PUSH NOTIFICATION
  static const String setPushNotificationID =
      "$_accountBaseUrl/user/profile/deviceId/set";
}
