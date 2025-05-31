import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class YourItemsScreen extends StatelessWidget {
  const YourItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Skip',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tell Us About\nYour Business',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge?.copyWith(fontSize: 28),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'It will appear on invoice',
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          _LabeledTextField(label: 'E-mail', hint: 'Optional'),
                          Divider(height: 32),
                          _LabeledTextField(label: 'Phone', hint: 'Optional'),
                          Divider(height: 32),
                          _LabeledTextField(label: 'Address', hint: ''),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 32,
                child: SizedBox(
                  height: 64,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3ED36A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {},
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabeledTextField extends StatelessWidget {
  final String label;
  final String hint;

  const _LabeledTextField({required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
