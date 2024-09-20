import 'package:easy_localization/easy_localization.dart';
import 'package:exam_6/ui/screens/settings/ui/screens/privasy_screen.dart';
import 'package:exam_6/ui/screens/settings/ui/widgets/language_selectior.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.tr("Settings")),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(context.tr("Language")),
              trailing: const LanguageSelector(),
            ),
            ListTile(
              title: Text(context.tr("Privasy & Policy")),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => PrivasyScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
