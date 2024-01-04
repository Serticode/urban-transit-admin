abstract class AppTexts {
  //! APP NAME
  static const appName = "Urban Transit Admin";
  //! default email full
  static const String defaultEmail = "nileuniversityadmin@staff.edu.ng";

  //! SECURITY SETUP
  static const String securitySetup = "Security Setup";
  static const String securitySetupNotice =
      "We need to set up this admin account and make it unique for your organization. ";
  static const String securitySetupNotice2 =
      "A unique code will be sent to this email";
  static const String securitySetupInvalidEmail =
      "Email entered is not valid, Try again";
  static const String securitySetupSendOTP = "Send OTP";

  //! OTP VERIFICATION
  static const String otpVerification = "OTP Verification";
  static String otpVerificationNotice({required String userEmail}) =>
      "Enter the 5 digit code sent to your email \n$userEmail";
  static const String verifyOTP = "Verify OTP";
  static const resendOTP = "Resend OTP";

  //! NEW AUTH SETUP
  static const String newAuthSetup = "New Authentication Setup";
  static const String chooseAUserName = "Choose a Username";
  static const String newPassword = "New Password";
  static const String confirmPassword = "Confirm Password";
  static const String setupDetails = "Setup Details";
  static const String authSuccessfulHeader = "Authentication Setup Successful";
  static const String authSuccessNotice =
      "Successfully added, use your login \ninformation to access your dashboard and \nmonitor your drivers";
  static const String getStarted = "Get Started";
  static const String nileAdmin = "Nile Admin";
  static const String welcomeBack = "Welcome \nBack";
  static const String userName = "Username";
  static const String organizationName = "Organization Name";
  static const String organizationType = "School";
  static const String password = "Password";
  static const String login = "Login";
  static const String basicSetup = "Basic Setup";
  static const String basicSetupRider =
      "To make your experience better we need some additional information about your organization";
  static const String yourOrganizationName = "Your Organization’s Name";
  static const String yourOrganizationType = "Organization Type";
  static const String uploadProfileImage = "Upload Profile Image";
  static const String saveAndGoToDashboard = "Save & Go to Dashboard";

  //! TEXT FORM FIELD - HINTS AND LABELS
  static const String emailHint = "youremail@example.com";
  static const String emailLabel = "Your email";
  static const String yourUsername = "Your username";
  static const String yourPassword = "Your password";

  //! DASHBOARD
  static const String chatsHeader = "Chats";
  static const String drivers = "Drivers";
  static const String buses = "Buses";
  static const String adminInformation = "Admin Information";
  static const String call = "Calls";
  static const String writeAMessage = "Write a message";
  static const String urbanTransit = "Urban Transit";
  static const String inbox = "Inbox";
  static const String next = "Next";
  static const String addDriver = "Add Driver";
  static const String fullName = "Full Name";
  static const String busNumber = "Bus Number";
  static const String busSchedule = "Bus Schedule";
  static const String driversID = "Drivers ID";
  static const String sex = "Sex";
  static const String done = "Done";
  static const String generateID = "Generate ID";
  static const String email = "Email";
  static const String adminEmail = "Admin Email";
  static const String profilePhoto = "Profile Photo";
  static const String changeProfilePhoto = "Change Profile Photo";
  static const String nin = "NIN";
  static const String homeAddress = "Home Address";
  static const String phoneNumber = "Phone Number";
  static const String chooseBank = "Choose Bank";
  static const String from = "From";
  static const String to = "To";
  static const String accountNumber = "Account Number";
  static const String salaryOption = "Salary Option";
  static const String amountToBePaid = "Amount To Be Paid";
  static const String dateOfBirth = "Date of Birth";
  static const String documentUpload = "Document Upload";
  static const String documentUploadNotice = "Upload Drivers License";
  static const String uploadFileNotice = "Drag to upload or click to upload ";

  //! DRIVER STATUS
  static const String currentStatus = "Current Status";
  static const String viewOnMap = "View on Map";
}
