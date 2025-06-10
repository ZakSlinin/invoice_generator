import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PhotosSection extends StatelessWidget {
  final TextTheme textTheme;
  final VoidCallback onAddPhoto;

  const PhotosSection({
    super.key,
    required this.textTheme,
    required this.onAddPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Photos', style: textTheme.bodySmall),
        const SizedBox(height: 8),
        _buildAddPhotoButton(label: 'Add Photo', onTap: onAddPhoto),
      ],
    );
  }

  Widget _buildAddPhotoButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(255, 255, 255, 1),
          image: const DecorationImage(
            image: AssetImage('assets/images/button_bg.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/svg/add.svg'),
              const SizedBox(width: 8),
              Text(label, style: textTheme.bodyLarge?.copyWith(fontSize: 18)),
              const SizedBox(width: 8),
              InkWell(child: SvgPicture.asset('assets/svg/premium_button.svg')),
            ],
          ),
        ),
      ),
    );
  }
}
