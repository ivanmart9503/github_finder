import 'package:flutter/material.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_user.dart';
import 'package:github_finder/features/github_finder/presentation/pages/load_user_repos_page.dart';

class UserCard extends StatelessWidget {
  final GithubUser user;

  const UserCard(this.user);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade700,
      elevation: 4,
      margin: const EdgeInsets.only(top: 5, bottom: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoadUserReposPage(user)),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            foregroundImage: NetworkImage(user.avatar),
          ),
          title: Text(
            user.login,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            'Tap to view public repos',
            style: TextStyle(
              color: Colors.white60,
            ),
          ),
        ),
      ),
    );
  }
}
