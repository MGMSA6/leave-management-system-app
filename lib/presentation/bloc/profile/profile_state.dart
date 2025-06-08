part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final LoginEntity user;

  ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}
