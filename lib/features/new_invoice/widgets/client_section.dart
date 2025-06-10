import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClientSection extends StatelessWidget {
  final TextTheme textTheme;
  final VoidCallback onAddClient;

  const ClientSection({
    super.key,
    required this.textTheme,
    required this.onAddClient,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Client', style: textTheme.bodySmall),
        const SizedBox(height: 8),
        _buildAddButton(label: 'Add Client', onTap: onAddClient),
      ],
    );
  }

  Widget _buildAddButton({required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/svg/add.svg'),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
