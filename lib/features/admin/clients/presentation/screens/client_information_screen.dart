
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/clients_cubit.dart';
import '../widgets/client_personal_info.dart';
import '../widgets/danger_zone_card.dart';
import '../widgets/client_delete_dialog.dart';

class ClientInformationScreen extends StatefulWidget {
  final String clientId;
  final String name;
  final String email;
  final String phone;
  final String city;
  final String imageUrl;

  const ClientInformationScreen({
    super.key,
    required this.clientId,
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
    required this.imageUrl,
  });

  @override
  State<ClientInformationScreen> createState() =>
      _ClientInformationScreenState();
}

class _ClientInformationScreenState extends State<ClientInformationScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController cityController;

  bool isDeleting = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    cityController = TextEditingController(text: widget.city);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => ClientDeleteDialog(
        onConfirm: _deleteClient,
      ),
    );
  }

  Future<void> _deleteClient() async {
    final cubit = context.read<ClientsCubit>();
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    setState(() {
      isDeleting = true;
    });

    try {
      await cubit.deleteClient(clientId: widget.clientId);

      if (!mounted) return;

      // Return to ClientsScreen, passing ClientDetailsScreen.
      navigator.pop();
      navigator.pop();

      messenger.showSnackBar(
        const SnackBar(
          content: Text('Client account deleted successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isDeleting = false;
      });

      messenger.showSnackBar(
        SnackBar(
          content: Text('Failed to delete client: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFFFFAF6);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(18.w, 20.h, 18.w, 15.h),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Client Information',
                        style: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF302B20),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(18.w, 5.h, 18.w, 25.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'View client personal details and contact information.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),

                        SizedBox(height: 25.h),

                        Container(
                          padding: EdgeInsets.all(18.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 42.r,
                                backgroundColor: const Color(0xFFF3EBDD),
                                child: Icon(
                                  Icons.person,
                                  size: 42.sp,
                                  color: Colors.grey,
                                ),
                              ),

                              SizedBox(width: 18.w),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.name,
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF302B20),
                                      ),
                                    ),

                                    SizedBox(height: 5.h),

                                    Text(
                                      'Client ID: ${widget.clientId}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 22.h),

                        IgnorePointer(
                          child: ClientPersonalInfo(
                            nameController: nameController,
                            emailController: emailController,
                            phoneController: phoneController,
                            cityController: cityController,
                            onCityTap: () {},
                          ),
                        ),

                        SizedBox(height: 44.h),

                        DangerZoneCard(
                          onDelete: _showDeleteDialog,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            if (isDeleting)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.25),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
