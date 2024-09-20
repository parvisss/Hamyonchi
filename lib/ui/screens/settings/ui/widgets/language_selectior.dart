import 'package:easy_localization/easy_localization.dart';
import 'package:exam_6/ui/screens/settings/data/languages.dart';
import 'package:flutter/material.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  LanguageSelectorState createState() => LanguageSelectorState();
}

class LanguageSelectorState extends State<LanguageSelector> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      value: context.locale,
      icon: const Icon(Icons.arrow_drop_down_outlined),
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          setState(() {
            context.setLocale(newLocale);
          });
        }
      },
      items: languages,
    );
  }
}
