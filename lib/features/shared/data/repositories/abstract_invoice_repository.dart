import 'package:invoice_generator/features/shared/models/invoice.dart';

abstract class AbstractInvoiceRepository {
  Future<void> saveInvoice(Invoice invoice);
  Future<List<Invoice>> getAllInvoices();
  Future<void> deleteInvoice(String invoiceNumber);
}
