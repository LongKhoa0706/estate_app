import 'package:estate_app/src/utils/string.dart';

class Validator {
  String validatorEmail(String email) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (email.isEmpty) {
      return Strings.error.emptyRequiredInput;
    }
     if (!regex.hasMatch(email)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  String validatorUserName(String userName) {

    if (userName.isEmpty) {
      return Strings.error.emptyRequiredInput;
    }
    if (userName.length <= 5 ) {
      return Strings.error.userNameRequiredCharacter;
    }
    return null;
  }

  String validatorEmailLogin(String email) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (email.isEmpty) {
      return Strings.error.emptyRequiredInput;
    }
    if (email.length <= 5 ) {
      return Strings.error.passwordRequiredCharacter;
    }
    return null;
  }


  String validatorInput(String input) {
    if (input.isEmpty) {
      return Strings.error.emptyRequiredInput;
    }
    return null;
  }

  String validatorPassword(String password) {

    if (password.isEmpty) {
      return Strings.error.emptyRequiredInput;
    }
    if (password.length <= 5 ) {
      return Strings.error.passwordRequiredCharacter;
    }
    return null;
  }
  String validatorPhone(String phone) {
    Pattern pattern =  r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = new RegExp(pattern);
    if (phone.length == 0) {
      return 'Xin vui lòng nhập số điện thoại';
    }
    else if (!regex.hasMatch(phone)) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }
}