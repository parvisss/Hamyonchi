import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DefaultDialog extends StatelessWidget {
  final String? title;
  final String content;
  const DefaultDialog({
    super.key,
    required this.content,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title!) : null,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(content),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child:  Text("Cancel".tr()))
      ],
    );
  }
}
