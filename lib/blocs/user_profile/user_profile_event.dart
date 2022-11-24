part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();
}

class UserProfileEntityChanged extends UserProfileEvent {
  final UserEntity userEntity;

  UserProfileEntityChanged({required this.userEntity});

  @override
  List<Object> get props => [userEntity];
}