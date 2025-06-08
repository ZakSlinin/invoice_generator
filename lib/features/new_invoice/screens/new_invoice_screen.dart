import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:invoice_generator/features/new_invoice/bloc/new_client_bloc/new_client_bloc.dart';

@RoutePage()
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
  final TextEditingController _billToController = TextEditingController();

  // New controllers for client fields
  final TextEditingController _clientEmailController = TextEditingController();
  final TextEditingController _clientPhoneController = TextEditingController();
  final TextEditingController _clientAddressController =
      TextEditingController();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _issuedDateController.text =
        '${DateTime.now().day} ${DateFormat.MMMM().format(DateTime.now())} ${DateTime.now().year}';
    _invoiceNumberController.text = '001';
  }

  @override
  void dispose() {
    _issuedDateController.dispose();
    _dueDateController.dispose();
    _invoiceNumberController.dispose();
    _billToController.dispose();
    _clientEmailController.dispose();
    _clientPhoneController.dispose();
    _clientAddressController.dispose();
    super.dispose();
  }

  bool _validateClientFields() {
    if (_clientAddressController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter address')));
      return false;
    }

    final email = _clientEmailController.text;
    if (email.isNotEmpty) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid email')),
        );
        return false;
      }
    }

    setState(() {
      _errorMessage = null;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<NewClientBloc, NewClientState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
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
                                child: Text(
                                  'Done',
                                  style: textTheme.labelSmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text('New invoice', style: textTheme.bodyLarge),
                    ),
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
                              _buildDateField(
                                controller: _issuedDateController,
                              ),
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
                            Text('Client', style: textTheme.bodySmall),
                            const SizedBox(height: 8),
                            _buildAddButton(
                              label: 'Add Client',
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                      ),
                                      child: Container(
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                        padding: EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text(
                                                    'Cancel',
                                                    style: textTheme.labelSmall
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    if (_validateClientFields()) {
                                                      context.read<NewClientBloc>().add(
                                                        NewClientSaveEvent(
                                                          email: _clientEmailController.text,
                                                          phone: _clientPhoneController.text,
                                                          address: _clientAddressController.text,
                                                          billTo: _billToController.text,
                                                        ),
                                                      );
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: Text(
                                                    'Done',
                                                    style: textTheme.labelSmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'New Client',
                                              style: textTheme.bodyLarge,
                                            ),
                                            const SizedBox(height: 24),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    child: TextField(
                                                      textAlign:
                                                          TextAlign.start,
                                                      decoration: InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        hintText: 'Bill To',
                                                        hintStyle: textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16,
                                                            ),
                                                        border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                          borderSide:
                                                              BorderSide.none,
                                                        ),
                                                        isDense: true,
                                                        contentPadding:
                                                            EdgeInsets.all(8),
                                                      ),
                                                      style: textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12,
                                                          ),
                                                      controller:
                                                          _billToController,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 24),
                                            // Bill To input
                                            Text(
                                              'Contacts',
                                              style: textTheme.bodySmall,
                                            ),
                                            const SizedBox(height: 8),
                                            // Contacts bloc
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 12,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                children: [
                                                  _buildContactRow(
                                                    textTheme,
                                                    'E-mail',
                                                    'Optional',
                                                  ),
                                                  const Divider(),
                                                  _buildContactRow(
                                                    textTheme,
                                                    'Phone',
                                                    'Optional',
                                                  ),
                                                  const Divider(),
                                                  _buildContactRow(
                                                    textTheme,
                                                    'Address',
                                                    '',
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 24),
                                            // Button
                                            SizedBox(
                                              height: 60,
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  // TODO: Implement Import From Contacts functionality
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  foregroundColor:
                                                      const Color.fromRGBO(
                                                        69,
                                                        187,
                                                        80,
                                                        1,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          32,
                                                        ),
                                                    side: const BorderSide(
                                                      color: Color.fromRGBO(
                                                        69,
                                                        187,
                                                        80,
                                                        1,
                                                      ),
                                                    ),
                                                  ),
                                                  elevation: 0,
                                                ),
                                                child: const Text(
                                                  'Import From Contacts',
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: max(
                                                MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    0.2,
                                                min(
                                                  MediaQuery.of(
                                                        context,
                                                      ).size.height *
                                                      0.33,
                                                  300,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
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
          ),
        );
      },
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
        style: Theme.of(context).textTheme.labelLarge,
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
        style: Theme.of(context).textTheme.labelLarge,
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
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromRGBO(255, 255, 255, 1),
          image: const DecorationImage(
            image: AssetImage('assets/images/button_bg.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/svg/add.svg'),
              const SizedBox(width: 8),
              Text(label, style: textTheme.bodyLarge?.copyWith(fontSize: 18)),
              const SizedBox(width: 8),
              InkWell(child: SvgPicture.asset('assets/svg/premium_button.svg')),
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

  Widget _buildContactRow(TextTheme textTheme, String label, String hintText) {
    TextEditingController controller;
    switch (label) {
      case 'E-mail':
        controller = _clientEmailController;
        break;
      case 'Phone':
        controller = _clientPhoneController;
        break;
      case 'Address':
        controller = _clientAddressController;
        break;
      default:
        controller = TextEditingController();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 80, child: Text(label, style: textTheme.bodyMedium)),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 20),
            ),
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: label == 'E-mail'
                ? TextInputType.emailAddress
                : (label == 'Phone' ? TextInputType.phone : TextInputType.text),
            maxLines: label == 'Address' ? null : 1,
          ),
        ),
      ],
    );
  }
}
