import 'package:get_it/get_it.dart';
import 'package:github_finder/core/dependency_injection/injection_container.config.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
void initializeDI() {
  $initGetIt(getIt);
}
