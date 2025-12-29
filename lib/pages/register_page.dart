import 'package:d_button/d_button.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:dilaundry/config/app_assets.dart';
import 'package:dilaundry/config/app_colors.dart';
import 'package:dilaundry/config/app_constants.dart';
import 'package:dilaundry/config/app_response.dart';
import 'package:dilaundry/config/failure.dart';
import 'package:dilaundry/datasources/user_datasource.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final edtUsername = TextEditingController();
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void executeRegister() {
    // Validasi input
    bool validInput = formKey.currentState!.validate();
    if (!validInput) return;

    UserDatasource.register(
      edtUsername.text,
      edtEmail.text,
      edtPassword.text,
    ).then((result) {
      String newStatus = '';
      result.fold(
        (failure) {
          switch (failure.runtimeType) {
            case ServerFailure _:
              newStatus = 'Server Error';
              Fluttertoast.showToast(
                msg: newStatus,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
              break;
            case NotFoundFailure _:
              newStatus = 'Resource Not Found';
              Fluttertoast.showToast(
                msg: newStatus,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
              break;
            case ForbiddenFailure _:
              newStatus = 'Access Forbidden';
              Fluttertoast.showToast(
                msg: newStatus,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
              break;
            case BadRequestFailure _:
              newStatus = 'Bad Request';
              Fluttertoast.showToast(
                msg: newStatus,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
              break;
            case InvalidInputFailure _:
              newStatus = 'Invalid Input: ${failure.message}';
              AppResponse.invalidInput(context, newStatus);
              break;
            default:
              newStatus = 'Unexpected Error';
              Fluttertoast.showToast(
                msg: newStatus,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
              newStatus = failure.message;
              break;
          }
        },
        (data) {
          Fluttertoast.showToast(
            msg: 'Register Successful',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          Navigator.pop(context);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppAssets.bgAuth, fit: BoxFit.cover),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black54],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        AppConstants.appName,
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          color: Colors.green[900],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        height: 5,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(200),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // Instrinsict Height di dalam
                        // column agar Row bisa mengisi tinggi sesuai konten yang
                        // lain di dalam column
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Material(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              DView.width(10),
                              Expanded(
                                child: DInput(
                                  controller: edtUsername,
                                  fillColor: Colors.white70,
                                  hint: 'Username',
                                  radius: BorderRadius.circular(10),
                                  validator: (input) =>
                                      input == '' ? "Don't empty" : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DView.height(16),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Material(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Icon(
                                    Icons.email,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              DView.width(10),
                              Expanded(
                                child: DInput(
                                  controller: edtEmail,
                                  fillColor: Colors.white70,
                                  hint: 'Email',
                                  radius: BorderRadius.circular(10),
                                  validator: (input) =>
                                      input == '' ? "Don't empty" : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DView.height(16),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Material(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Icon(
                                    Icons.key,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              DView.width(10),
                              Expanded(
                                child: DInputPassword(
                                  controller: edtPassword,
                                  fillColor: Colors.white70,
                                  hint: 'Password',
                                  radius: BorderRadius.circular(10),
                                  validator: (input) =>
                                      input == '' ? "Don't empty" : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DView.height(16),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: DButtonFlat(
                                  onClick: () {},
                                  padding: const EdgeInsets.all(0),
                                  radius: 10,
                                  mainColor: Colors.white70,
                                  child: const Text(
                                    'LOG',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DView.width(10),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => executeRegister(),
                                  style: const ButtonStyle(
                                    alignment: Alignment.centerLeft,
                                  ),
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
