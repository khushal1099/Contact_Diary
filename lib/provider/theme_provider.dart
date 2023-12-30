import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  String currenttheme = 'system';

  ThemeMode get thememode{
    if(currenttheme == 'light'){
      return ThemeMode.light;
    }
    else if(currenttheme=='dark'){
      return ThemeMode.dark;
    }
    else{
      return ThemeMode.system;
    }
  }
  changeTheme(String theme) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
    currenttheme = theme;
    notifyListeners();
  }

  gettheme() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currenttheme = prefs.getString('theme') ?? 'system';
    notifyListeners();
  }
}