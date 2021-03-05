import 'package:get_it/get_it.dart';
import 'package:githubjobs/core/network/network_client_impl.dart';
import 'package:githubjobs/core/preference/shared_pref_Impl.dart';
import 'package:githubjobs/services/ApiService.dart';
import 'package:githubjobs/services/PrefService.dart';
import 'package:logger/logger.dart';

GetIt sl = GetIt.instance;

void setUpServiceLocator() {
  sl.registerLazySingleton<PrefService>(() => PrefService(SharedPrefImpl()));
  sl.registerLazySingleton<ApiService>(() => ApiService.create(NetworkClientImpl()));
  sl.registerSingleton<Logger>(Logger());
}
