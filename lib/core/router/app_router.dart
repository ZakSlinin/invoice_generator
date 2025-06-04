import 'package:auto_route/auto_route.dart';
import 'package:invoice_generator/features/onboarding/screens/add_logo_screen.dart';
import 'package:invoice_generator/features/onboarding/screens/get_started_screen.dart';
import 'package:invoice_generator/features/onboarding/screens/welcome_to_receipts_screen.dart';
import 'package:invoice_generator/features/onboarding/screens/control_invoices_screen.dart';
import 'package:invoice_generator/features/onboarding/screens/simple_screen.dart';
import 'package:invoice_generator/features/onboarding/screens/your_invoices_safe_screen.dart';
import 'package:invoice_generator/features/your_items/screens/your_items_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: GetStartedRoute.page, initial: true),
    AutoRoute(page: WelcomeToReceiptsRoute.page),
    AutoRoute(page: ControlInvoiceRoute.page),
    AutoRoute(page: SimpleRoute.page),
    AutoRoute(page: YourItemsRoute.page),
    AutoRoute(page: YourInvoicesSafeRoute.page),
    AutoRoute(page: AddLogoRoute.page),
  ];
}
