import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefData{

  String cartValue = "cartValue";

  /// cart value
  Future setCartValue(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cartValue', value);
  }

  Future getCartValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? intValue = prefs.getInt(cartValue);
    return intValue ?? 0;
  }
}