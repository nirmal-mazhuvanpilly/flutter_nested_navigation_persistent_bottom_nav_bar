import 'package:flutter_test_application/services/api_services.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setUpLocator() async {
  //Register for Singleton class //Always create single instance for every instance creation
  getIt.registerLazySingleton<ApiServices>(() => ApiServices());
}
