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
    ControlInvoiceRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ControlInvoiceScreen(),
      );
    },
    GetStartedRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GetStartedScreen(),
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
    YourItemsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const YourItemsScreen(),
      );
    },
  };
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
