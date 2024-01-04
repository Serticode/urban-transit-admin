import 'package:fpdart/fpdart.dart';
import 'package:urban_transit_admin/shared/utils/failure.dart';

typedef FutureEither<SuccessType> = Future<Either<Failure, SuccessType>>;

typedef FutureVoid = FutureEither<void>;

enum AuthResult { success, failure, noResult }

enum ConnectivityStatus { wifi, mobile, online, offline }

enum DriverStatus { enroute, suspended, inactive }

enum TripPaymentType { cash, wallet }

typedef UserId = String;
typedef UserDisplayName = String;
typedef UserFullName = String;
typedef UserProfileImageType = String;
typedef IsLoading = bool;
typedef MeetingUploaded = bool;
typedef MeetingDeleted = bool;

enum UserInfoUpdateType { fullName, profession, email, phoneNumber }

enum NotificationType { success, failure, info }

enum AppHapticFeedbackType {
  lightImpact,
  mediumImpact,
  heavyImpact,
  selectionClick,
  vibrate,
}

enum FileType { image }

enum OrganizationType {
  school(orgName: "School"),
  church(orgName: "Church"),
  smallBusiness(orgName: "Small Business"),
  transportCompany(orgName: "Transport Company");

  final String orgName;

  const OrganizationType({
    required this.orgName,
  });
}
