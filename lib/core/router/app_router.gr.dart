// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddLogoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddLogoScreen(),
      );
    },
    ControlInvoiceRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ControlInvoiceScreen(),
      );
    },
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardScreen(),
      );
    },
    GetStartedRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GetStartedScreen(),
      );
    },
    NewInvoiceRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewInvoiceScreen(),
      );
    },
    PreviewInvoiceRoute.name: (routeData) {
      final args = routeData.argsAs<PreviewInvoiceRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PreviewInvoiceScreen(
          key: args.key,
          issuedDate: args.issuedDate,
          invoiceNumber: args.invoiceNumber,
          client: args.client,
          items: args.items,
          totalAmount: args.totalAmount,
          selectedCurrency: args.selectedCurrency,
        ),
      );
    },
    SimpleRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SimpleScreen(),
      );
    },
    WelcomeToReceiptsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomeToReceiptsScreen(),
      );
    },
    YourInvoicesSafeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const YourInvoicesSafeScreen(),
      );
    },
    YourItemsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const YourItemsScreen(),
      );
    },
  };
}

/// generated route for
/// [AddLogoScreen]
class AddLogoRoute extends PageRouteInfo<void> {
  const AddLogoRoute({List<PageRouteInfo>? children})
      : super(
          AddLogoRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddLogoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ControlInvoiceScreen]
class ControlInvoiceRoute extends PageRouteInfo<void> {
  const ControlInvoiceRoute({List<PageRouteInfo>? children})
      : super(
          ControlInvoiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'ControlInvoiceRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DashboardScreen]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [GetStartedScreen]
class GetStartedRoute extends PageRouteInfo<void> {
  const GetStartedRoute({List<PageRouteInfo>? children})
      : super(
          GetStartedRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetStartedRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewInvoiceScreen]
class NewInvoiceRoute extends PageRouteInfo<void> {
  const NewInvoiceRoute({List<PageRouteInfo>? children})
      : super(
          NewInvoiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewInvoiceRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PreviewInvoiceScreen]
class PreviewInvoiceRoute extends PageRouteInfo<PreviewInvoiceRouteArgs> {
  PreviewInvoiceRoute({
    Key? key,
    required String issuedDate,
    required String invoiceNumber,
    Map<String, dynamic>? client,
    required List<Map<String, dynamic>> items,
    required double totalAmount,
    required String selectedCurrency,
    List<PageRouteInfo>? children,
  }) : super(
          PreviewInvoiceRoute.name,
          args: PreviewInvoiceRouteArgs(
            key: key,
            issuedDate: issuedDate,
            invoiceNumber: invoiceNumber,
            client: client,
            items: items,
            totalAmount: totalAmount,
            selectedCurrency: selectedCurrency,
          ),
          initialChildren: children,
        );

  static const String name = 'PreviewInvoiceRoute';

  static const PageInfo<PreviewInvoiceRouteArgs> page =
      PageInfo<PreviewInvoiceRouteArgs>(name);
}

class PreviewInvoiceRouteArgs {
  const PreviewInvoiceRouteArgs({
    this.key,
    required this.issuedDate,
    required this.invoiceNumber,
    this.client,
    required this.items,
    required this.totalAmount,
    required this.selectedCurrency,
  });

  final Key? key;

  final String issuedDate;

  final String invoiceNumber;

  final Map<String, dynamic>? client;

  final List<Map<String, dynamic>> items;

  final double totalAmount;

  final String selectedCurrency;

  @override
  String toString() {
    return 'PreviewInvoiceRouteArgs{key: $key, issuedDate: $issuedDate, invoiceNumber: $invoiceNumber, client: $client, items: $items, totalAmount: $totalAmount, selectedCurrency: $selectedCurrency}';
  }
}

/// generated route for
/// [SimpleScreen]
class SimpleRoute extends PageRouteInfo<void> {
  const SimpleRoute({List<PageRouteInfo>? children})
      : super(
          SimpleRoute.name,
          initialChildren: children,
        );

  static const String name = 'SimpleRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WelcomeToReceiptsScreen]
class WelcomeToReceiptsRoute extends PageRouteInfo<void> {
  const WelcomeToReceiptsRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeToReceiptsRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeToReceiptsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [YourInvoicesSafeScreen]
class YourInvoicesSafeRoute extends PageRouteInfo<void> {
  const YourInvoicesSafeRoute({List<PageRouteInfo>? children})
      : super(
          YourInvoicesSafeRoute.name,
          initialChildren: children,
        );

  static const String name = 'YourInvoicesSafeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [YourItemsScreen]
class YourItemsRoute extends PageRouteInfo<void> {
  const YourItemsRoute({List<PageRouteInfo>? children})
      : super(
          YourItemsRoute.name,
          initialChildren: children,
        );

  static const String name = 'YourItemsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
