import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'decided_by_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DecidedByModel extends Equatable {
  final int id;
  final String name;

  const DecidedByModel({
    required this.id,
    required this.name,
  });

  factory DecidedByModel.fromJson(Map<String, dynamic> json) =>
      _$DecidedByModelFromJson(json);

  Map<String, dynamic> toJosn() => _$DecidedByModelToJson(this);

  @override
  List<Object?> get props => [id, name];
}
