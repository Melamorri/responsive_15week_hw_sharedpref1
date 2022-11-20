import 'package:flutter/material.dart';
import 'package:flutter_lesson_13/screens/user_profile.dart';
import 'package:flutter_lesson_13/widget/input_decoration.dart';
import 'package:flutter_lesson_13/widget/text_button_class.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKeyKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String eMail = '';

  //записываем данные в память при регистрации
  Future<void> register(String name, String pass, String email) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('name_key', name);
    storage.setString('password_key', pass);
    storage.setString('email', email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKeyKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child: Column(children: [
              _buildSpacer(2.h),
              _buildAvatar(),
              _buildSpacer(2.h),
              _buildTextFiledName(),
              _buildSpacer(1.h),
              _buildTextFiledEmail(),
              _buildSpacer(1.h),
              _buildTextFiledPassword(),
              _buildTextButton(),
              _buildSpacer(2.h),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Center(
      child: CircleAvatar(
        radius: 7.h,
        child: Icon(
          Icons.person_outline,
          size: 4.h,
        ),
      ),
    );
  }

  Widget _buildTextFiledName() {
    return TextFormField(
      style: TextStyle(fontSize: 12.sp),
      decoration: inputDecorationForm(
        Text('Your name', style: TextStyle(fontSize: 12.sp)),
      ),
      validator: (value) {
        if (value!.isEmpty) return 'Enter your name';
        return null;
      },
      onChanged: (value) {
        username = value;
      },
    );
  }

  Widget _buildTextFiledEmail() {
    return TextFormField(
      style: TextStyle(fontSize: 12.sp),
      keyboardType: TextInputType.emailAddress,
      decoration: inputDecorationForm(
        Text('E-mail', style: TextStyle(fontSize: 12.sp)),
      ),
      validator: (value) {
        if (value!.isEmpty) return 'Enter your E-mail';
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) return 'Enter a valid E-mail';
        return null;
      },
      onChanged: (value) {
        eMail = value;
      },
    );
  }

  Widget _buildTextFiledPassword() {
    final passwordFieldKey = GlobalKey<FormFieldState<String>>();
    return Column(
      children: [
        TextFormField(
          style: TextStyle(fontSize: 13.sp),
          obscureText: true,
          key: passwordFieldKey,
          decoration: inputDecorationForm(
            Text('Password', style: TextStyle(fontSize: 12.sp)),
          ),
          validator: (value) {
            if (value!.isEmpty) return 'Enter your password';
            if (value.length < 2) return 'The password is too short';
            return null;
          },
          onChanged: (value) {
            password = value;
          },
        ),
        _buildSpacer(1.h),
        TextFormField(
          style: TextStyle(fontSize: 12.sp),
          obscureText: true,
          decoration: inputDecorationForm(
            Text('Repeat password', style: TextStyle(fontSize: 12.sp)),
          ),
          validator: (value) {
            if (value != passwordFieldKey.currentState!.value) {
              return 'Password does not match';
            }
            return null;
          },
        ),
        _buildSpacer(2.h),
      ],
    );
  }

  Widget _buildTextButton() {
    return TextButtonClass(
        title: 'Register',
        function: () {
          if (_formKeyKey.currentState!.validate()) {
            setState(() {
              register(username, password, eMail);
              Get.offAll(
                () => const UserProfile(),
              );
            });
          }
        });
  }
}

Widget _buildSpacer(double space) {
  return SizedBox(
    height: space,
  );
}
