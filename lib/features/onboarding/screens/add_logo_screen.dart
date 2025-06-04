import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:invoice_generator/core/services/image_picker/image_picker_service.dart';

@RoutePage()
class AddLogoScreen extends StatefulWidget {
  const AddLogoScreen({super.key});

  @override
  State<AddLogoScreen> createState() => _AddLogoScreenState();
}

class _AddLogoScreenState extends State<AddLogoScreen> {
  File? _selectedImageLogo;
  final ImagePicker _picker = ImagePicker();

  Future<void> _handleLogoPick(ImageSource source) async {
    try {
      final File? image = await pickImage(source: source);
      if (image != null) {
        setState(() {
          _selectedImageLogo = image;
        });
      }
      Navigator.pop(context);
    } catch (e) {
      print('Error picking avatar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
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
                        onPressed: () {
                          // TODO: Implement Skip logic
                        },
                        child: Text('Skip', style: textTheme.labelSmall),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Do You Have a Logo?',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'It will appear on invoice',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _selectedImageLogo != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _selectedImageLogo!,
                                fit: BoxFit.contain,
                              ),
                            )
                          : Center(
                              child: Image.asset('assets/images/add_logo.png', height: 120, width: 1920,),
                            ),
                    ),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Select source'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () =>
                                _handleLogoPick(ImageSource.camera),
                            child: const Text('Camera'),
                          ),
                          TextButton(
                            onPressed: () =>
                                _handleLogoPick(ImageSource.gallery),
                            child: const Text('Gallery'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
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
                  onPressed: () {
                    // TODO: Implement Continue logic
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
            ),
          ],
        ),
      ),
    );
  }
}
