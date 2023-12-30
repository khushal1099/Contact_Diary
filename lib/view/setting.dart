import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<ThemeProvider>(context, listen: false).ref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          Consumer<ThemeProvider>(
            builder: (context, Providervalue, child) {
              return ListTile(
                title: Text('Theme Selection'),
                trailing: Consumer<ThemeProvider>(
                  builder: (context,provider,child) {
                    return DropdownButton<String>(
                      value: provider.currenttheme,
                      onChanged: (String? value) {
                        provider.changeTheme(value ?? 'system');
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'light',
                          child: Text("Light"),
                        ),
                        DropdownMenuItem(
                          value: 'dark',
                          child: Text("Dark"),
                        ),
                        DropdownMenuItem(
                          value: 'system',
                          child: Text("System"),
                        ),
                      ],
                    );
                  }
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
