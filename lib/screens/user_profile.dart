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
            const SizedBox(height: 20),
            Stack(
              children: const [
                CircleAvatar(
                  radius: 93,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://phonoteka.org/uploads/posts/2021-05/1621965253_31-phonoteka_org-p-kotiki-art-krasivo-32.jpg'),
                    radius: 90,
                  ),
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25,
                    child: Icon(
                      Icons.create_rounded,
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: TextEditingController(text: name),
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Name',
                  suffixIcon: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: TextEditingController(text: eMail),
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'E-mail',
                  suffixIcon: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: TextEditingController(),
                maxLines: 5,
                style: const TextStyle(fontSize: 20),
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
              ),
            ),
            const SizedBox(height: 30),
            // ListTile(
            //   leading: Text('Name: $name'),
            //   shape: const Border(
            //     bottom: BorderSide(),
            //   ),
            //   trailing: const Icon(Icons.arrow_forward_ios),
            // ),
            // Text.rich(
            //   textAlign: TextAlign.left,
            //   TextSpan(
            //     text: 'Name:    ',
            //     style: const TextStyle(fontSize: 35),
            //     children: <TextSpan>[
            //       TextSpan(
            //         text: '$name',
            //         style: const TextStyle(
            //           decoration: TextDecoration.underline,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
}
