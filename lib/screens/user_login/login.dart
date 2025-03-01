import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winchuser/screens/navigation_bar.dart';
import 'package:winchuser/screens/colors.dart';
import 'package:winchuser/screens/forgotpassword.dart';
import 'package:winchuser/screens/user_login/cubit.dart';
import 'package:winchuser/screens/user_login/flutter_toast.dart';
import 'package:winchuser/screens/user_signup/signup.dart';
import 'states.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserLoginCubit(),
      child: BlocConsumer<UserLoginCubit, UserLoginStates>(
        listener: (context, state) {
          if (state is UserLoginErrorState) {
            return showToast2(state.error);
          }
          if (state is UserLoginSuccessState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const Home();
            }));
          }
        },
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Container(
                  alignment: Alignment.center,
                  color: Mycolor.white,
                  child:  SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30, left: 30),
                            child: Row(
                              children: const [
                                Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30, left: 30),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Color(0xFF59769E),
                                    ))),
                                    child: TextFormField(
                                      controller: emailController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'please enter your email';
                                        }
                                      },
                                      decoration: InputDecoration(
                                          hintText: "E-mail",
                                          icon: Icon(
                                            Icons.email,
                                            color: Mycolor.teal,
                                          ),
                                          border: InputBorder.none),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Color(0xFF59769E),
                                    ))),
                                    child: TextFormField(
                                      controller: passwordController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'please enter your password';
                                        }
                                      },
                                      obscureText: _isObscure,
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _isObscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Mycolor.teal,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _isObscure = !_isObscure;
                                              });
                                            },
                                          ),
                                          icon: Icon(
                                            Icons.lock,
                                            color: Mycolor.teal,
                                          ),
                                          border: InputBorder.none),
                                      keyboardType: TextInputType.visiblePassword,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder:
                                                    (BuildContext context) {
                                              return Forgot();
                                            }));
                                          },
                                          child: const Text("Forgot Password?")),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ConditionalBuilder(
                            condition: state is! UserLoginLoadingState,
                            builder: (context) => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Mycolor.red,
                                  fixedSize: const Size(300, 45),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    UserLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }

                                  /* Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const Home();
                                  })); */
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )),
                            fallback: (context) => CircularProgressIndicator(),
                          ),
                          const SizedBox(height: 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return Signup();
                                    }));
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Mycolor.teal,
                                    ),
                                  )),
                            ],
                          ),
                        ]),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
