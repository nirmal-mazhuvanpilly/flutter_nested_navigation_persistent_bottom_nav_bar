import 'package:flutter_test_application/services/api_services.dart';
import 'package:flutter_test_application/services/base_services.dart';
import 'package:flutter_test_application/services/test_services.dart';
import 'package:flutter_test_application/utils/db_helper.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setUpLocator({required bool staging}) async {
  //Register for Singleton class //Always create single instance for every instance creation
  getIt.registerLazySingleton<BaseServices>(
      () => staging ? TestServices() : ApiServices());

  getIt.registerLazySingleton<DbHelper>(() => DbHelper());
}
