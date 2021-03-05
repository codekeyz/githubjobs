import 'dart:convert';

import 'package:githubjobs/core/preference/shared_pref.dart';

class PrefService {
  final SharedPref sharedPref;

  const PrefService(this.sharedPref);

  Future<void> clearEverything() async {
    return sharedPref.clearPreference();
  }
}
