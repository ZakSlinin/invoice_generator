import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:invoice_generator/core/router/app_router.dart';
import 'package:invoice_generator/features/dashboard/bloc/invoice_bloc/invoice_bloc.dart';
import 'package:invoice_generator/features/shared/models/invoice.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _selectedTab = 'All';

  @override
  void initState() {
    super.initState();
    context.read<InvoiceBloc>().add(FetchInvoicesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  // Name and Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning No name',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Your Daily Invoice Goals',
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Settings Icon
                  InkWell(
                    child: SvgPicture.asset('assets/svg/settings.svg'),
                    //TODO: settings button
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(246, 246, 246, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement All filter
                          setState(() {
                            _selectedTab = 'All';
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: _selectedTab == 'All'
                              ? const Color.fromRGBO(69, 187, 80, 1)
                              : const Color.fromRGBO(246, 246, 246, 1),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          'All',
                          style: textTheme.labelLarge?.copyWith(
                            color: _selectedTab == 'All'
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement Outstanding filter
                          setState(() {
                            _selectedTab = 'Outstanding';
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: _selectedTab == 'Outstanding'
                              ? const Color.fromRGBO(69, 187, 80, 1)
                              : const Color.fromRGBO(246, 246, 246, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          'Outstanding',
                          style: textTheme.labelLarge?.copyWith(
                            color: _selectedTab == 'Outstanding'
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement Paid filter
                          setState(() {
                            _selectedTab = 'Paid';
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: _selectedTab == 'Paid'
                              ? const Color.fromRGBO(69, 187, 80, 1)
                              : const Color.fromRGBO(246, 246, 246, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          'Paid',
                          style: textTheme.labelLarge?.copyWith(
                            color: _selectedTab == 'Paid'
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<InvoiceBloc, InvoiceState>(
                  builder: (context, state) {
                    if (state is InvoicesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is InvoicesLoaded) {
                      if (state.invoices.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Invoices',
                              textAlign: TextAlign.center,
                              style: textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Start by creating an invoice. Look\nProfessional to your clients',
                              textAlign: TextAlign.center,
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return ListView.builder(
                          itemCount: state.invoices.length,
                          itemBuilder: (context, index) {
                            final invoice = state.invoices[index];
                            final clientName =
                                invoice.client?['billTo'] ?? 'N/A';
                            final formattedTotal =
                                '${invoice.totalAmount.toStringAsFixed(2)} ${invoice.selectedCurrency}';

                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                title: Text(
                                  'Invoice #${invoice.invoiceNumber}',
                                  style: textTheme.bodyLarge,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'To: $clientName',
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(
                                      'Issued: ${invoice.issuedDate}',
                                      style: textTheme.bodySmall?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Text(
                                  formattedTotal,
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  context.router.push(
                                    PreviewInvoiceRoute(
                                      issuedDate: invoice.issuedDate,
                                      invoiceNumber: invoice.invoiceNumber,
                                      client: invoice.client,
                                      items: invoice.items,
                                      totalAmount: invoice.totalAmount,
                                      selectedCurrency:
                                          invoice.selectedCurrency,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    } else if (state is InvoicesError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              SizedBox(
                height: max(
                  MediaQuery.of(context).size.height * 0.05,
                  min(MediaQuery.of(context).size.height * 0.1, 100),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(69, 187, 80, 0.4),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 64,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(69, 187, 80, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      context.router.push(NewInvoiceRoute());
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
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 64,
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color.fromRGBO(69, 187, 80, 1),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // TODO: Implement Create Estimates logic
                  },
                  child: Text(
                    'Create Estimates',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(69, 187, 80, 1),
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
}
