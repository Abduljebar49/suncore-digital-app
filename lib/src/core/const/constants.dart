import 'package:shared_preferences/shared_preferences.dart';

const appName = 'SunCore Digital';
const aboutUsHeroImage =
    "http://suncore-web.137.184.245.45.nip.io/wp-content/uploads/2025/07/about-us-hero.png";
const baseUrl = "https://api.suncore-web.137.184.245.45.nip.io/api/v1";

Future<String?> getStoredToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}
