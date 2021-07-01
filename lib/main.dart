import 'package:flutter/material.dart';
import 'package:github_finder/core/dependency_injection/injection_container.dart';
import 'package:github_finder/github_finder.dart';

void main() {
  initializeDI();
  runApp(GithubFinder());
}
