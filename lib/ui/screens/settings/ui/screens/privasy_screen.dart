import 'package:exam_6/ui/screens/settings/data/mark_down_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivasyScreen extends StatelessWidget {
  const PrivasyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Markdown(data: mark_down_data),
    );
  }
}
