import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_generator/features/shared/data/repositories/abstract_invoice_repository.dart';
import 'package:invoice_generator/features/shared/models/invoice.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final AbstractInvoiceRepository _repository;

  InvoiceBloc(this._repository) : super(InvoiceInitial()) {
    on<FetchInvoicesEvent>(_onFetchInvoices);
    on<DeleteInvoiceEvent>(_onDeleteInvoice);
  }

  Future<void> _onFetchInvoices(
    FetchInvoicesEvent event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(InvoicesLoading());
    try {
      final invoices = await _repository.getAllInvoices();
      emit(InvoicesLoaded(invoices: invoices));
    } catch (e) {
      emit(InvoicesError(message: e.toString()));
    }
  }

  Future<void> _onDeleteInvoice(
    DeleteInvoiceEvent event,
    Emitter<InvoiceState> emit,
  ) async {
    try {
      await _repository.deleteInvoice(event.invoiceNumber);
      final invoices = await _repository.getAllInvoices();
      emit(InvoicesLoaded(invoices: invoices));
    } catch (e) {
      emit(InvoicesError(message: e.toString()));
    }
  }
}
