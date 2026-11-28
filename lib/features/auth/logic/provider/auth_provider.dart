import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// class AuthProvider extends ChangeNotifier {
//   User? user;
//
//   AuthProvider() {
//     user = Supabase.instance.client.auth.currentUser;
//   }
//
//   void changeUser(User loginUser) {
//     user = loginUser;
//     notifyListeners();
//   }
// }


class AuthProvider extends ChangeNotifier {
  User? user;

  AuthProvider() {
    user = Supabase.instance.client.auth.currentUser;
  }

  void changeUser(User loginUser) {
    user = loginUser;
    notifyListeners();
  }

  void clearUser() {
    user = null;
    notifyListeners();
  }
}