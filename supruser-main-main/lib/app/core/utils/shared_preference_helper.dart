import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static late SharedPreferences prefs;

  // Add these constants for keys
  static const String _authTokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _userPhoneKey = 'user_phone';

  static getInitialValue() async {
    prefs = await SharedPreferences.getInstance();
  }

  // ADD THESE NEW METHODS FOR AUTH

  // Save auth token
  static Future<void> saveAuthToken(String token) async {
    await prefs.setString(_authTokenKey, token);
  }

  // Get auth token
  static Future<String?> getAuthToken() async {
    return prefs.getString(_authTokenKey);
  }

  // Remove auth token (for logout)
  static Future<void> removeAuthToken() async {
    await prefs.remove(_authTokenKey);
  }

  // Save user data
  static Future<void> saveUserData({
    String? userId,
    String? userName,
    String? userEmail,
    String? userPhone,
  }) async {
    if (userId != null) await prefs.setString(_userIdKey, userId);
    if (userName != null) await prefs.setString(_userNameKey, userName);
    if (userEmail != null) await prefs.setString(_userEmailKey, userEmail);
    if (userPhone != null) await prefs.setString(_userPhoneKey, userPhone);
  }

  // Get user data
  static Future<Map<String, String?>> getUserData() async {
    return {
      'userId': prefs.getString(_userIdKey),
      'userName': prefs.getString(_userNameKey),
      'userEmail': prefs.getString(_userEmailKey),
      'userPhone': prefs.getString(_userPhoneKey),
    };
  }

  // Your existing methods remain the same...
  static saveString(String key, String value) async {
    await prefs.setString(key, value);
  }

  static getString(String key) async {
    return prefs.getString(key);
  }

  static saveBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static getBool(String key) async {
    return prefs.getBool(key);
  }

  static saveInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  static getInt(String key) async {
    return prefs.getInt(key);
  }

  static saveDouble(String key, double value) async {
    await prefs.setDouble(key, value);
  }

  static getDouble(String key) async {
    return prefs.getDouble(key);
  }

  static remove(String key) async {
    await prefs.remove(key);
  }

  static clearAll() async {
    await prefs.clear();
  }
}
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPrefHelper {
//   static late SharedPreferences prefs;
//   static getInitialValue() async {
//     prefs = await SharedPreferences.getInstance();
//     // StaticData.isFirstTime = await getBool(isFirstTimeText) ?? true;
//     // StaticData.isParent = await getBool(isJobSeekerText) ?? true;
//     // StaticData.isAdmin = await getBool(isAdminText) ?? false;
//     // StaticData.isLoggedIn = await getBool(isLoggedInText) ?? false;
//   }
//
//   // Save a string value
//   static saveString(String key, String value) async {
//     await prefs.setString(key, value);
//   }
//
//   // Retrieve a string value
//   static getString(String key) async {
//     return prefs.getString(key);
//   }
//
//   // Save a boolean value
//   static saveBool(String key, bool value) async {
//     await prefs.setBool(key, value);
//   }
//
//   // Retrieve a boolean value
//   static getBool(String key) async {
//     return prefs.getBool(key);
//   }
//
//   // Save an integer value
//   static saveInt(String key, int value) async {
//     await prefs.setInt(key, value);
//   }
//
//   // Retrieve an integer value
//   static getInt(String key) async {
//     return prefs.getInt(key);
//   }
//
//   // Save a double value
//   static saveDouble(String key, double value) async {
//     await prefs.setDouble(key, value);
//   }
//
//   // Retrieve a double value
//   static getDouble(String key) async {
//     return prefs.getDouble(key);
//   }
//
//   // Remove a value
//   static remove(String key) async {
//     await prefs.remove(key);
//   }
//
//   // Clear all values
//   static clearAll() async {
//     await prefs.clear();
//   }
// }
//
//
