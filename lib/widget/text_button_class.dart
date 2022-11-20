import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_lesson_13/responsive/dimensions.dart';

class TextButtonClass extends StatelessWidget {
  final String title;
  final Function function;
  const TextButtonClass({Key? key, required this.title, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          fixedSize: MaterialStateProperty.all(
            SizerUtil.deviceType == DeviceType.mobile
                ? (Size(90.w, 7.h))
                : (Size(25.w, 6.h)),
          )),
      onPressed: () => function(),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
      ),
    );
  }
}
