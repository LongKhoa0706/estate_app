import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/repositories/provider/auth_provider.dart';
import 'package:estate_app/src/service/share_pref.dart';
import 'package:estate_app/src/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';


class AuthRepositories{
  AuthProvider _authProvider = AuthProvider();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String veriID;
  String phonee;

  Future<void> verifyCode(String otp) async {
    var a =  await PhoneAuthProvider.credential(
        verificationId: veriID,
        smsCode: otp);
    await firebaseAuth.signInWithCredential(a);
  }

  Future<void> checkPhonee(String phone,String email) async{
    final authResponse = await _authProvider.checkPhone(phone,email);

    if (authResponse.data['code'] == 200) {

       phonee = phone.substring(1,10);
      final formattedNumber = FlutterLibphonenumber()
          .formatNumberSync(
          "+84"+phonee);

      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
        print("autoRetrieve  $verId");
      };
      final PhoneCodeSent smsCodeSent= (String verId, [int forceCodeResent]) {
        veriID = verId;
        print(veriID);
      };
      final PhoneVerificationCompleted verifiedSuccess= (AuthCredential auth){};
      final PhoneVerificationFailed verifyFailed= (FirebaseAuthException e){
        print("LOIII   ${e.message}");
      };
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: formattedNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted : verifiedSuccess,
        verificationFailed: verifyFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve,
      );

    } else {

    }
    return authResponse;
  }

  Future<void> start() async {
    final formattedNumber = FlutterLibphonenumber()
        .formatNumberSync(
        "+84"+phonee);

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      print("autoRetrieve  $verId");
    };
    final PhoneCodeSent smsCodeSent= (String verId, [int forceCodeResent]) {
      veriID = verId;
      print("HAHAHA"+veriID);
    };
    final PhoneVerificationCompleted verifiedSuccess= (AuthCredential auth){};
    final PhoneVerificationFailed verifyFailed= (FirebaseAuthException e){
      print("LOIII   ${e.message}");
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: formattedNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted : verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );

  }

  Future<void> verfiyPhone(String phone,String email) async{
    await checkPhonee(phone,email);

  }

  Future<void> sendCodeToEmail(String email) async {
    final authResponse = await _authProvider.sendCodeToEmail(email);
    return authResponse;
  }
  Future<void> verifyCodeEmail(String email,String code) async {
    final authResponde = await _authProvider.verifyCodeEmail(email, code);
    print(authResponde.data);
    return authResponde;
  }

  Future<void> registerUser(Users user) async {
    final authResponse = await _authProvider.registerUser(user);
    return authResponse;
  }


  Future<void> loginUser({@required String username,@required String passwords} ) async {
    final authResponse = await _authProvider.loginUser(username, passwords);
    print(authResponse.data['status']);

    if (authResponse.data['status'] = true) {
      String token = authResponse.data['token'];
      int idUser = authResponse.data['userID'];
      await SharedPrefService.setString(key: Constant.KEY_TOKEN,value: token);
      await SharedPrefService.setInt(key: Constant.KEY_IDUSER,value: idUser);
      return authResponse;
    }
  }
  Future<void> logoutUser() async {
    final authResponse = await _authProvider.logoutUser();
    return authResponse;
  }

}