import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:winchuser/network/remote/Storage_Service.dart';
import 'package:winchuser/screens/colors.dart';
import 'package:winchuser/screens/user_signup/cubit.dart';
import 'package:winchuser/screens/user_signup/common_photo_register.dart';
import 'package:winchuser/screens/user_signup/states.dart';
import '../navigation_bar.dart';
import 'package:flutter/rendering.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late File _image;
  late String _uploadedFileURL;
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var numberController = TextEditingController();

  var em_numberController = TextEditingController();

  var passwordController = TextEditingController();

  var car_modelController = TextEditingController();
  var car_colorController = TextEditingController();
  var image = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future chooseFile() async {
    try {
      await ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
        setState(() {
          _image = image.value as File;
        });
      });
    } on PlatformException catch (e) {
      print('faild to pick');
    }
  }

  Future uploadFile() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child("Commercial" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.then((res) {
      res.ref.getDownloadURL();
    });

    ref.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        print('${_uploadedFileURL}');
      });
    });
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return BlocProvider(
      create: (BuildContext context) => UserSignupCubit(),
      child: BlocConsumer<UserSignupCubit, UserSignupStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const Home();
            }));
          }

          if (state is UserSignupErrorState) {
            return;
          }
        },
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 30, left: 30),
                          child: Row(
                            children: const [
                              Text(
                                "SIGN UP",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 30, left: 30),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Color(0xFF59769E),
                                  ))),
                                  child: TextFormField(
                                    controller: nameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please enter your full name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Full Name",
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Mycolor.teal,
                                        ),
                                        border: InputBorder.none),
                                    keyboardType: TextInputType.text,
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
                                    controller: emailController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please enter your email';
                                      }
                                      onChanged:
                                      (val) {
                                        setState(() => emailController =
                                            val as TextEditingController);
                                      };
                                    },
                                    decoration: InputDecoration(
                                        hintText: "E-mail",
                                        prefixIcon: Icon(
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
                                    controller: numberController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please enter your number';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Number",
                                        prefixIcon: Icon(
                                          Icons.call_rounded,
                                          color: Mycolor.teal,
                                        ),
                                        border: InputBorder.none),
                                    maxLength: 11,
                                    keyboardType: TextInputType.number,
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
                                    controller: em_numberController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please enter emergency number';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        hintText:
                                            "Enter an Emergency Call Number",
                                        prefixIcon: Icon(
                                          Icons.call_rounded,
                                          color: Mycolor.teal,
                                        ),
                                        border: InputBorder.none),
                                    maxLength: 11,
                                    keyboardType: TextInputType.number,
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
                                      if (value.length < 6) {
                                        return 'The password you entered is less than 6 characters';
                                      }
                                      onChanged:
                                      (val) {
                                        setState(() => passwordController =
                                            val as TextEditingController);
                                      };
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
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Mycolor.teal,
                                        ),
                                        border: InputBorder.none),
                                    keyboardType: TextInputType.visiblePassword,
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
                                    controller: car_modelController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please enter your car/s model';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Car's model",
                                        prefixIcon: Icon(
                                          Icons.directions_car_rounded,
                                        ),
                                        border: InputBorder.none),
                                    keyboardType: TextInputType.text,
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
                                    controller: car_colorController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please enter your car/s color';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Car's color",
                                        prefixIcon: Icon(
                                          Icons.directions_car_rounded,
                                          color: Mycolor.teal,
                                        ),
                                        border: InputBorder.none),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15),
                                  width: 270,
                                  child: buildButton(
                                    title: 'Driving license photo',
                                    icon: Icons.image_outlined,
                                    prefixIcon: Mycolor.teal,
                                    onClicked: () async {
                                      final results =
                                          await FilePicker.platform.pickFiles(
                                        allowMultiple: false,
                                        type: FileType.custom,
                                        allowedExtensions: ['png', 'jpg'],
                                      );
                                      if (results == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('No file selected'),
                                          ),
                                        );
                                        return null;
                                      }
                                      final path = results.files.single.path!;
                                      final fileName =
                                          results.files.single.name;
                                      storage
                                          .uploadFile(path, fileName)
                                          .then((value) => print('Done'));
                                      print(path);
                                      print(fileName);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ConditionalBuilder(
                          condition: state is! UserSignupLoadingState,
                          builder: (context) => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Mycolor.red,
                                fixedSize: const Size(300, 43),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  UserSignupCubit.get(context).userSignup(
                                    email: emailController.text,
                                    name: nameController.text,
                                    number: numberController.text,
                                    em_number: em_numberController.text,
                                    password: passwordController.text,
                                    car_color: car_colorController.text,
                                    car_model: car_modelController.text,
                                    image: image.text,
                                  );
                                }
                                // AppSettings.openLocationSettings();
                                //  return Signup2();
                              },
                              child: const Text('Sign up',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ))),
                          fallback: (context) => CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    ); //this the widget that contain body and appbar
  }
}
