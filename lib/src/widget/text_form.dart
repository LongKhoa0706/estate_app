import 'package:flutter/material.dart';

import '../utils/const.dart';

class TextForm extends StatelessWidget {
  final String hintText;
  final FormFieldValidator<String> validator;
  final IconData iconData;
  final bool obscure;
  final TextInputType keyBoardType;
  final TextEditingController textEditingController;


  const TextForm({Key key, this.hintText, this.iconData, this.textEditingController, this.validator, this.obscure, this.keyBoardType}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
     
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        validator: validator,
        obscureText: obscure,
        keyboardType: keyBoardType,
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(iconData,size: 16,color: kColorPrimary,),
            border: InputBorder.none,
            hintStyle: TextStyle(
                fontSize: 14
            )
        ),
      ),
    );
  }
}
