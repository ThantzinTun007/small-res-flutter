import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:small_res/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';

  Future<void> login(String email, String password) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final url = Uri.parse('http://localhost:8080/api/res/logIn');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);

        // Save token or perform any required action
        final token = responseData['token'];
        // Store the token securely in the app

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const HomeScreen())); // Navigate to home screen
      } else {
        setState(() {
          errorMessage = 'Invalid email or password';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred. Please try again.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 226, 84),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),

                      //box Color
                      color: Color.fromARGB(255, 234, 224, 224),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                      ]),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          // onSaved: ,
                          validator: (input) => !input!.contains("@")
                              ? "Email should be Valid"
                              : null,
                          decoration: const InputDecoration(
                            hintText: "Email address",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(128, 10, 10, 9)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 8, 8, 7)),
                            ),
                            prefixIcon: Icon(Icons.email,
                                color: Color.fromARGB(255, 228, 216, 48)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          // onSaved: ,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(128, 10, 10, 9)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 8, 8, 7)),
                            ),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Color.fromARGB(255, 228, 216, 48),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: const Color.fromARGB(255, 29, 29, 27),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextButton(
                          onPressed: () {
                            login(
                                emailController.text, passwordController.text);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
