import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_generator/features/new_invoice/bloc/new_item_bloc/new_item_bloc.dart';
import 'package:invoice_generator/features/new_invoice/widgets/uint_and_quantily_section.dart';

class NewItemModal extends StatefulWidget {
  final TextTheme textTheme;

  const NewItemModal({super.key, required this.textTheme});

  @override
  State<NewItemModal> createState() => _NewItemModalState(textTheme: textTheme);
}

class _NewItemModalState extends State<NewItemModal> {
  final TextTheme textTheme;
  final TextEditingController _billToController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitTypeController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  bool _saveToCatalog = false;
  bool _isTaxable = false;

  _NewItemModalState({required this.textTheme});

  @override
  void initState() {
    super.initState();
    _discountController.text = '0';
  }

  @override
  void dispose() {
    _billToController.dispose();
    _unitPriceController.dispose();
    _quantityController.dispose();
    _unitTypeController.dispose();
    _discountController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _handleAddItem() {
    context.read<NewItemBloc>().add(
      NewItemSaveEvent(
        billTo: _billToController.text,
        details: _detailsController.text,
        saveToItemsCatalog: _saveToCatalog,
        unitPrice: _unitPriceController.text,
        quantity: _quantityController.text,
        unitType: _unitTypeController.text,
        discount: _discountController.text != '0',
        taxable: _isTaxable ? 'Yes' : 'No',
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewItemBloc, NewItemState>(
      listener: (context, state) {
        if (state is NewItemSaveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item saved successfully')),
          );
        } else if (state is NewItemSaveFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save item: ${state.message}')),
          );
        }
      },
      child: Padding(
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
              _buildHeader(context),
              const SizedBox(height: 16),
              Text('New Item', style: widget.textTheme.bodyLarge),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(children: [_buildBillToField(), _buildDetails()]),
              ),
              const SizedBox(height: 24),
              _buildSaveToCatalogSwitch(),
              const SizedBox(height: 24),
              UnitAndQuantitySection(
                textTheme: textTheme,
                dueDateController: _quantityController,
                invoiceNumberController: _unitTypeController,
                issuedDateController: _unitPriceController,
              ),
              const SizedBox(height: 24),
              _buildDiscountSection(),
              const SizedBox(height: 24),
              _buildTaxableSwitch(),
              const SizedBox(height: 100),
              _buildAddItemButton(),
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

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: widget.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        TextButton(
          onPressed: _handleAddItem,
          child: Text('Done', style: widget.textTheme.labelSmall),
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
              controller: _billToController,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetails() {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: TextField(
              textAlign: TextAlign.start,
              maxLines: 3,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Details (e. g. Completed on 1/12)',
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
              controller: _detailsController,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveToCatalogSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Save to Items catalog', style: widget.textTheme.bodyMedium),
        Switch(
          value: _saveToCatalog,
          onChanged: (value) {
            setState(() {
              _saveToCatalog = value;
            });
          },
          activeColor: const Color.fromRGBO(69, 187, 80, 1),
        ),
      ],
    );
  }

  Widget _buildDiscountSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Discount', style: widget.textTheme.bodySmall),
          const SizedBox(height: 4),
          TextField(
            controller: _discountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '0',
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            style: widget.textTheme.labelLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildTaxableSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Taxable', style: widget.textTheme.bodyMedium),
        Switch(
          value: _isTaxable,
          onChanged: (value) {
            setState(() {
              _isTaxable = value;
            });
          },
          activeColor: const Color.fromRGBO(69, 187, 80, 1),
        ),
      ],
    );
  }

  Widget _buildAddItemButton() {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
            side: const BorderSide(
              color: Color.fromRGBO(69, 187, 80, 1),
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          elevation: 0,
        ),
        onPressed: _handleAddItem,
        child: Text(
          'Add Item',
          style: widget.textTheme.titleMedium?.copyWith(
            color: Color.fromRGBO(69, 187, 80, 1),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
