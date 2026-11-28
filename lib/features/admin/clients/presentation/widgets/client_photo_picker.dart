import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ClientPhotoPicker extends StatefulWidget {
  final String? currentImageUrl;
  final ValueChanged<File>? onImageSelected;

  const ClientPhotoPicker({
    super.key,
    this.currentImageUrl,
    this.onImageSelected,
  });

  @override
  State<ClientPhotoPicker> createState() => _ClientPhotoPickerState();
}

class _ClientPhotoPickerState extends State<ClientPhotoPicker> {
  File? selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) return;

    final file = File(image.path);

    setState(() {
      selectedImage = file;
    });

    widget.onImageSelected?.call(file);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        children: [
          Text(
            'Profile Photo',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF302B20),
            ),
          ),

          SizedBox(height: 14.h),

          Stack(
            children: [
              CircleAvatar(
                radius: 43.r,
                backgroundColor: const Color(0xFFF5EBDD),
                backgroundImage: selectedImage != null
                    ? FileImage(selectedImage!)
                    : (widget.currentImageUrl != null &&
                    widget.currentImageUrl!.isNotEmpty
                    ? NetworkImage(widget.currentImageUrl!)
                    : null),
                child: selectedImage == null &&
                    (widget.currentImageUrl == null ||
                        widget.currentImageUrl!.isEmpty)
                    ? Icon(
                  Icons.person,
                  size: 40.sp,
                  color: Colors.grey,
                )
                    : null,
              ),

              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 29.w,
                    height: 29.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5DD76),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 16.sp,
                      color: const Color(0xFF302B20),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          Text(
            'Tap to change photo',
            style: TextStyle(
              fontSize: 11.sp,
              color: const Color(0xFF817D75),
            ),
          ),
        ],
      ),
    );
  }
}