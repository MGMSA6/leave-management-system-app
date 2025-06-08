// subordinate_model.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subordinate_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SubordinateModel extends Equatable {
  final int id;
  final String name;

  const SubordinateModel({
    required this.id,
    required this.name,
  });

  factory SubordinateModel.fromJson(Map<String, dynamic> json) =>
      _$SubordinateModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubordinateModelToJson(this);

  @override
  List<Object?> get props => [id, name];
}
