// meta_model.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meta_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class MetaModel extends Equatable {
  final String? authToken;

  const MetaModel({this.authToken});

  // The factory method will be generated automatically by json_serializable
  factory MetaModel.fromJson(Map<String, dynamic> json) =>
      _$MetaModelFromJson(json);

  // The toJson method will also be generated automatically by json_serializable
  Map<String, dynamic> toJson() => _$MetaModelToJson(this);

  @override
  List<Object?> get props => [authToken];
}
