import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  /// {@macro user}
  const UserEntity({
    required this.email,
    required this.id,
    required this.name,
    required this.photo,
    required this.emailVerified,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  final bool emailVerified;

  /// Empty user which represents an unauthenticated user.
  static const empty = UserEntity(email: '', id: '', name: null, photo: null, emailVerified: false);

  @override
  List<Object> get props => [email ?? "", id, name ?? "", photo ?? "", emailVerified];
}