import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final TextTheme textTheme;

  const HeaderWidget({super.key, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Text('Cancel', style: textTheme.labelSmall),
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                // TODO: Implement preview functionality
              },
              child: Text(
                'Preview',
                style: textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(width: 28),
            InkWell(
              onTap: () {
                // TODO: Implement save functionality
              },
              child: Text('Done', style: textTheme.labelSmall),
            ),
          ],
        ),
      ],
    );
  }
}
