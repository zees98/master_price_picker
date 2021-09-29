import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final labelText, onChanged, suffix, prefix;

  const CustomTextField({
    Key key,
    this.labelText,
    this.onChanged,
    this.suffix,
    this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            20,
          )),
      margin: EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20.0,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.9),
                hintText: "Search your products here.",
                // suffix: suffix,
              ),
              onChanged: onChanged,
            ),
          ),
          if (suffix != null)
            Container(
              child: suffix,
            )
        ],
      ),
    );
  }
}
