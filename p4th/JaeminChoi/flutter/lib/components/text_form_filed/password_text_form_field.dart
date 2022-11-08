import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utility/decorations/text_form_decoration.dart';
import '../../utility/decorations/text_style.dart';
import '../../utility/validation/form_validate.dart';
import '../../utility/size.dart';


class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({Key? key , required this.widthSize}) : super(key: key);

  static String password = '';
  final double widthSize;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {

  FocusNode _passwordFocus = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.widthSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: double.infinity,
              child: Text("Password" , style: defaultTextFieldTextStyle(),textAlign: TextAlign.left,)),
          const SizedBox(height: 7,),
          TextFormField(
            decoration: textFormDecoration("Password"),
            obscureText:true,
            keyboardType: TextInputType.visiblePassword,
            focusNode: _passwordFocus,
            autovalidateMode : AutovalidateMode.onUserInteraction ,
            validator: (value) => CheckValidate().validatePassword(_passwordFocus, value!),
            onSaved: (value) {
              setState(()
              {PasswordTextFormField.password = value!;}
              );
            },
          )
        ],
      ),
    );
  }
}
