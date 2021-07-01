import 'package:flutter/material.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_repo.dart';

class RepoTile extends StatelessWidget {
  final GithubRepo repo;

  const RepoTile(this.repo);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(20),
      title: Text(
        repo.name,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            repo.description,
          ),
          const SizedBox(height: 10),
          Text(
            repo.language,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
