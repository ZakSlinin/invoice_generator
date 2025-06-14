part of 'invoice_bloc.dart';

abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}

class InvoicesLoading extends InvoiceState {}

class InvoicesLoaded extends InvoiceState {
  final List<Invoice> invoices;

  InvoicesLoaded({required this.invoices});
}

class InvoicesError extends InvoiceState {
  final String message;

  InvoicesError({required this.message});
}
