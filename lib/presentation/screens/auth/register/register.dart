import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_friday_c9/domain/di/di.dart';
import 'package:e_commerce_friday_c9/presentation/screens/auth/register/register_view_model.dart';
import 'package:e_commerce_friday_c9/presentation/screens/main/main.dart';
import 'package:e_commerce_friday_c9/presentation/utils/base_request_states.dart';
import 'package:e_commerce_friday_c9/presentation/utils/dialog_utils.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/form_label.dart';

class Register extends StatelessWidget {
  static const String routeName = 'register';

  RegisterViewModel registerViewModel = getIt();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is BaseRequestLoadingState) {
          showLoading(context);
        } else if (state is BaseRequestSuccessState) {
          hideLoading(context);
          Navigator.pushNamed(context, Main.routeName);
        } else if (state is BaseRequestErrorState) {
          hideLoading(context);
          showErrorDialog(context, state.message);
        }
      },
      bloc: registerViewModel,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Image.asset(
              'assets/images/splash.png',
              height: 71,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: registerViewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FormLabelWidget(label: 'Full Name'),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextFormField(
                            hintText: 'enter your full name',
                            controller: registerViewModel.nameController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please enter full name';
                              }
                              return null;
                            },
                            type: TextInputType.name),
                        const SizedBox(
                          height: 28,
                        ),
                        FormLabelWidget(label: 'Email Address'),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextFormField(
                            hintText: 'enter your email address',
                            controller: registerViewModel.emailController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please enter email';
                              }
                              var emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(text);
                              if (!emailValid) {
                                return 'email format not valid';
                              }

                              return null;
                            },
                            type: TextInputType.emailAddress),
                        const SizedBox(
                          height: 28,
                        ),
                        FormLabelWidget(label: 'Mobile Number'),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextFormField(
                            hintText: 'enter your mobile number',
                            controller: registerViewModel.phoneController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please enter mobile number';
                              }
                              if (text.trim().length < 10) {
                                return 'Phone number should be at least 10 numbers.';
                              }
                              return null;
                            },
                            type: TextInputType.phone),
                        const SizedBox(
                          height: 28,
                        ),
                        FormLabelWidget(label: 'Password'),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextFormField(
                          hintText: 'enter your password',
                          controller: registerViewModel.passwordController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter password ';
                            }
                            if (text.length < 6) {
                              return 'Phone number should be at least 6 chrs.';
                            }
                            return null;
                          },
                          type: TextInputType.visiblePassword,
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        FormLabelWidget(label: 'Password Confirmation'),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextFormField(
                          hintText: 're-enter your password confirmation',
                          controller: registerViewModel.rePasswordController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please re-enter password ';
                            }
                            if (text !=
                                registerViewModel.rePasswordController.text) {
                              return "Password doesn't match.";
                            }
                            return null;
                          },
                          type: TextInputType.visiblePassword,
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 56,
                        ),
                        CustomButtonWidget(
                            title: 'Sign Up',
                            onPressed: () {
                              registerViewModel.register();
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}