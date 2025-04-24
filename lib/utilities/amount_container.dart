import 'package:flutter/material.dart';

class AmountContainer extends StatelessWidget {
  final String title;
  final String amount;
  final Color amountColor;
  const AmountContainer({required this.title, required this.amount, required this.amountColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Text(
          "\$$amount",
          style: TextStyle(fontSize: 19, color: amountColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
