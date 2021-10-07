import 'package:ages_app/Auths/components/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:ages_app/Module/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged ;
  final String text;
  final TextEditingController controller ;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.text,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      key: new Key("pwField"),
      child : TextField(
        obscureText: true,
        controller : controller,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: text,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
