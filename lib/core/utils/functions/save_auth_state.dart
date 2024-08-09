import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isFirstLaunch() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('hasSeenOnboarding') ?? false;
}

Future<void> setHasSeenOnboarding() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('hasSeenOnboarding', true);
}
