import 'package:auto_route/auto_route.dart';
import 'package:invoice_generator/features/dashboard/screens/dashboard_screen.dart';
import 'package:invoice_generator/features/new_invoice/screens/new_invoice_screen.dart';
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
    AutoRoute(page: GetStartedRoute.page, path: '/get-started'),
    AutoRoute(page: WelcomeToReceiptsRoute.page, path: '/welcome-to-receipts'),
    AutoRoute(page: ControlInvoiceRoute.page, path: '/control-invoice'),
    AutoRoute(page: SimpleRoute.page, path: '/simple'),
    AutoRoute(page: YourItemsRoute.page, path: '/your-items'),
    AutoRoute(page: YourInvoicesSafeRoute.page, path: '/your-invoices-safe'),
    AutoRoute(page: AddLogoRoute.page, path: '/add-logo'),
    AutoRoute(page: DashboardRoute.page, path: '/dashboard'),
    AutoRoute(page: NewInvoiceRoute.page, path: '/new-invoice'),
  ];
}
