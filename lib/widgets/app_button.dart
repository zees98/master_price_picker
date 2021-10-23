
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key key,
    this.text,
    this.color,
    this.onpressed, this.textColor,
  }) : super(key: key);
  final text;
  final color;
  final textColor;
  final onpressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(       
        width: 200.w,
        height: 40.h,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(200.0), right: Radius.circular(200.0))),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 10),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.ptSans(fontSize: 16,
                  fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
        ),
      ),
      onTap: onpressed,
    );
  }
}
