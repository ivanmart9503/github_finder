import 'package:equatable/equatable.dart';

class GithubUser extends Equatable {
  final int id;
  final String login;
  final String avatar;

  const GithubUser({
    required this.id,
    required this.login,
    required this.avatar,
  });

  @override
  List<Object?> get props => [id, login, avatar];
}
