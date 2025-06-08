// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDataModel _$LoginDataModelFromJson(Map<String, dynamic> json) =>
    LoginDataModel(
      id: (json['id'] as num).toInt(),
      loginId: json['loginId'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      dob: json['dob'] as String?,
      designation: json['designation'] as String?,
      authToken: json['authToken'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      balances: (json['balances'] as List<dynamic>)
          .map((e) => BalanceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      superiors: (json['superiors'] as List<dynamic>)
          .map((e) => SuperiorsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subordinates: (json['subordinates'] as List<dynamic>)
          .map((e) => SubordinateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      contactNo: json['contactNo'] as String? ?? '',
      cardNumber: json['cardNumber'] as String?,
      deviceCode: json['deviceCode'] as String?,
      cardType: json['cardType'] as String?,
      gender: json['gender'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
      aadhaarNumber: json['aadhaarNumber'] as String?,
      fatherName: json['fatherName'] as String?,
      motherName: json['motherName'] as String?,
      placeOfBirth: json['placeOfBirth'] as String?,
      residentialAddress: json['residentialAddress'] as String?,
      permanentAddress: json['permanentAddress'] as String?,
      nominee1: json['nominee1'] as String?,
      nominee2: json['nominee2'] as String?,
      employeeCode: json['employeeCode'] as String? ?? '',
      lastModifiedBy: json['lastModifiedBy'] as String? ?? '',
      photo: json['photo'] as String? ?? '',
      status: json['status'] as String?,
      isRecieveNotification: json['isRecieveNotification'] as bool,
      dateOfJoining: json['dateOfJoining'] as String?,
      dateOfResignation: json['dateOfResignation'] as String? ?? '',
      dateOfConfirmation: json['dateOfConfirmation'] as String?,
      employmentType: json['employmentType'] as String?,
    );

Map<String, dynamic> _$LoginDataModelToJson(LoginDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'loginId': instance.loginId,
      'name': instance.name,
      'contactNo': instance.contactNo,
      'email': instance.email,
      'mobileNumber': instance.mobileNumber,
      'dob': instance.dob,
      'designation': instance.designation,
      'cardNumber': instance.cardNumber,
      'deviceCode': instance.deviceCode,
      'cardType': instance.cardType,
      'gender': instance.gender,
      'bloodGroup': instance.bloodGroup,
      'aadhaarNumber': instance.aadhaarNumber,
      'fatherName': instance.fatherName,
      'motherName': instance.motherName,
      'placeOfBirth': instance.placeOfBirth,
      'residentialAddress': instance.residentialAddress,
      'permanentAddress': instance.permanentAddress,
      'nominee1': instance.nominee1,
      'nominee2': instance.nominee2,
      'employeeCode': instance.employeeCode,
      'lastModifiedBy': instance.lastModifiedBy,
      'photo': instance.photo,
      'status': instance.status,
      'isRecieveNotification': instance.isRecieveNotification,
      'dateOfJoining': instance.dateOfJoining,
      'dateOfResignation': instance.dateOfResignation,
      'dateOfConfirmation': instance.dateOfConfirmation,
      'employmentType': instance.employmentType,
      'authToken': instance.authToken,
      'roles': instance.roles,
      'balances': instance.balances.map((e) => e.toJson()).toList(),
      'superiors': instance.superiors.map((e) => e.toJson()).toList(),
      'subordinates': instance.subordinates.map((e) => e.toJson()).toList(),
    };
