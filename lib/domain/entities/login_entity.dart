import '../../data/models/response/balance_model.dart';
import '../../data/models/response/login_data_model.dart';
import '../../data/models/response/subordinate_model.dart';
import '../../data/models/response/superiors_model.dart';

class LoginEntity {
  final int id;
  final String loginId;
  final String? name; // Nullable
  final String? email; // Nullable
  final String? mobileNumber; // Nullable
  final String? dob; // Nullable
  final String? designation; // Nullable
  final String authToken;
  final List<String> roles;
  final List<BalanceModel> balances;
  final List<SuperiorsModel> superiors;
  final List<SubordinateModel> subordinates;
  final String? contactNo; // Nullable
  final String? employeeCode; // Nullable
  final String? lastModifiedBy; // Nullable
  final String? cardNumber; // Nullable
  final String? deviceCode; // Nullable
  final String? cardType; // Nullable
  final String? gender; // Nullable
  final String? bloodGroup; // Nullable
  final String? aadhaarNumber; // Nullable
  final String? fatherName; // Nullable
  final String? motherName; // Nullable
  final String? placeOfBirth; // Nullable
  final String? residentialAddress; // Nullable
  final String? permanentAddress; // Nullable
  final String? nominee1; // Nullable
  final String? nominee2; // Nullable
  // You might want to add other fields like photo, status, dates, etc., here
  // depending on whether your domain layer needs them.

  const LoginEntity({
    required this.id,
    required this.loginId,
    this.name, // Not required
    this.email, // Not required
    this.mobileNumber, // Not required
    this.dob, // Not required
    this.designation, // Not required
    required this.authToken,
    required this.roles,
    required this.balances,
    required this.superiors,
    required this.subordinates,
    this.contactNo, // Not required
    this.employeeCode, // Not required
    this.lastModifiedBy, // Not required
    this.cardNumber, // Not required
    this.deviceCode, // Not required
    this.cardType, // Not required
    this.gender, // Not required
    this.bloodGroup, // Not required
    this.aadhaarNumber, // Not required
    this.fatherName, // Not required
    this.motherName, // Not required
    this.placeOfBirth, // Not required
    this.residentialAddress, // Not required
    this.permanentAddress, // Not required
    this.nominee1, // Not required
    this.nominee2, // Not required
  });

// Add Equatable if needed for state management comparison
}

extension LoginDataModelMapper on LoginDataModel {
  LoginEntity toEntity() {
    // When mapping, you pass the potentially null values directly.
    // If your Entity needs non-null values, you must provide defaults here.
    return LoginEntity(
      id: id,
      loginId: loginId, // Assuming non-null
      name: name, // Pass nullable value
      email: email, // Pass nullable value
      mobileNumber: mobileNumber, // Pass nullable value
      dob: dob, // Pass nullable value
      designation: designation, // Pass nullable value
      authToken: authToken, // Assuming non-null
      roles: roles,
      balances: balances,
      superiors: superiors,
      subordinates: subordinates,
      contactNo: contactNo, // Pass nullable value
      employeeCode: employeeCode, // Pass nullable value
      lastModifiedBy: lastModifiedBy, // Pass nullable value
      cardNumber: cardNumber, // Pass nullable value
      deviceCode: deviceCode, // Pass nullable value
      cardType: cardType, // Pass nullable value
      gender: gender, // Pass nullable value
      bloodGroup: bloodGroup, // Pass nullable value
      aadhaarNumber: aadhaarNumber, // Pass nullable value
      fatherName: fatherName, // Pass nullable value
      motherName: motherName, // Pass nullable value
      placeOfBirth: placeOfBirth, // Pass nullable value
      residentialAddress: residentialAddress, // Pass nullable value
      permanentAddress: permanentAddress, // Pass nullable value
      nominee1: nominee1, // Pass nullable value
      nominee2: nominee2, // Pass nullable value
      // Map other fields like photo, status, dates if they exist in LoginEntity
    );
  }
}