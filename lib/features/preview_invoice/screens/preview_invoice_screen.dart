import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

@RoutePage()
class PreviewInvoiceScreen extends StatelessWidget {
  final String issuedDate;
  final String invoiceNumber;
  final Map<String, dynamic>? client;
  final List<Map<String, dynamic>> items;
  final double totalAmount;
  final String selectedCurrency;

  const PreviewInvoiceScreen({
    super.key,
    required this.issuedDate,
    required this.invoiceNumber,
    this.client,
    required this.items,
    required this.totalAmount,
    required this.selectedCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final currencySymbol = NumberFormat.simpleCurrency(
      name: selectedCurrency,
    ).currencySymbol;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Preview',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          onPressed: () {
                            // TODO: Implement delete invoice logic
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Delete Invoice',
                            style: textTheme.titleMedium?.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        const Divider(height: 1),
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: textTheme.titleMedium?.copyWith(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // Invoice Preview Section
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // Top part of the invoice (Yulia Kartavenko, INVOICE #001) - This seems to be a miniature preview.
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Yulia Kartavenko', // Placeholder for 'FROM'
                            style: textTheme.bodyMedium,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'INVOICE',
                                style: textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '#$invoiceNumber',
                                style: textTheme.bodySmall,
                              ),
                              Text(
                                'Issued $issuedDate',
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // FROM and BILL TO labels
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'FROM',
                                  style: textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                // Add actual 'FROM' details here later
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'BILL TO',
                                  style: textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                if (client != null && client!['billTo'] != null)
                                  Text(
                                    client!['billTo'],
                                    style: textTheme.bodyMedium,
                                  ),
                                if (client != null && client!['email'] != null)
                                  Text(
                                    client!['email'],
                                    style: textTheme.bodyMedium,
                                  ),
                                if (client != null &&
                                    client!['address'] != null)
                                  Text(
                                    client!['address'],
                                    style: textTheme.bodyMedium,
                                  ),
                                // Add actual 'BILL TO' details here later
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Items Section
                      if (items.isNotEmpty)
                        Column(
                          children: items.map((item) {
                            final unitPrice =
                                (item['unitPrice'] as double?) ?? 0.0;
                            final quantity =
                                (item['quantity'] as double?) ?? 0.0;
                            final itemTotal = unitPrice * quantity;
                            final details = item['details'] as String? ?? '';
                            final unitType = item['unitType'] as String? ?? '';

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          details,
                                          style: textTheme.bodyMedium,
                                        ),
                                        Text(
                                          '${unitPrice.toStringAsFixed(2)} ${selectedCurrency} x ${quantity.toStringAsFixed(2)} $unitType',
                                          style: textTheme.bodySmall?.copyWith(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${itemTotal.toStringAsFixed(2)} ${selectedCurrency}',
                                    style: textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      else
                        Text(
                          'Edit to add items',
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      const SizedBox(height: 16),
                      // Total Amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${totalAmount.toStringAsFixed(2)} $selectedCurrency',
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () {
                          // TODO: Add Received Payment functionality
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color.fromRGBO(210, 210, 210, 1),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          '+ Add Received Payment',
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Has Invoice Been Paid?
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Has Invoice Been Paid?', style: textTheme.bodyLarge),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Mark as Paid functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(83, 190, 100, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        'Mark as Paid',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Issued Date and Invoice #
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Issued', style: textTheme.bodyLarge),
                        Text(issuedDate, style: textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Invoice #', style: textTheme.bodyLarge),
                        Text(invoiceNumber, style: textTheme.bodyMedium),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(), // Pushes content to the top
              // Bottom buttons: Share, Print, Edit
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildBottomIconText(
                      context,
                      Icons.share, // Assuming share icon, image is not clear
                      'Share',
                      () {
                        // TODO: Share functionality
                      },
                    ),
                    _buildBottomIconText(context, Icons.print, 'Print', () {
                      // TODO: Print functionality
                    }),
                    _buildBottomIconText(context, Icons.edit, 'Edit', () {
                      // TODO: Edit functionality
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Send Invoice Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Send Invoice functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(83, 190, 100, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Send Invoice',
                    style: textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomIconText(
    BuildContext context,
    IconData icon,
    String text,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(icon, color: Colors.grey[700], size: 28),
          const SizedBox(height: 4),
          Text(text, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
