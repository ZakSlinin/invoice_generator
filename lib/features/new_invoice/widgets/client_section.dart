import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invoice_generator/features/new_invoice/bloc/new_client_bloc/new_client_bloc.dart';

class ClientSection extends StatelessWidget {
  final TextTheme textTheme;
  final VoidCallback onAddClient;
  final bool showOnlyCurrentSession;

  const ClientSection({
    super.key,
    required this.textTheme,
    required this.onAddClient,
    this.showOnlyCurrentSession = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Client', style: textTheme.bodySmall),
        const SizedBox(height: 8),
        _buildAddButton(label: 'Add Client', onTap: onAddClient),
        const SizedBox(height: 16),
        BlocBuilder<NewClientBloc, NewClientState>(
          builder: (context, state) {
            if (state is NewClientLoaded) {
              final clients = showOnlyCurrentSession
                  ? state.currentSessionClients
                  : state.clients;

              if (clients.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                children: clients.map((client) {
                  return ListTile(
                    title: Text(
                      client['billTo'] ?? '',
                      style: textTheme.bodyLarge,
                    ),
                    subtitle: Text(client['email'] ?? ''),
                    trailing: const Icon(Icons.arrow_forward_ios),
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
