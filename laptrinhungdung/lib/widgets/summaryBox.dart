import 'package:flutter/material.dart';

class SummaryBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback? onEditPressed;

  const SummaryBox({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white24,
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                if (onEditPressed != null)
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      size: 16,
                      color: Colors.white70,
                    ),
                    onPressed: onEditPressed,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(),
                  ),
              ],
            ),
            Text(
              "$value đ",
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
