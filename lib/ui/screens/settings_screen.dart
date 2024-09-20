import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
          ),
          body: const SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text("Language"),
                  trailing:
                      LanguageDropdown(), // Use a custom widget for the dropdown
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String _selectedLanguage = 'English'; // Default language selection

  final List<String> _languages = [
    'English',
    'Russian',
    'Uzbek'
  ]; // Available languages

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedLanguage,
      icon: const Icon(Icons.arrow_drop_down_outlined),
      onChanged: (String? newValue) {
        setState(() {
          _selectedLanguage = newValue!;
        });
      },
      items: _languages.map<DropdownMenuItem<String>>((String language) {
        return DropdownMenuItem<String>(
          value: language,
          child: Text(language),
        );
      }).toList(),
    );
  }
}
