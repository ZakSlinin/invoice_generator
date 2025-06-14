import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_invoice_event.dart';
part 'new_invoice_state.dart';

class NewInvoiceBloc extends Bloc<NewInvoiceEvent, NewInvoiceState> {
  NewInvoiceBloc() : super(NewInvoiceInitial());

  Future<void> _handleOpenPage(
    NewInvoiceOpenEvent event,
    Emitter<NewInvoiceState> emit,
  ) async {
    emit(NewInvoiceLoading());

  }
}
