part of 'user_profile_bloc.dart';

class UserProfileState extends Equatable {
  const UserProfileState({this.userEntity});

  final UserEntity? userEntity;

  @override
  List<Object> get props => [userEntity ?? ""];

  UserProfileState copyWith({
    UserEntity? userEntity,
  }) {
    return UserProfileState(userEntity: userEntity ?? this.userEntity);
  }
}
