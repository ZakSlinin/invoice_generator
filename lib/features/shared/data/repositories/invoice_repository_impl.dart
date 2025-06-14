import 'dart:convert';
import 'package:invoice_generator/features/shared/data/repositories/abstract_invoice_repository.dart';
import 'package:invoice_generator/features/shared/models/invoice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceRepositoryImpl implements AbstractInvoiceRepository {
  static const String _invoicesKey = 'invoices';

  @override
  Future<void> saveInvoice(Invoice invoice) async {
    final prefs = await SharedPreferences.getInstance();
    final invoiceJson = json.encode(invoice.toJson());
    await prefs.setString('invoice_${invoice.invoiceNumber}', invoiceJson);

    final invoiceNumbers = prefs.getStringList(_invoicesKey) ?? [];
    if (!invoiceNumbers.contains(invoice.invoiceNumber)) {
      invoiceNumbers.add(invoice.invoiceNumber);
      await prefs.setStringList(_invoicesKey, invoiceNumbers);
    }
  }

  @override
  Future<List<Invoice>> getAllInvoices() async {
    final prefs = await SharedPreferences.getInstance();
    final invoiceNumbers = prefs.getStringList(_invoicesKey) ?? [];
    final List<Invoice> invoices = [];

    for (final number in invoiceNumbers) {
      final invoiceJson = prefs.getString('invoice_$number');
      if (invoiceJson != null) {
        invoices.add(Invoice.fromJson(json.decode(invoiceJson)));
      }
    }
    return invoices;
  }

  @override
  Future<void> deleteInvoice(String invoiceNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('invoice_$invoiceNumber');

    final invoiceNumbers = prefs.getStringList(_invoicesKey) ?? [];
    invoiceNumbers.remove(invoiceNumber);
    await prefs.setStringList(_invoicesKey, invoiceNumbers);
  }
}
