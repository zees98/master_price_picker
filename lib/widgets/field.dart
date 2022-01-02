import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:master_price_picker/theme/colors.dart';

class Field extends StatelessWidget {
  const Field({
    Key key,
    this.hinttext,
    this.onchanged,
    this.type,
    this.registerFormKey,
    this.formatter,
    this.maxline,
    this.leadingText,
    this.color,
    this.textColor,
    this.keyboard, this.maxlength,
  }) : super(key: key);

  final hinttext;
  final type;
  final onchanged;
  final color;
  final textColor;
  final maxline;
  final keyboard;
  final formatter;
  final registerFormKey;
  final leadingText;
  final maxlength ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 24, right: 24, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: compColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 10,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            //height: 40,
            child: Center(
              child: TextFormField(
                
                maxLength: (maxlength == null) ? 30 : maxlength,
                keyboardType: keyboard,
                maxLines: (maxline == null) ? 1 : maxline,
                obscureText: type,
                onChanged: onchanged,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'WorkSans',
                ),
                cursorColor: Color(0xFF4FBE9F),
                decoration: new InputDecoration(
                  counterText: "",
                  suffix: Text(
                    leadingText,
                    style: GoogleFonts.abel(),
                  ),
                  border: InputBorder.none,
                  hintText: hinttext,
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FieldIcon extends StatelessWidget {
  const FieldIcon({
    Key key,
    this.hinttext,
    this.onchanged,
    this.type,
    this.registerFormKey,
    this.formatter,
    this.maxline,
    this.sideIcon,
    this.keyboardType,
  }) : super(key: key);

  final hinttext;
  final type;
  final onchanged;
  final maxline;
  final formatter;
  final registerFormKey;
  final Icon sideIcon;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 24, right: 24, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            //height: 40,
            child: Center(
              child: TextFormField(
                keyboardType: keyboardType,
                maxLines: (maxline == null) ? 1 : maxline,
                obscureText: type,
                onChanged: onchanged,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'WorkSans',
                ),
                cursorColor: Color(0xFF4FBE9F),
                decoration: new InputDecoration(
                  icon: sideIcon,
                  border: InputBorder.none,
                  hintText: hinttext,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
