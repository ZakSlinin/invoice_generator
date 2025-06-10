import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SummarySection extends StatelessWidget {
  final TextTheme textTheme;
  final String total;
  final VoidCallback onOpenCurrency;
  final String selectedCurrency;

  const SummarySection({
    super.key,
    required this.textTheme,
    required this.total,
    required this.onOpenCurrency,
    required this.selectedCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final currencySymbol = NumberFormat.simpleCurrency(
      name: selectedCurrency,
    ).currencySymbol;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Summary', style: textTheme.bodySmall),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: textTheme.labelLarge),
              Row(
                children: [
                  InkWell(
                    onTap: onOpenCurrency,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Text(
                            selectedCurrency,
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('$total $currencySymbol', style: textTheme.labelLarge),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
