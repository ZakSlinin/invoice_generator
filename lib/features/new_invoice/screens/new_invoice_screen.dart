import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:invoice_generator/features/new_invoice/bloc/new_client_bloc/new_client_bloc.dart';
import 'package:invoice_generator/features/new_invoice/bloc/new_item_bloc/new_item_bloc.dart';
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
import 'package:invoice_generator/features/shared/data/repositories/abstract_invoice_repository.dart';
import 'package:invoice_generator/features/shared/models/invoice.dart';

import '../../../core/router/app_router.dart';

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _errorMessage;
  String _selectedCurrency = 'USD';
  double _totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadSelectedCurrency();
    // Fetch items and clients when screen loads
    context.read<NewItemBloc>().add(NewItemFetchEvent());
    context.read<NewClientBloc>().add(NewClientFetchEvent());
  }

  Future<void> _loadSelectedCurrency() async {
    final currency = await CurrencyService.getSelectedCurrency();
    setState(() {
      _selectedCurrency = currency;
    });
  }

  void _initializeControllers() {
    _issuedDateController.text = '0.00';
    _invoiceNumberController.text = '001';
  }

  @override
  void dispose() {
    _issuedDateController.dispose();
    _dueDateController.dispose();
    _invoiceNumberController.dispose();
    _billToController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // Validation
  bool _validateFields() {
    if (_addressController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter address')));
      return false;
    }

    final email = _emailController.text;
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
    return BlocConsumer<NewItemBloc, NewItemState>(
      listener: (context, itemState) {
        if (itemState is NewItemLoaded) {
          double total = 0.0;
          for (var item in itemState.currentSessionItems) {
            final unitPrice = (item['unitPrice'] as double?) ?? 0.0;
            final quantity = (item['quantity'] as double?) ?? 0.0;
            total += unitPrice * quantity;
          }
          setState(() {
            _totalAmount = total;
          });
        }
      },
      builder: (context, itemState) {
        return BlocBuilder<NewClientBloc, NewClientState>(
          builder: (context, clientState) {
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
                        HeaderWidget(
                          textTheme: textTheme,
                          issuedDate: _issuedDateController.text,
                          invoiceNumber: _invoiceNumberController.text,
                          client:
                              clientState is NewClientLoaded &&
                                  clientState.currentSessionClients.isNotEmpty
                              ? clientState.currentSessionClients.first
                              : null,
                          items: itemState is NewItemLoaded
                              ? itemState.currentSessionItems
                              : [],
                          totalAmount: _totalAmount,
                          selectedCurrency: _selectedCurrency,
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            'New invoice',
                            style: textTheme.bodyLarge,
                          ),
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
                                  showOnlyCurrentSession: true,
                                ),
                                const SizedBox(height: 24),
                                SummarySection(
                                  textTheme: textTheme,
                                  total: _totalAmount.toStringAsFixed(2),
                                  onOpenCurrency: _showCurrency,
                                  selectedCurrency: _selectedCurrency,
                                  items: itemState is NewItemLoaded
                                      ? itemState.currentSessionItems
                                      : [],
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
                          onCreateInvoice: () async {
                            final String issuedDate =
                                _issuedDateController.text;
                            final String invoiceNumber =
                                _invoiceNumberController.text;
                            final Map<String, dynamic>? currentClient =
                                clientState is NewClientLoaded &&
                                    clientState.currentSessionClients.isNotEmpty
                                ? clientState.currentSessionClients.first
                                : null;
                            final List<Map<String, dynamic>> currentItems =
                                itemState is NewItemLoaded
                                ? itemState.currentSessionItems
                                : [];

                            final invoice = Invoice(
                              issuedDate: issuedDate,
                              invoiceNumber: invoiceNumber,
                              client: currentClient,
                              items: currentItems,
                              totalAmount: _totalAmount,
                              selectedCurrency: _selectedCurrency,
                            );

                            await GetIt.I<AbstractInvoiceRepository>()
                                .saveInvoice(invoice);

                            context.router.push(
                              PreviewInvoiceRoute(
                                issuedDate: issuedDate,
                                invoiceNumber: invoiceNumber,
                                client: currentClient,
                                items: currentItems,
                                totalAmount: _totalAmount,
                                selectedCurrency: _selectedCurrency,
                              ),
                            );
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
      },
    );
  }

  void _showNewClientModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NewClientModal(
        textTheme: Theme.of(context).textTheme,
        billToController: _billToController,
        emailController: _emailController,
        phoneController: _phoneController,
        addressController: _addressController,
        validateFields: _validateFields,
      ),
    );
  }

  void _showNewItemModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          NewItemModal(textTheme: Theme.of(context).textTheme),
    );
  }

  void _showCurrency() {
    showModalBottomSheet(
      context: context,
      builder: (context) => CurrencyModal(
        textTheme: Theme.of(context).textTheme,
        onCurrencySelected: (String currencyCode) {
          setState(() {
            _selectedCurrency = currencyCode;
          });
        },
      ),
    );
  }
}
