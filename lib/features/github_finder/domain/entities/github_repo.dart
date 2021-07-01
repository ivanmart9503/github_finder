import 'package:equatable/equatable.dart';

class GithubRepo extends Equatable {
  final int id;
  final String name;
  final String description;
  final String language;

  GithubRepo({
    required this.id,
    required this.name,
    required this.description,
    required this.language,
  });

  @override
  List<Object?> get props => [id, name, description, language];
}
