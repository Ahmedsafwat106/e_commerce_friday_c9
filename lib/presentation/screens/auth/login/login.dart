import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_friday_c9/domain/di/di.dart';
import 'package:e_commerce_friday_c9/presentation/screens/auth/login/login_view_model.dart';
import 'package:e_commerce_friday_c9/presentation/screens/auth/register/register.dart';
import 'package:e_commerce_friday_c9/presentation/screens/main/main.dart';
import 'package:e_commerce_friday_c9/presentation/utils/app_assets.dart';
import 'package:e_commerce_friday_c9/presentation/utils/app_color.dart';
import 'package:e_commerce_friday_c9/presentation/utils/base_request_states.dart';
import 'package:e_commerce_friday_c9/presentation/utils/dialog_utils.dart';
import 'package:e_commerce_friday_c9/presentation/widgets/custom_text_form_field.dart';
import 'package:e_commerce_friday_c9/presentation/widgets/form_label.dart';

import '../../../widgets/custom_button.dart';

class Login extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginViewModel viewModel = getIt();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocListener(
        listener: (context, state) {
          if (state is BaseRequestLoadingState) {
            showLoading(context);
          } else if (state is BaseRequestSuccessState) {
            Navigator.pop(context);
            Navigator.pushNamed(context, Main.routeName);
          } else if (state is BaseRequestErrorState) {
            Navigator.pop(context);
            showErrorDialog(context, state.message);
          }
        },
        bloc: viewModel,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Image.asset(AppAssets.splash,
                      height: MediaQuery.of(context).size.height * .12),
                  const SizedBox(
                    height: 75,
                  ),
                  Text(
                    'Welcome Back To e_commerce_friday_c9 Application',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Please sign in with your mail',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  FormLabelWidget(
                    label: 'Email Address',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextFormField(
                      controller: viewModel.emailController,
                      hintText: 'enter your email address',
                      // controller: viewModel.emailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter email';
                        }
                        var emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);

                        if (!emailValid) {
                          return 'Email format is not valid';
                        }

                        return null;
                      },
                      type: TextInputType.emailAddress),
                  const SizedBox(
                    height: 32,
                  ),
                  FormLabelWidget(
                    label: 'Password',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextFormField(
                    hintText: 'enter your password',
                    controller: viewModel.passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter password ';
                      }
                      if (text.length < 6) {
                        return 'Password should be at least 6 chrs.';
                      }
                      return null;
                    },
                    type: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: FormLabelWidget(label: 'Forget Password')),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButtonWidget(
                      title: 'Login',
                      onPressed: () {
                        viewModel.login(context);
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FormLabelWidget(label: "Don't have an account ? "),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Register.routeName);
                        },
                        child: FormLabelWidget(label: 'Create Account'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}