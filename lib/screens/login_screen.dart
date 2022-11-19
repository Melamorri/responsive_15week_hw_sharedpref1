import 'package:flutter/material.dart';
import 'package:flutter_lesson_13/screens/reristration_screen.dart';
import 'package:flutter_lesson_13/screens/user_profile.dart';
import 'package:flutter_lesson_13/widget/input_decoration.dart';
import 'package:flutter_lesson_13/widget/text_button_class.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String username = '';
  String password = '';

  bool _obscureText = true;
  bool _isChecked = false;

  Future getValidation(String name, String pass) async {
    bool getVal = false;
    final SharedPreferences storage = await SharedPreferences.getInstance();
    if ((storage.getString('name_key') == name &&
        storage.getString('password_key') == pass)) {
      getVal = true;
      Get.offAll(
        () => const UserProfile(),
      );
      Fluttertoast.showToast(
          fontSize: 22.sp,
          msg: 'Login Successful',
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white);
    } else {
      getVal = false;
      Fluttertoast.showToast(
          fontSize: 22.sp,
          msg: 'Login Invalid',
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white);
    }
    return getVal;
  }

  Future<void> remember(bool isChecked) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setBool('isChecked', isChecked);
  }

  Future<void> rememberFields() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    bool getValidation = storage.getBool('isChecked') ?? false;
    if (getValidation == true) {
      setState(() {});
      // nameController =
      //     TextEditingController(text: storage.getString('name_key'));
      passwordController =
          TextEditingController(text: storage.getString('password_key'));
      _isChecked = true;
    }
  }

  @override
  void initState() {
    super.initState();
    rememberFields();
  }

  @override
  Widget build(BuildContext context) {
    return SizerUtil.orientation == Orientation.portrait
        ? _widPortrait()
        : _widLandScape();
  }

  Widget _widPortrait() {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextHello(),
                  _buildSpacer(6.h),
                  _buildLoginForm(),
                  _buildSpacer(1.h),
                  _buildRememberMeCheckBox(),
                  _buildSpacer(3.h),
                  _buildTextButton(),
                  _buildSpacer(3.h),
                  _buildTextRegister(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _widLandScape() {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Center(child: _buildTextHello()),
                _buildSpacer(6.h),
                _buildLoginForm(),
                _buildSpacer(1.h),
                _buildRememberMeCheckBox(),
                _buildSpacer(3.h),
                _buildTextButton(),
                _buildSpacer(3.h),
                _buildTextRegister(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextHello() {
    return Column(
      children: [
        Text(
          'Hello',
          style: TextStyle(
              fontSize: 40.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black45),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Sign in to your account',
            style: TextStyle(fontSize: 15.sp, color: Colors.black45),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          style: TextStyle(fontSize: 13.sp),
          decoration: inputDecorationForm(
              FittedBox(
                child: Text(
                  'Login',
                  // style: TextStyle(fontSize: 8.sp),
                ),
              ),
              prefixIcon: Icon(
                Icons.mail,
                size: 3.h,
              )),
          onChanged: (value) {
            username = value;
          },
          validator: (value) {
            if (value!.isEmpty) return 'Please enter your username';
            return null;
          },
        ),
        _buildSpacer(2.h),
        TextFormField(
          controller: passwordController,
          obscureText: _obscureText,
          style: TextStyle(fontSize: 13.sp),
          decoration: inputDecorationForm(
            const FittedBox(
              child: Text(
                'Password',
              ),
            ),
            prefixIcon: Icon(
              Icons.vpn_key,
              size: 3.h,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                size: 3.h,
              ),
            ),
          ),
          onChanged: (value) {
            password = value;
          },
          validator: (value) {
            if (value!.isEmpty) return 'Please enter your password';
            return null;
          },
        ),
        _buildSpacer(1.h),
      ],
    );
  }

  Widget _buildRememberMeCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Remember password',
          style: TextStyle(fontSize: 11.sp),
        ),
        Checkbox(
            value: _isChecked,
            onChanged: (value) {
              setState(() {
                _isChecked = value!;
              });
            })
      ],
    );
  }

  Widget _buildTextButton() {
    return TextButtonClass(
      title: 'Login',
      function: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            getValidation(nameController.text, passwordController.text)
                .then((value) {
              if (value == true) {
                remember(_isChecked);
                Get.offAll(() => const UserProfile());
              } else {
                Get.offAll(() => const RegistrationScreen());
              }
            });
          });
        }
      },
    );
  }

  Widget _buildTextRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Do not have an Account?',
          style: TextStyle(fontSize: 12.sp),
        ),
        GestureDetector(
          onTap: () {
            Get.offAll(() => const RegistrationScreen());
          },
          child: Text(
            '  Register Here',
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp),
          ),
        )
      ],
    );
  }
}

Widget _buildSpacer(double space) {
  return SizedBox(
    height: space,
  );
}
