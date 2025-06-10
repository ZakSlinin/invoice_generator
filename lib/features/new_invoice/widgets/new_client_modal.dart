import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_generator/features/new_invoice/bloc/new_client_bloc/new_client_bloc.dart';

class NewClientModal extends StatelessWidget {
  final TextTheme textTheme;
  final TextEditingController billToController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final bool Function() validateFields;

  const NewClientModal({
    super.key,
    required this.textTheme,
    required this.billToController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.validateFields,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(243, 243, 243, 1),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildModalHeader(context),
            Text('New Client', style: textTheme.bodyLarge),
            const SizedBox(height: 24),
            _buildBillToField(),
            const SizedBox(height: 24),
            _buildContactsSection(),
            const SizedBox(height: 24),
            _buildImportContactsButton(),
            SizedBox(
              height: max(
                MediaQuery.of(context).size.height * 0.2,
                min(MediaQuery.of(context).size.height * 0.33, 300),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModalHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (validateFields()) {
              context.read<NewClientBloc>().add(
                NewClientSaveEvent(
                  email: emailController.text,
                  phone: phoneController.text,
                  address: addressController.text,
                  billTo: billToController.text,
                ),
              );
              Navigator.pop(context);
            }
          },
          child: Text('Done', style: textTheme.labelSmall),
        ),
      ],
    );
  }

  Widget _buildBillToField() {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: TextField(
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Bill To',
                hintStyle: textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                isDense: true,
                contentPadding: const EdgeInsets.all(8),
              ),
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              controller: billToController,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contacts', style: textTheme.bodySmall),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildContactRow('E-mail', 'Optional', emailController),
              const Divider(),
              _buildContactRow('Phone', 'Optional', phoneController),
              const Divider(),
              _buildContactRow('Address', '', addressController),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow(
    String label,
    String hintText,
    TextEditingController controller,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 80, child: Text(label, style: textTheme.bodyMedium)),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
            ),
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: label == 'E-mail'
                ? TextInputType.emailAddress
                : (label == 'Phone' ? TextInputType.phone : TextInputType.text),
            maxLines: label == 'Address' ? null : 1,
          ),
        ),
      ],
    );
  }

  Widget _buildImportContactsButton() {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement Import From Contacts functionality
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color.fromRGBO(69, 187, 80, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
            side: const BorderSide(color: Color.fromRGBO(69, 187, 80, 1)),
          ),
          elevation: 0,
        ),
        child: const Text('Import From Contacts'),
      ),
    );
  }
}
