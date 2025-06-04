import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:invoice_generator/core/router/app_router.dart';

@RoutePage()
class YourInvoicesSafeScreen extends StatelessWidget {
  const YourInvoicesSafeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      //TODO: skip logic implements
                    },
                    child: Text('Skip', style: textTheme.labelSmall),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'Your invoices are\nsafe now!',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: textTheme.bodySmall,
                  children: const [
                    TextSpan(
                      text: 'All your invoices are now synced to your account ',
                    ),
                    TextSpan(
                      text: 'yourmail@example.com',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Bottom info
              Text(
                'When you reinstall the app,\nremind yourself to log back in',
                textAlign: TextAlign.center,
                style: textTheme.bodySmall,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(69, 187, 80, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    context.router.push(const AddLogoRoute());
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
