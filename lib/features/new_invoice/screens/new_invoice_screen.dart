import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewInvoiceScreen extends StatefulWidget {
  const NewInvoiceScreen({super.key});

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    child: Text(
                      'Cancel',
                      style: textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(width: 150),
                  InkWell(
                    child: Text(
                      'Preview',
                      style: textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  InkWell(child: Text('Done', style: textTheme.labelSmall)),
                ],
              ),
              Center(child: Text('New invoice', style: textTheme.bodyLarge)),
              SizedBox(height: 16,),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Issued', style: textTheme.bodySmall,),
                              const SizedBox(width: 42,),
                              Text('Due', style: textTheme.bodySmall,),
                            ],
                          ),
                        Text('#', style: textTheme.bodySmall,),
                      ],
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text('${DateTime.now().day} ${DateFormat.MMMM().format(DateTime.now())} ${DateTime.now().year}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
