import 'package:flutter/material.dart';

class SummarySection extends StatelessWidget {
  final TextTheme textTheme;
  final String total;
  final VoidCallback onOpenCurrency;

  const SummarySection({
    super.key,
    required this.textTheme,
    required this.total,
    required this.onOpenCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Summary', style: textTheme.bodySmall),
        const SizedBox(height: 8),
        _buildTotalRow('Total', total, onTap: onOpenCurrency),
      ],
    );
  }

  Widget _buildTotalRow(
    String label,
    String amount, {
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        InkWell(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Text(
                      'USD',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '\$$amount',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}
