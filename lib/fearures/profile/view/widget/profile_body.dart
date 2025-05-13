import 'package:angelinashop/core/helper/navigation_helper.dart';
import 'package:angelinashop/core/styles/image_app.dart';
import 'package:angelinashop/fearures/profile/view/widget/profile_photo_bottom_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/local_storage_helper.dart';
import '../screen/order_history_screen.dart';
import 'custom_row_item.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  File? _savedImage;
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    final data = await LocalStorageService.loadUserInfo();
    setState(() {
      userName = data['first_name'];
      userEmail = data['email'];
    });
  }
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(pickedFile.path);
      final savedImage =
          await File(pickedFile.path).copy('${appDir.path}/$fileName');

      setState(() {
        _savedImage = savedImage;
      });
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          CircleAvatar(
            radius: 50.r,
            backgroundImage: _savedImage != null
                ? FileImage(_savedImage!)
                : const AssetImage(ImageApp.bannerPic) as ImageProvider,
          ),
          SizedBox(height: 16.h),
          Text(
            userName??"example",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            userEmail??"email@example.com",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
          SizedBox(height: 24.h),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Choose Profile Photo'),
            onTap: () => showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              builder: (_) => ProfilePhotoBottomSheet(
                onCameraTap: () => _pickImage(ImageSource.camera),
                onGalleryTap: () => _pickImage(ImageSource.gallery),
                onDeleteTap: () {
                  setState(() {
                    _savedImage = null;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
            contentPadding: EdgeInsets.zero,
          ),

          // History of orders
          CustomRowItem(
            leadingIcon: Icons.history,
            text: 'Order History',
            onTap: () {
              NavigationHelper.push(
                context: context,
                destination: const OrderHistoryScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}
