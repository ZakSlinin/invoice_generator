import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:invoice_generator/core/router/app_router.dart';

class HeaderWidget extends StatelessWidget {
  final TextTheme textTheme;
  final String issuedDate;
  final String invoiceNumber;
  final Map<String, dynamic>? client;
  final List<Map<String, dynamic>> items;
  final double totalAmount;
  final String selectedCurrency;

  const HeaderWidget({
    super.key,
    required this.textTheme,
    required this.issuedDate,
    required this.invoiceNumber,
    this.client,
    required this.items,
    required this.totalAmount,
    required this.selectedCurrency,
  });

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
                context.router.push(
                  PreviewInvoiceRoute(
                    issuedDate: issuedDate,
                    invoiceNumber: invoiceNumber,
                    client: client,
                    items: items,
                    totalAmount: totalAmount,
                    selectedCurrency: selectedCurrency,
                  ),
                );
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
                context.router.push(
                  PreviewInvoiceRoute(
                    issuedDate: issuedDate,
                    invoiceNumber: invoiceNumber,
                    client: client,
                    items: items,
                    totalAmount: totalAmount,
                    selectedCurrency: selectedCurrency,
                  ),
                );
              },
              child: Text('Done', style: textTheme.labelSmall),
            ),
          ],
        ),
      ],
    );
  }
}
