import 'package:flutter/material.dart';
import 'package:invoice_generator/features/new_invoice/services/currency_service.dart';

class CurrencyModal extends StatefulWidget {
  final TextTheme textTheme;
  final Function(String) onCurrencySelected;

  const CurrencyModal({
    super.key,
    required this.textTheme,
    required this.onCurrencySelected,
  });

  @override
  State<CurrencyModal> createState() => _CurrencyModalState();
}

class _CurrencyModalState extends State<CurrencyModal> {
  String? _selectedCurrency;
  final List<Map<String, String>> _recentCurrencies = [];

  @override
  void initState() {
    super.initState();
    _loadSelectedCurrency();
    _loadRecentCurrencies();
  }

  Future<void> _loadSelectedCurrency() async {
    final currency = await CurrencyService.getSelectedCurrency();
    setState(() {
      _selectedCurrency = currency;
    });
  }

  Future<void> _loadRecentCurrencies() async {
    final recent = await CurrencyService.getRecentCurrencies();
    setState(() {
      _recentCurrencies.clear();
      for (var code in recent) {
        final currency = currencies.firstWhere(
          (c) => c['code'] == code,
          orElse: () => {'code': code, 'name': 'Unknown'},
        );
        _recentCurrencies.add(currency);
      }
    });
  }

  Future<void> _handleCurrencySelection(String currencyCode) async {
    await CurrencyService.setSelectedCurrency(currencyCode);
    setState(() {
      _selectedCurrency = currencyCode;
    });
    _loadRecentCurrencies();
    widget.onCurrencySelected(currencyCode);
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
          const Spacer(),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildMostRecentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Most recent',
          style: widget.textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        ..._recentCurrencies.map(
          (currency) => _buildCurrencyItem(
            currency['code']!,
            currency['name']!,
            isSelected: currency['code'] == _selectedCurrency,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencyItem(
    String code,
    String name, {
    bool isSelected = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => _handleCurrencySelection(code),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  code,
                  style: widget.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isSelected) const Icon(Icons.check, color: Colors.black),
              ],
            ),
            Text(
              name,
              style: widget.textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllCurrenciesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All currencies',
          style: widget.textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: currencies.length,
            separatorBuilder: (context, index) => const Divider(indent: 16),
            itemBuilder: (context, index) {
              final currency = currencies[index];
              return _buildCurrencyItem(
                currency['code']!,
                currency['name']!,
                isSelected: currency['code'] == _selectedCurrency,
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromRGBO(243, 243, 243, 1),
          ),
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context),
              const SizedBox(height: 8),
              Center(
                child: Text('Currency', style: widget.textTheme.bodyLarge),
              ),
              const SizedBox(height: 24),
              _buildMostRecentSection(context),
              const SizedBox(height: 24),
              _buildAllCurrenciesSection(context),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom == 0
                    ? 0
                    : MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const List<Map<String, String>> currencies = [
    {'code': 'AED', 'name': 'United Arab Emirates dirham'},
    {'code': 'AFN', 'name': 'Afghan Afghani'},
    {'code': 'ALL', 'name': 'Albanian lek'},
    {'code': 'AMD', 'name': 'Armenian dram'},
    {'code': 'ANG', 'name': 'Netherlands Antillean guilder'},
    {'code': 'AOA', 'name': 'Angolan kwanza'},
    {'code': 'ARS', 'name': 'Argentine peso'},
    {'code': 'AUD', 'name': 'Australian dollar'},
    {'code': 'AWG', 'name': 'Aruban florin'},
    {'code': 'AZN', 'name': 'Azerbaijani manat'},
    {'code': 'BAM', 'name': 'Bosnia and Herzegovina convertible mark'},
    {'code': 'BBD', 'name': 'Barbadian dollar'},
    {'code': 'BDT', 'name': 'Bangladeshi taka'},
    {'code': 'BGN', 'name': 'Bulgarian lev'},
    {'code': 'BHD', 'name': 'Bahraini dinar'},
    {'code': 'BIF', 'name': 'Burundian franc'},
    {'code': 'BMD', 'name': 'Bermudian dollar'},
    {'code': 'BND', 'name': 'Brunei dollar'},
    {'code': 'BOB', 'name': 'Bolivian boliviano'},
    {'code': 'BRL', 'name': 'Brazilian real'},
    {'code': 'BSD', 'name': 'Bahamian dollar'},
    {'code': 'BTN', 'name': 'Bhutanese ngultrum'},
    {'code': 'BWP', 'name': 'Botswana pula'},
    {'code': 'BYN', 'name': 'Belarusian ruble'},
    {'code': 'BZD', 'name': 'Belize dollar'},
    {'code': 'CAD', 'name': 'Canadian dollar'},
    {'code': 'CDF', 'name': 'Congolese franc'},
    {'code': 'CHF', 'name': 'Swiss franc'},
    {'code': 'CLP', 'name': 'Chilean peso'},
    {'code': 'CNY', 'name': 'Chinese yuan'},
    {'code': 'COP', 'name': 'Colombian peso'},
    {'code': 'CRC', 'name': 'Costa Rican colon'},
    {'code': 'CUP', 'name': 'Cuban peso'},
    {'code': 'CVE', 'name': 'Cape Verdean escudo'},
    {'code': 'CZK', 'name': 'Czech koruna'},
    {'code': 'DJF', 'name': 'Djiboutian franc'},
    {'code': 'DKK', 'name': 'Danish krone'},
    {'code': 'DOP', 'name': 'Dominican peso'},
    {'code': 'DZD', 'name': 'Algerian dinar'},
    {'code': 'EGP', 'name': 'Egyptian pound'},
    {'code': 'ERN', 'name': 'Eritrean nakfa'},
    {'code': 'ETB', 'name': 'Ethiopian birr'},
    {'code': 'EUR', 'name': 'Euro'},
    {'code': 'FJD', 'name': 'Fijian dollar'},
    {'code': 'FKP', 'name': 'Falkland Islands pound'},
    {'code': 'GBP', 'name': 'British pound'},
    {'code': 'GEL', 'name': 'Georgian lari'},
    {'code': 'GHS', 'name': 'Ghanaian cedi'},
    {'code': 'GIP', 'name': 'Gibraltar pound'},
    {'code': 'GMD', 'name': 'Gambian dalasi'},
    {'code': 'GNF', 'name': 'Guinean franc'},
    {'code': 'GTQ', 'name': 'Guatemalan quetzal'},
    {'code': 'GYD', 'name': 'Guyanese dollar'},
    {'code': 'HKD', 'name': 'Hong Kong dollar'},
    {'code': 'HNL', 'name': 'Honduran lempira'},
    {'code': 'HRK', 'name': 'Croatian kuna'},
    {'code': 'HTG', 'name': 'Haitian gourde'},
    {'code': 'HUF', 'name': 'Hungarian forint'},
    {'code': 'IDR', 'name': 'Indonesian rupiah'},
    {'code': 'ILS', 'name': 'Israeli new shekel'},
    {'code': 'INR', 'name': 'Indian rupee'},
    {'code': 'IQD', 'name': 'Iraqi dinar'},
    {'code': 'IRR', 'name': 'Iranian rial'},
    {'code': 'ISK', 'name': 'Icelandic krona'},
    {'code': 'JMD', 'name': 'Jamaican dollar'},
    {'code': 'JOD', 'name': 'Jordanian dinar'},
    {'code': 'JPY', 'name': 'Japanese yen'},
    {'code': 'KES', 'name': 'Kenyan shilling'},
    {'code': 'KGS', 'name': 'Kyrgyzstani som'},
    {'code': 'KHR', 'name': 'Cambodian riel'},
    {'code': 'KMF', 'name': 'Comorian franc'},
    {'code': 'KRW', 'name': 'South Korean won'},
    {'code': 'KWD', 'name': 'Kuwaiti dinar'},
    {'code': 'KYD', 'name': 'Cayman Islands dollar'},
    {'code': 'KZT', 'name': 'Kazakhstani tenge'},
    {'code': 'LAK', 'name': 'Lao kip'},
    {'code': 'LBP', 'name': 'Lebanese pound'},
    {'code': 'LKR', 'name': 'Sri Lankan rupee'},
    {'code': 'LRD', 'name': 'Liberian dollar'},
    {'code': 'LSL', 'name': 'Lesotho loti'},
    {'code': 'LYD', 'name': 'Libyan dinar'},
    {'code': 'MAD', 'name': 'Moroccan dirham'},
    {'code': 'MDL', 'name': 'Moldovan leu'},
    {'code': 'MGA', 'name': 'Malagasy ariary'},
    {'code': 'MKD', 'name': 'Macedonian denar'},
    {'code': 'MMK', 'name': 'Myanmar kyat'},
    {'code': 'MNT', 'name': 'Mongolian tugrik'},
    {'code': 'MOP', 'name': 'Macanese pataca'},
    {'code': 'MRO', 'name': 'Mauritanian ouguiya'},
    {'code': 'MUR', 'name': 'Mauritian rupee'},
    {'code': 'MVR', 'name': 'Maldivian rufiyaa'},
    {'code': 'MWK', 'name': 'Malawian kwacha'},
    {'code': 'MXN', 'name': 'Mexican peso'},
    {'code': 'MYR', 'name': 'Malaysian ringgit'},
    {'code': 'MZN', 'name': 'Mozambican metical'},
    {'code': 'NAD', 'name': 'Namibian dollar'},
    {'code': 'NGN', 'name': 'Nigerian naira'},
    {'code': 'NIO', 'name': 'Nicaraguan cordoba'},
    {'code': 'NOK', 'name': 'Norwegian krone'},
    {'code': 'NPR', 'name': 'Nepalese rupee'},
    {'code': 'NZD', 'name': 'New Zealand dollar'},
    {'code': 'OMR', 'name': 'Omani rial'},
    {'code': 'PAB', 'name': 'Panamanian balboa'},
    {'code': 'PEN', 'name': 'Peruvian sol'},
    {'code': 'PGK', 'name': 'Papua New Guinean kina'},
    {'code': 'PHP', 'name': 'Philippine peso'},
    {'code': 'PKR', 'name': 'Pakistani rupee'},
    {'code': 'PLN', 'name': 'Polish zloty'},
    {'code': 'PYG', 'name': 'Paraguayan guarani'},
    {'code': 'QAR', 'name': 'Qatari riyal'},
    {'code': 'RON', 'name': 'Romanian leu'},
    {'code': 'RSD', 'name': 'Serbian dinar'},
    {'code': 'RUB', 'name': 'Russian ruble'},
    {'code': 'RWF', 'name': 'Rwandan franc'},
    {'code': 'SAR', 'name': 'Saudi riyal'},
    {'code': 'SBD', 'name': 'Solomon Islands dollar'},
    {'code': 'SCR', 'name': 'Seychellois rupee'},
    {'code': 'SDG', 'name': 'Sudanese pound'},
    {'code': 'SEK', 'name': 'Swedish krona'},
    {'code': 'SGD', 'name': 'Singapore dollar'},
    {'code': 'SHP', 'name': 'Saint Helena pound'},
    {'code': 'SLL', 'name': 'Sierra Leonean Leone'},
    {'code': 'SOS', 'name': 'Somali shilling'},
    {'code': 'SRD', 'name': 'Surinamese dollar'},
    {'code': 'SSP', 'name': 'South Sudanese pound'},
    {'code': 'STD', 'name': 'Sao Tome and Principe dobra'},
    {'code': 'SVC', 'name': 'Salvadoran colon'},
    {'code': 'SYP', 'name': 'Syrian pound'},
    {'code': 'SZL', 'name': 'Swazi lilangeni'},
    {'code': 'THB', 'name': 'Thai baht'},
    {'code': 'TJS', 'name': 'Tajikistani somoni'},
    {'code': 'TMT', 'name': 'Turkmenistani manat'},
    {'code': 'TND', 'name': 'Tunisian dinar'},
    {'code': 'TOP', 'name': 'Tongan paʻanga'},
    {'code': 'TRY', 'name': 'Turkish lira'},
    {'code': 'TTD', 'name': 'Trinidad and Tobago dollar'},
    {'code': 'TWD', 'name': 'New Taiwan dollar'},
    {'code': 'TZS', 'name': 'Tanzanian shilling'},
    {'code': 'UAH', 'name': 'Ukrainian hryvnia'},
    {'code': 'UGX', 'name': 'Ugandan shilling'},
    {'code': 'USD', 'name': 'United States dollar'},
    {'code': 'UYU', 'name': 'Uruguayan peso'},
    {'code': 'UZS', 'name': 'Uzbekistani som'},
    {'code': 'VEF', 'name': 'Venezuelan bolívar'},
    {'code': 'VND', 'name': 'Vietnamese dong'},
    {'code': 'VUV', 'name': 'Vanuatu vatu'},
    {'code': 'WST', 'name': 'Samoan tala'},
    {'code': 'XAF', 'name': 'Central African CFA franc'},
    {'code': 'XCD', 'name': 'East Caribbean dollar'},
    {'code': 'XOF', 'name': 'West African CFA franc'},
    {'code': 'XPF', 'name': 'CFP franc'},
    {'code': 'YER', 'name': 'Yemeni rial'},
    {'code': 'ZAR', 'name': 'South African rand'},
    {'code': 'ZMW', 'name': 'Zambian kwacha'},
    {'code': 'ZWL', 'name': 'Zimbabwean dollar'},
  ];
}
