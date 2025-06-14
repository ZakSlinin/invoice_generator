import 'dart:convert';

class Invoice {
  final String issuedDate;
  final String invoiceNumber;
  final Map<String, dynamic>? client;
  final List<Map<String, dynamic>> items;
  final double totalAmount;
  final String selectedCurrency;

  Invoice({
    required this.issuedDate,
    required this.invoiceNumber,
    this.client,
    required this.items,
    required this.totalAmount,
    required this.selectedCurrency,
  });

  Map<String, dynamic> toJson() {
    return {
      'issuedDate': issuedDate,
      'invoiceNumber': invoiceNumber,
      'client': client,
      'items': items,
      'totalAmount': totalAmount,
      'selectedCurrency': selectedCurrency,
    };
  }

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      issuedDate: json['issuedDate'],
      invoiceNumber: json['invoiceNumber'],
      client: json['client'] != null
          ? Map<String, dynamic>.from(json['client'])
          : null,
      items: List<Map<String, dynamic>>.from(json['items']),
      totalAmount: json['totalAmount'],
      selectedCurrency: json['selectedCurrency'],
    );
  }
}
