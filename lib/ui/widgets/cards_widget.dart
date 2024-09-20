import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final bool isMain;

  const CardWidget({
    super.key,
    required this.isMain,
    required this.title,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      width: isMain ? 240 : 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: isMain
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(isMain ? Icons.wallet : Icons.add),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            isMain
                ? Text(
                    "\$$amount",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
