// balance_model.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'balance_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BalanceModel extends Equatable {
  final String balanceType;
  final int allocated;
  final int used;
  final int pending;


  const BalanceModel({
    required this.balanceType,
    required this.allocated,
    required this.used,
    required this.pending,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceModelToJson(this);

  @override
  List<Object?> get props => [allocated, used, pending, balanceType];
}
