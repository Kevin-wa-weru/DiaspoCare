import 'package:diasporacare/screens/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:diasporacare/constants.dart';
import 'package:diasporacare/services/misc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hideTopBanner = false;
  bool keyboardVisible = false;
  bool emailhasIssue = false;
  bool fullNameshasIsuue = false;
  bool passwordHasIssue = false;
  bool showPassword = true;
  bool emailIsValid = true;

  @override
  Widget build(BuildContext context) {
    keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: SvgPicture.asset(
                        'assets/images/logo.svg',
                        // fit: BoxFit.contain
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Welcome Back !',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Container(
                        height: fullNameshasIsuue &&
                                emailhasIssue &&
                                passwordHasIssue
                            ? 400
                            : 370,
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width - 40,
                        child: Column(
                          children: [
                            TextFormField(
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'AvenirNext',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                suffixText: emailIsValid ? '' : 'Invalid email',
                                suffixStyle: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: Colors.black12, width: 0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: emailhasIssue
                                          ? Colors.red
                                          : textFieldBorder,
                                      width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: textFieldBorder, width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                filled: true,
                                hintText: 'Email Address',
                                hintStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'AvenirNext',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onChanged: (value) {
                                if (Misc.validateEmail(emailController.text) !=
                                    null) {
                                  setState(() {
                                    emailIsValid = false;
                                  });
                                } else {
                                  setState(() {
                                    emailIsValid = true;
                                  });
                                }
                              },
                              controller: emailController,
                            ),
                            emailhasIssue
                                ? Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          'Please enter your Email',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'AvenirNext'),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: showPassword,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'AvenirNext',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  child: !showPassword
                                      ? const Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                ),
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: Colors.black12, width: 0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: passwordHasIssue
                                          ? Colors.red
                                          : textFieldBorder,
                                      width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: textFieldBorder, width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                filled: true,
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'AvenirNext',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                              controller: passwordController,
                            ),
                            passwordHasIssue
                                ? Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          'Please enter a password',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'AvenirNext'),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            const SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 2.0),
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        color: secondaryColor,
                                        fontFamily: 'AvenirNext',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                if (emailController.text.isEmpty) {
                                  setState(() {
                                    emailhasIssue = true;
                                  });
                                } else {
                                  setState(() {
                                    emailhasIssue = false;
                                  });
                                }

                                if (passwordController.text.isEmpty) {
                                  setState(() {
                                    passwordHasIssue = true;
                                  });
                                } else {
                                  setState(() {
                                    passwordHasIssue = false;
                                  });
                                }
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width - 40,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Don\'t have an account ?',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Register',
                                    style: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
