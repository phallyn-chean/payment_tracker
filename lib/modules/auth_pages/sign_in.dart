import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracker_payment/modules/screens/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Future<String?>? _authenticateUsers(LoginData data) {
    print("authenticate users");
    return Future.delayed(const Duration(seconds: 1)).then((value) => null);
  }

  Future<String?>? _onRecoverPassword(String name) {
    print("OnRecoverPassword");
    return Future.delayed(const Duration(seconds: 1)).then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    const inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10),
      top: Radius.circular(20),
    );
    return FlutterLogin(
      onLogin: _authenticateUsers,
      onRecoverPassword: _onRecoverPassword,
      title: 'MMAS',
      logo: 'assets/images/splash_screen.png',
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return const Home();
          },
        ));
      },
      messages: LoginMessages(
        userHint: 'User',
        passwordHint: 'Pass',
        confirmPasswordHint: 'Confirm',
        loginButton: 'LOG IN',
        signupButton: 'Register',
        forgotPasswordButton: 'Forgot huh?',
        recoverPasswordButton: 'HELP Me',
        goBackButton: 'GO BACK',
        confirmPasswordError: 'Not match!',
        recoverPasswordDescription: 'recoverPasswordDescription',
        recoverPasswordSuccess: 'Password rescued Successfully',
      ),
      loginProviders: <LoginProvider>[
        LoginProvider(
            icon: FontAwesomeIcons.google,
            label: 'Google',
            callback: () async {
              print("start google sign in");
              await Future.delayed(const Duration(seconds: 1));
              print("stop google sign in");
              return null;
            }),
        LoginProvider(
            icon: FontAwesomeIcons.facebookF,
            label: 'Facebook',
            callback: () async {
              print("start facebook sign in");
              await Future.delayed(const Duration(seconds: 1));
              print("stop facebook sign in");
              return null;
            }),
        LoginProvider(
            icon: FontAwesomeIcons.linkedinIn,
            callback: () async {
              print("start linkin sign in");
              await Future.delayed(const Duration(seconds: 1));
              print("stop linkin sign in");
              return null;
            }),
        LoginProvider(
            icon: FontAwesomeIcons.githubAlt,
            callback: () async {
              print("start github sign in");
              await Future.delayed(const Duration(seconds: 1));
              print("stop github sign in");
              return null;
            })
      ],
      theme: LoginTheme(
        primaryColor: Colors.teal,
        accentColor: Colors.yellow,
        errorColor: Colors.deepOrange,
        titleStyle: const TextStyle(
          color: Colors.greenAccent,
          fontFamily: "Quicksand",
          letterSpacing: 4,
        ),
        bodyStyle: const TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
        textFieldStyle: const TextStyle(fontStyle: FontStyle.italic, color: Colors.orange, shadows: [
          Shadow(color: Colors.yellow, blurRadius: 2),
        ]),
        buttonStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.yellow,
        ),
        cardTheme: CardTheme(
          color: Colors.yellow.shade100,
          elevation: 5,
          margin: const EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.purple.withOpacity(0.1),
          contentPadding: EdgeInsets.zero,
          errorStyle: const TextStyle(
            backgroundColor: Colors.orange,
            color: Colors.white,
          ),
          labelStyle: const TextStyle(fontSize: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
            borderRadius: inputBorder,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderRadius: inputBorder,
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
            borderRadius: inputBorder,
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.purple,
          backgroundColor: Colors.pinkAccent,
          highlightColor: Colors.lightGreen,
          elevation: 9,
          highlightElevation: 6,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      // onSignup: _authenticateUsers,
    );
  }
}
