import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:mcloud/screens/mCDashboardScreen.dart';
import 'package:mcloud/screens/mCSignUpScreen.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Constants.dart';
import 'package:mcloud/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:convert';

class SignInScreen extends StatefulWidget {
  static String tag = '/SignInScreen';

  const SignInScreen({super.key});

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  Future<void> _login(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('https://82.137.205.221/index.php/login'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'user': email,
        'password': password,
        'timezone-offset': '0',
        'timezone': 'UTC',
        'requesttoken': 'KhV+LCtlLFYmfjh5UScBJBclJyRTLXkMZl1cRh1xIUI=:pc4YS+d7PNLL2QKMUOWAaj641dsiL7U+Z6J4/A9j7t4='
      },
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      var responseBody = response.body;
      if (responseBody.contains("success_indicator")) {
        DashboardScreen().launch(context);
      } else {
        // Handle login failure
        toast("${response.statusCode}");
        toast("Login failed. Please try again.");
      }
    } else {
      // Handle server error
      toast("${response.statusCode}");
      toast("Server error. Please try again later.");
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSCommonAppBar(context, title: "Sign in to $AppName"),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter email address";
                        } else if (!val.validateEmail()) {
                          return "Please enter valid email address";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: buildInputDecoration("Email"),
                    ),
                    20.height,
                    TextFormField(
                      controller: _passwordController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: buildInputDecoration("Password"),
                    ),
                    20.height,
                    authButtonWidget("Sign In").onTap(() {
                      if (_formKey.currentState!.validate()) {
                        _login(_emailController.text, _passwordController.text);
                      }
                    }),
                    15.height,
                    googleSignInWidget(),
                    15.height,
                    appleSignInWidget(),
                    20.height,
                    TextButton(
                      onPressed: () {
                        const SignUpScreen().launch(context);
                      },
                      child: Text(
                        "Sign up for mCloud",
                        style: boldTextStyle(
                          size: 17,
                          color: CSDarkBlueColor,
                        ),
                      ),
                    ),
                    20.height,
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Having trouble signing in?",
                        style: boldTextStyle(
                          size: 17,
                          color: CSDarkBlueColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: SpinKitCircle(
                color: Colors.blue,
                size: 50.0,
              ),
            ),
        ],
      ),
    );
  }

  InputDecoration buildInputDecoration(String labelText) {
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.black),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: Colors.black, width: 1.5),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: CSGreyColor,
        ),
        borderRadius: BorderRadius.zero,
      ),
    );
  }
}
