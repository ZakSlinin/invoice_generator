import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:invoice_generator/features/new_invoice/bloc/new_client_bloc/new_client_bloc.dart';
import 'package:invoice_generator/features/new_invoice/services/currency_service.dart';
import 'package:invoice_generator/features/new_invoice/widgets/client_section.dart';
import 'package:invoice_generator/features/new_invoice/widgets/create_invoice_button.dart';
import 'package:invoice_generator/features/new_invoice/widgets/currency_modal.dart';
import 'package:invoice_generator/features/new_invoice/widgets/date_and_invoice_section.dart';
import 'package:invoice_generator/features/new_invoice/widgets/header_widget.dart';
import 'package:invoice_generator/features/new_invoice/widgets/items_section.dart';
import 'package:invoice_generator/features/new_invoice/widgets/new_client_modal.dart';
import 'package:invoice_generator/features/new_invoice/widgets/new_item_modal.dart';
import 'package:invoice_generator/features/new_invoice/widgets/photos_section.dart';
import 'package:invoice_generator/features/new_invoice/widgets/summary_section.dart';

@RoutePage()
class NewInvoiceScreen extends StatefulWidget {
  const NewInvoiceScreen({super.key});

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  // Controllers
  final TextEditingController _issuedDateController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _invoiceNumberController =
      TextEditingController();
  final TextEditingController _billToController = TextEditingController();
  final TextEditingController _clientEmailController = TextEditingController();
  final TextEditingController _clientPhoneController = TextEditingController();
  final TextEditingController _clientAddressController =
      TextEditingController();

  String? _errorMessage;
  String _selectedCurrency = 'USD';

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadSelectedCurrency();
  }

  Future<void> _loadSelectedCurrency() async {
    final currency = await CurrencyService.getSelectedCurrency();
    setState(() {
      _selectedCurrency = currency;
    });
  }

  void _initializeControllers() {
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

  // Validation
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

  // Main Build
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
                    HeaderWidget(textTheme: textTheme),
                    const SizedBox(height: 16),
                    Center(
                      child: Text('New invoice', style: textTheme.bodyLarge),
                    ),
                    const SizedBox(height: 24),
                    DateAndInvoiceSection(
                      textTheme: textTheme,
                      issuedDateController: _issuedDateController,
                      dueDateController: _dueDateController,
                      invoiceNumberController: _invoiceNumberController,
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClientSection(
                              textTheme: textTheme,
                              onAddClient: _showNewClientModal,
                            ),
                            const SizedBox(height: 24),
                            ItemsSection(
                              textTheme: textTheme,
                              onAddItem: _showNewItemModal,
                            ),
                            const SizedBox(height: 24),
                            SummarySection(
                              textTheme: textTheme,
                              total: '0.00',
                              onOpenCurrency: _showCurrency,
                              selectedCurrency: _selectedCurrency,
                            ),
                            const SizedBox(height: 24),
                            PhotosSection(
                              textTheme: textTheme,
                              onAddPhoto: () {
                                // TODO: Implement Add Photo functionality
                              },
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                    CreateInvoiceButton(
                      textTheme: textTheme,
                      onCreateInvoice: () {
                        // TODO: Implement Create Invoice functionality
                      },
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

  void _showNewClientModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return NewClientModal(
          textTheme: Theme.of(context).textTheme,
          billToController: _billToController,
          emailController: _clientEmailController,
          phoneController: _clientPhoneController,
          addressController: _clientAddressController,
          validateFields: _validateClientFields,
        );
      },
    );
  }

  void _showNewItemModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return NewItemModal(textTheme: Theme.of(context).textTheme);
      },
    );
  }

  void _showCurrency() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: CurrencyModal(
            textTheme: Theme.of(context).textTheme,
            onCurrencySelected: (String currency) {
              setState(() {
                _selectedCurrency = currency;
              });
            },
          ),
        );
      },
    );
  }
}
