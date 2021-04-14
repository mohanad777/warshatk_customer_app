 

import 'package:test/test.dart';
import 'package:warshatkcustomerapp/AllScreens/LoginScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/RegisterScreen.dart';

void main() {
  

  test('No internet connectivity returns error string', () {
    var result = EmailValidator.validateConnection('No internet connectivity!');
    expect(result, equals('No internet connectivity!'));
  });
   test('internet is connected', () {
    var result = EmailValidator.validateConnection('internet');
    expect(result, null);
  });



   test('email or password can not be empty returns error string', () {
    var result = EmailValidator.validateEmailOrPassowrd('email or password can not be empty');
    expect(result, equals('email or password can not be empty'));
  });
   test('email and password are filled', () {
    var result = EmailValidator.validateEmailOrPassowrd('valid');
    expect(result, null);
  });
  //Your email or passowrd is wrong!
  //
  
   test('Your email or passowrd is wrong! returns error string', () {
    var result = EmailValidator.validateEmailAndPassowrd('Your email or passowrd is wrong!');
    expect(result, equals('Your email or passowrd is wrong!'));
  });
   test('email and password are filled', () {
    var result = EmailValidator.validateEmailAndPassowrd('valid');
    expect(result, null);
  });
//
//
//
//
   test('The passowrd shuld\'nt be empty! returns error string', () {
    var result = Validator.validateRegisterationEmptyPassowrd('The passowrd shuld\'nt be empty');
    expect(result, equals('The passowrd shuld\'nt be empty'));
  });
   test('password are filled', () {
    var result = Validator.validateRegisterationEmptyPassowrd('valid');
    expect(result, null);
  });
  

     test('The email shuld\'nt be empty! returns error string', () {
    var result = Validator.validateRegisterationEmptyEmail('The email shuld\'nt be empty');
    expect(result, equals('The email shuld\'nt be empty'));
  });
   test('email are filled', () {
    var result = Validator.validateRegisterationEmptyEmail('valid');
    expect(result, null);
  });

  ///
  ///
    test('The passowrd is too short! returns error string', () {
    var result = Validator.validateRegisterationPassowrdLength('The passowrd is too short');
    expect(result, equals('The passowrd is too short'));
  });
   test('the passowrd length is fine', () {
    var result = Validator.validateRegisterationPassowrdLength('valid');
    expect(result, null);
  });


  ///
    test('The passowrd must contain letters and number returns error string', () {
    var result = Validator.validaPassowrd('The passowrd must contain letters and number');
    expect(result, equals('The passowrd must contain letters and number'));
  });
   test('valida Passowrd', () {
    var result = Validator.validaPassowrd('valid');
    expect(result, null);
  });
}



/*
 
  static String validaPassowrd(String value) {
    return value == 'The passowrd must contain letters and number'
        ? "The passowrd must contain letters and number"
        : null;
  }

  static String validaPassowrd(String value) {
    return value == 'Your email or passowrd is wrong!'
        ? "Your email or passowrd is wrong!"
        : null;
  } */