import 'package:flutter/material.dart';

class CreateInvoiceButton extends StatelessWidget {
  final TextTheme textTheme;
  final VoidCallback onCreateInvoice;

  const CreateInvoiceButton({
    super.key,
    required this.textTheme,
    required this.onCreateInvoice,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(69, 187, 80, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          elevation: 0,
        ),
        onPressed: onCreateInvoice,
        child: Text(
          'Create Invoice',
          style: textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
