part of 'invoice_bloc.dart';

abstract class InvoiceEvent {}

class FetchInvoicesEvent extends InvoiceEvent {}

class DeleteInvoiceEvent extends InvoiceEvent {
  final String invoiceNumber;

  DeleteInvoiceEvent({required this.invoiceNumber});
}
