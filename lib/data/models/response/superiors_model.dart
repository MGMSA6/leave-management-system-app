import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "superiors_model.g.dart";

@JsonSerializable(explicitToJson: true)
class SuperiorsModel extends Equatable {
  final int id;
  final String name;

  const SuperiorsModel({required this.id, required this.name});

  factory SuperiorsModel.fromJson(Map<String, dynamic> json) =>
      _$SuperiorsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SuperiorsModelToJson(this);

  @override
  List<Object?> get props => [id, name];
}
