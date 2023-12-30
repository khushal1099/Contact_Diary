import 'package:contact_diary/provider/contact_provider.dart';
import 'package:contact_diary/provider/theme_provider.dart';
import 'package:contact_diary/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// late SharedPreferences prefs;
// ThemeMode? th;

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider()..gettheme(),
        )
      ],
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, provider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomePage(),
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: provider.thememode,
            );
          },
        );
      },
    );
  }
}
