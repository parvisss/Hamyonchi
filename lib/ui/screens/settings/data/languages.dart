import 'package:flutter/material.dart';

final List<DropdownMenuItem<Locale>> languages = [
  const DropdownMenuItem(
    value: Locale('en'),
    child: Text('English'),
  ),
  const DropdownMenuItem(
    value: Locale('uz'),
    child: Text('O\'zbekcha'),
  ),
  const DropdownMenuItem(
    value: Locale('ru'),
    child: Text('Русский'),
  ),
];
