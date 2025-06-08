// LoginDataModel.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'balance_model.dart';
import 'superiors_model.dart';
import 'subordinate_model.dart';

part 'login_data_model.g.dart';

@JsonSerializable(explicitToJson: true) // explicitToJson helps with nested models
class LoginDataModel extends Equatable {
  final int id; // Assuming ID is never null from API
  final String loginId; // Assuming loginId is never null
  final String? name; // Made nullable
  @JsonKey(name: 'contactNo', defaultValue: '')
  final String? contactNo; // Made nullable
  final String? email; // Made nullable
  final String? mobileNumber; // Made nullable
  final String? dob; // Made nullable
  final String? designation; // Made nullable
  final String? cardNumber; // Made nullable
  final String? deviceCode; // Made nullable
  final String? cardType; // Made nullable
  final String? gender; // Made nullable
  final String? bloodGroup; // Made nullable
  final String? aadhaarNumber; // Made nullable
  final String? fatherName; // Made nullable
  final String? motherName; // Made nullable
  final String? placeOfBirth; // Made nullable
  final String? residentialAddress; // Made nullable
  final String? permanentAddress; // Made nullable
  final String? nominee1; // Made nullable
  final String? nominee2; // Made nullable
  @JsonKey(defaultValue: '')
  final String? employeeCode; // Already nullable
  @JsonKey(defaultValue: '')
  final String? lastModifiedBy; // Already nullable
  @JsonKey(defaultValue: '')
  final String? photo; // Already nullable
  final String? status; // Made nullable
  final bool isRecieveNotification; // Assuming bool is never null (or handle with default)
  final String? dateOfJoining; // Made nullable
  @JsonKey(defaultValue: '')
  final String? dateOfResignation; // Already nullable
  final String? dateOfConfirmation; // Made nullable
  final String? employmentType; // Made nullable
  final String authToken; // Assuming authToken is never null
  final List<String> roles; // Assuming list is never null (but can be empty)
  final List<BalanceModel> balances; // Assuming list is never null
  final List<SuperiorsModel> superiors; // Assuming list is never null
  final List<SubordinateModel> subordinates; // Assuming list is never null

  const LoginDataModel({
    required this.id,
    required this.loginId,
    this.name, // No longer required
    this.email, // No longer required
    this.mobileNumber, // No longer required
    this.dob, // No longer required
    this.designation, // No longer required
    required this.authToken, // Still required
    required this.roles,
    required this.balances,
    required this.superiors,
    required this.subordinates,
    this.contactNo, // No longer required
    this.cardNumber, // No longer required
    this.deviceCode, // No longer required
    this.cardType, // No longer required
    this.gender, // No longer required
    this.bloodGroup, // No longer required
    this.aadhaarNumber, // No longer required
    this.fatherName, // No longer required
    this.motherName, // No longer required
    this.placeOfBirth, // No longer required
    this.residentialAddress, // No longer required
    this.permanentAddress, // No longer required
    this.nominee1, // No longer required
    this.nominee2, // No longer required
    this.employeeCode = '', // Already nullable
    this.lastModifiedBy = '', // Already nullable
    this.photo = '', // Already nullable
    this.status, // No longer required
    required this.isRecieveNotification,
    this.dateOfJoining, // No longer required
    this.dateOfResignation = '', // Already nullable
    this.dateOfConfirmation, // No longer required
    this.employmentType, // No longer required
  });

  // Add explicitToJson: true in @JsonSerializable if BalanceModel, SuperiorsModel,
  // or SubordinateModel have their own toJson methods.
  factory LoginDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    loginId,
    name,
    email,
    mobileNumber,
    dob,
    designation,
    authToken,
    roles,
    balances,
    superiors,
    subordinates,
    contactNo,
    cardNumber,
    deviceCode,
    cardType,
    gender,
    bloodGroup,
    aadhaarNumber,
    fatherName,
    motherName,
    placeOfBirth,
    residentialAddress,
    permanentAddress,
    nominee1,
    nominee2,
    employeeCode,
    lastModifiedBy,
    photo,
    status,
    isRecieveNotification,
    dateOfJoining,
    dateOfResignation,
    dateOfConfirmation,
    employmentType,
  ];
}