import 'package:dev_challenge/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

enum AuthMode { signup, login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AuthCard());
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error occured.'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => {Navigator.of(ctx).pop()},
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
            _authData['email'] as String, _authData['password'] as String);
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signUp(
            _authData['email'] as String, _authData['password'] as String);
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication faled.';
      if (error.message.toString().contains('EMAIL_EXITS')) {
        errorMessage = 'This email is already in use.';
      } else if (error.message.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address.';
      } else if (error.message.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'The inputed password is too weak.';
      } else if (error.message.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'The user with this email was not found.';
      } else if (error.message.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid credentials.';
      }

      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              margin: EdgeInsets.only(
                top: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _authMode == AuthMode.login
                            ? 'LOGIN'
                            : 'CREATE YOUR ACCOUNT',
                        style: TextStyle(
                          color: Color(0xff123CAA),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _authMode == AuthMode.login
                            ? 'Payment on the go!'
                            : 'Pay by transfer',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: _authMode == AuthMode.signup ? 379 : 250,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300)),
                                labelText: "Email address",
                                helperStyle:
                                    TextStyle(color: Colors.grey.shade200),
                                helperMaxLines: 1,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.all(10),
                                prefixIcon: Icon(Icons.email_outlined),
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade200),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Invalid email!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['email'] = value as String;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_authMode == AuthMode.signup)
                      Container(
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300)),
                                  labelText: "Phone number",
                                  helperStyle:
                                      TextStyle(color: Colors.grey.shade200),
                                  helperMaxLines: 1,
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10),
                                  prefixIcon: Icon(Icons.phone_outlined),
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade200),
                                ),
                                keyboardType: TextInputType.phone,
                                // validator: (value) {
                                //   if (value!.isEmpty || !value.contains('@')) {
                                //     return 'Invalid email!';
                                //   }
                                //   return null;
                                // },
                                // onSaved: (value) {
                                //   _authData['email'] = value as String;
                                // },
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300)),
                                labelText: "Password",
                                helperStyle:
                                    TextStyle(color: Colors.grey.shade200),
                                helperMaxLines: 1,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.all(10),
                                prefixIcon: Icon(Icons.lock_outline),
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade200),
                              ),
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 5) {
                                  return 'Password is too short!';
                                }
                              },
                              onSaved: (value) {
                                _authData['password'] = value as String;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_authMode == AuthMode.signup)
                      Container(
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: TextFormField(
                                enabled: _authMode == AuthMode.signup,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300)),
                                  labelText: "Confirm password",
                                  helperStyle:
                                      TextStyle(color: Colors.grey.shade200),
                                  helperMaxLines: 1,
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10),
                                  prefixIcon: Icon(Icons.lock_outline),
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade200),
                                ),
                                obscureText: true,
                                // validator: _authMode == AuthMode.signup
                                //     ? (value) {
                                //         if (value != _passwordController.text) {
                                //           return 'Passwords do not match!';
                                //         }
                                //       }
                                //     : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (_authMode == AuthMode.signup)
                      Container(
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: TextFormField(
                                enabled: _authMode == AuthMode.signup,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300)),
                                  labelText: "Referal code (Optional)",
                                  helperStyle:
                                      TextStyle(color: Colors.grey.shade200),
                                  helperMaxLines: 1,
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10),
                                  prefixIcon:
                                      Icon(Icons.account_circle_outlined),
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade200),
                                ),
                                obscureText: true,
                                // validator: _authMode == AuthMode.signup
                                //     ? (value) {
                                //         if (value != _passwordController.text) {
                                //           return 'Passwords do not match!';
                                //         }
                                //       }
                                //     : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(
              child: _isLoading
                  ? Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                style: ButtonStyle(),
                                onPressed: _submit,
                                child: Text(_authMode == AuthMode.login
                                    ? 'LOGIN'
                                    : 'SIGN UP')),
                      ),
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(_authMode == AuthMode.login
                      ? 'Don\'t have an account'
                      : 'Already have an account?'),
                  TextButton(
                    // ignore: sort_child_properties_last
                    child: Text(_authMode == AuthMode.login
                        ? 'Create account'
                        : 'Log In'),
                    onPressed: _switchAuthMode,
                  ),
                ]),
              ),
            ),
            Container(
              width: 350,
              padding: const EdgeInsets.only(
                left: 27,
                right: 27,
                bottom: 8,
                top: 8,
              ),
              // child: Text(
              //     "By tapping signup, you agree to our terms and conditions and privacy policies."),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'By tapping signup, you agree to our'),
                    TextSpan(
                      text: ' terms and conditions',
                      style: TextStyle(
                        color: Color(0xff123CAA),
                      ),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'privacy policies.',
                      style: TextStyle(
                        color: Color(0xff123CAA),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
