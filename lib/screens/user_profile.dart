import 'package:flutter/material.dart';
import 'package:flutter_lesson_13/screens/login_screen.dart';
import 'package:flutter_lesson_13/widget/text_button_class.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String? name;
  String? eMail;
  @override
  void initState() {
    super.initState();
    getLogin();
  }

  Future<void> getLogin() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    setState(() {
      name = storage.getString('name_key');
      eMail = storage.getString('email');
    });
  }

  Future<void> exit() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    storage.remove('name_key');
    storage.remove('password_key');
    storage.remove('isChecked');
    //storage.clear();
  }

  @override
  Widget build(BuildContext context) {
    final orientationPortrait = SizerUtil.orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: const Color(0xFFC3DFF6),
      appBar: AppBar(
        title: Text('Profile  $name'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            Stack(
              children: [
                CircleAvatar(
                  radius: 12.h,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    backgroundImage: const NetworkImage(
                        'https://phonoteka.org/uploads/posts/2021-05/1621965253_31-phonoteka_org-p-kotiki-art-krasivo-32.jpg'),
                    radius: 11.h,
                  ),
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 3.h,
                    child: const Icon(
                      Icons.create_rounded,
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 2.h),

            // неработающий код. как заставить его работать? выдает ошибку, связанную с размерами, при запуске
            // SizerUtil.deviceType == DeviceType.mobile
            //     ? SizedBox(
            //         width: 90.w,
            //         child: Column(
            //           children: [userNameField(), userEmailField()],
            //         ),
            //       )
            //     : SizedBox(
            //         width: 90.w,
            //         child: Row(
            //           children: [userNameField(), userEmailField()],
            //         ),
            //       ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.h),
              child: userNameField(),
            ),
            // SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.h),
              child: userEmailField(),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.h),
              child: userDescriptionField(),
            ),
            SizedBox(height: 4.h),
            TextButtonClass(
              title: 'Exit',
              function: () {
                exit();
                Get.offAll(() => const LoginScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  TextField userDescriptionField() {
    return TextField(
      controller: TextEditingController(),
      maxLines: 5,
      style: TextStyle(fontSize: 16.sp),
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.white,
        filled: true,
        labelText: 'Tell us about yourself',
        suffixIcon: IconButton(
            onPressed: (() {
              setState(() {});
              TextEditingController().clear();
            }),
            icon: const Icon(Icons.close)),
      ),
    );
  }

  Container userEmailField() {
    final orientationPortrait = SizerUtil.orientation == Orientation.portrait;
    return SizerUtil.deviceType == DeviceType.mobile
        ? Container(
            width: orientationPortrait ? 80.w : 70.w,
            child: TextField(
              controller: TextEditingController(text: eMail),
              style: TextStyle(fontSize: 16.sp),
              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true,
                labelText: 'E-mail',
                suffixIcon: Icon(Icons.arrow_forward_ios),
              ),
            ),
          )
        : Container(
            width: orientationPortrait ? 80.w : 70.w,
            child: TextField(
              controller: TextEditingController(text: eMail),
              style: TextStyle(fontSize: 13.sp),
              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true,
                labelText: 'E-mail',
                suffixIcon: Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
  }

  Container userNameField() {
    final orientationPortrait = SizerUtil.orientation == Orientation.portrait;
    return SizerUtil.deviceType == DeviceType.mobile
        ? Container(
            child: TextField(
              controller: TextEditingController(text: name),
              style: TextStyle(fontSize: 16.sp),
              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true,
                labelText: 'Name',
                suffixIcon: Icon(Icons.arrow_forward_ios),
              ),
            ),
          )
        : Container(
            child: TextField(
              controller: TextEditingController(text: name),
              style: TextStyle(fontSize: 13.sp),
              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true,
                labelText: 'Name',
                suffixIcon: Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
  }
}
