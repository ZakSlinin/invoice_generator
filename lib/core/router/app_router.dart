import 'package:auto_route/auto_route.dart';
import 'package:invoice_generator/features/get_started/screens/get_started_screen.dart';
import 'package:invoice_generator/features/onboarding_control_invoices/screens/control_invoices_screen.dart';
import 'package:invoice_generator/features/onboarding_welcome_to_receipts/screens/welcome_to_receipts_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: GetStartedRoute.page, initial: true),
    AutoRoute(page: WelcomeToReceiptsRoute.page),
    AutoRoute(page: ControlInvoiceRoute.page),
  ];
}
