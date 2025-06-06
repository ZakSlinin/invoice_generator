import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class NewInvoiceScreen extends StatefulWidget {
  const NewInvoiceScreen({super.key});

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  final TextEditingController _issuedDateController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _invoiceNumberController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    _issuedDateController.text =
    '${DateTime
        .now()
        .day} ${DateFormat.MMMM().format(DateTime.now())} ${DateTime
        .now()
        .year}';
    _invoiceNumberController.text = '001';
  }

  @override
  void dispose() {
    _issuedDateController.dispose();
    _dueDateController.dispose();
    _invoiceNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Text('Cancel', style: textTheme.labelSmall),
                  ),
                  Container(
                    child: Row(
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
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(child: Text('New invoice', style: textTheme.bodyLarge)),
              const SizedBox(height: 24),
              // Date and Invoice Number Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Issued', style: textTheme.bodySmall),
                        const SizedBox(height: 4),
                        _buildDateField(controller: _issuedDateController),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Due', style: textTheme.bodySmall),
                        const SizedBox(height: 4),
                        _buildDateField(
                          controller: _dueDateController,
                          hintText: '-',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('#', style: textTheme.bodySmall),
                        const SizedBox(height: 4),
                        _buildInvoiceNumberField(
                          controller: _invoiceNumberController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Client Section
                      Text('Client', style: textTheme.bodySmall),
                      const SizedBox(height: 8),
                      _buildAddButton(
                        label: 'Add Client',
                        onTap: () {
                          // TODO: Implement Add Client functionality
                        },
                      ),
                      const SizedBox(height: 24),
                      // Items Section
                      Text('Items', style: textTheme.bodySmall),
                      const SizedBox(height: 8),
                      _buildAddButton(
                        label: 'Add Item',
                        onTap: () {
                          // TODO: Implement Add Item functionality
                        },
                      ),
                      const SizedBox(height: 24),
                      // Summary Section
                      Text('Summary', style: textTheme.bodySmall),
                      const SizedBox(height: 8),
                      _buildTotalRow('Total', '0.00'),
                      const SizedBox(height: 24),
                      // Photos Section
                      Text('Photos', style: textTheme.bodySmall),
                      const SizedBox(height: 8),
                      _buildAddPhotoButton(
                        label: 'Add Photo',
                        onTap: () {
                          // TODO: Implement Add Photo functionality
                        },
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              // Create Invoice Button
              SizedBox(
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
                  onPressed: () {
                    // TODO: Implement Create Invoice functionality
                  },
                  child: Text(
                    'Create Invoice',
                    style: textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
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

  Widget _buildDateField({
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
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        style: Theme
            .of(context)
            .textTheme
            .labelLarge,
      ),
    );
  }

  Widget _buildInvoiceNumberField({required TextEditingController controller}) {
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
        style: Theme
            .of(context)
            .textTheme
            .labelLarge,
      ),
    );
  }

  Widget _buildAddButton({required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/svg/add.svg'),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddPhotoButton({
    required String label,
    required VoidCallback onTap,
  }) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromRGBO(255, 255, 255, 1),
          image: const DecorationImage(
            image: AssetImage('assets/images/button_bg.png'), fit: BoxFit.cover)
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/svg/add.svg'),
              const SizedBox(width: 8),
              Text(
                label,
                style: textTheme.bodyLarge?.copyWith(fontSize: 18),
              ),
              const SizedBox(width: 8),
              InkWell(
                child: SvgPicture.asset('assets/svg/premium_button.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Row(
                children: [
                  Text(
                    'UAH',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_drop_down, size: 20, color: Colors.black54),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '\$$amount',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
