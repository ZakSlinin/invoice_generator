import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invoice_generator/features/new_invoice/bloc/new_item_bloc/new_item_bloc.dart';

class ItemsSection extends StatelessWidget {
  final TextTheme textTheme;
  final VoidCallback onAddItem;
  final bool showOnlyCurrentSession;

  const ItemsSection({
    super.key,
    required this.textTheme,
    required this.onAddItem,
    this.showOnlyCurrentSession = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Items', style: textTheme.bodySmall),
        const SizedBox(height: 8),
        _buildAddButton(label: 'Add Item', onTap: onAddItem),
        const SizedBox(height: 16),
        BlocBuilder<NewItemBloc, NewItemState>(
          builder: (context, state) {
            if (state is NewItemLoaded) {
              final items = showOnlyCurrentSession
                  ? state.currentSessionItems
                  : state.items;

              if (items.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                children: items.map((item) {
                  final unitPrice = (item['unitPrice'] as double?) ?? 0.0;
                  final quantity = (item['quantity'] as double?) ?? 0.0;
                  final unitType = item['unitType'] as String? ?? '';
                  final itemTotal = unitPrice * quantity;
                  final currency = item['currency'] as String? ?? 'USD';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        item['details'] ?? '',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            '${unitPrice.toStringAsFixed(2)} $currency × $quantity $unitType',
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        '${itemTotal.toStringAsFixed(2)} $currency',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
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
