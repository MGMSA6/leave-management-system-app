part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUserProfile extends ProfileEvent {}
