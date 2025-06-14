import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UnitAndQuantitySection extends StatelessWidget {
  final TextTheme textTheme;
  final TextEditingController issuedDateController;
  final TextEditingController dueDateController;
  final TextEditingController invoiceNumberController;
  final String selectedCurrency;
  final VoidCallback onCurrencyTap;

  const UnitAndQuantitySection({
    super.key,
    required this.textTheme,
    required this.issuedDateController,
    required this.dueDateController,
    required this.invoiceNumberController,
    required this.selectedCurrency,
    required this.onCurrencyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Unit Price', style: textTheme.bodySmall),
              const SizedBox(height: 4),
              _buildPriceField(
                context,
                controller: issuedDateController,
                hintText: '0.00',
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quantity', style: textTheme.bodySmall),
              const SizedBox(height: 4),
              _buildQuantityField(
                context,
                controller: dueDateController,
                hintText: '-',
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Unit Type', style: textTheme.bodySmall),
              const SizedBox(height: 4),
              _buildUnitTypeField(context, controller: invoiceNumberController),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceField(
    BuildContext context, {
    required TextEditingController controller,
    String? hintText,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }

  Widget _buildQuantityField(
    BuildContext context, {
    required TextEditingController controller,
    String? hintText,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }

  Widget _buildUnitTypeField(
    BuildContext context, {
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.end,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
