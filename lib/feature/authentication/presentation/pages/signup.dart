import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/utils/spacing.dart';
import 'package:spotify/core/utils/snackbars.dart';
import 'package:spotify/core/router/app_routes.dart';
import 'package:spotify/core/helpers/validators.dart';
import 'package:spotify/core/utils/assets/icons.dart';
import 'package:spotify/core/common/widgets/button.dart';
import 'package:spotify/core/common/widgets/app_bar.dart';
import 'package:spotify/core/utils/theme/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/core/injection/service_locator.dart';
import 'package:spotify/core/common/widgets/text_form_field.dart';
import 'package:spotify/feature/authentication/logic/usecases/sign_up.dart';
import 'package:spotify/feature/authentication/data/model/sign_response.dart';
import 'package:spotify/feature/authentication/presentation/bloc/loading_cubit.dart';
import 'package:spotify/feature/authentication/presentation/bloc/obsecure_password.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          CustomAppBar(
            onBackPressed: () => Get.back(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  verticalSpaceing(20),
                  Text(
                    "Register",
                    style: AppFontStyles.bold25,
                  ),
                  verticalSpaceing(20),
                  _support(),
                  verticalSpaceing(30),
                  _fullNameTextField(),
                  _emailTextField(),
                  _passwordTextField(),
                  verticalSpaceing(20),
                  _registerButton(_formKey),
                  verticalSpaceing(20),
                  _orDivider(),
                  verticalSpaceing(20),
                  _signWithAccount(),
                  verticalSpaceing(10),
                ],
              ),
            ),
          ),
          verticalSpaceing(30),
          _doYouHaveAnAccount()
        ],
      )),
    );
  }

  Widget _registerButton(GlobalKey formKey) {
    return BlocProvider<LoadingCubit>(
      create: (context) => LoadingCubit(),
      child: BlocBuilder<LoadingCubit, LoadingState>(
        builder: (context, state) {
          return AppButton(
            loadingState: state,
            label: "Register",
            onPressed: () async {
              context.read<LoadingCubit>().startLoading();

              if (_formKey.currentState!.validate()) {
                var result = await serviceLocator<SignUpUseCase>().call(
                    params: SignRequest(
                  email: _emailController.text.toString(),
                  name: _fullNameController.text.toString(),
                  password: _passwordController.text.toString(),
                ));
                result.fold((failure) {
                  pushSnackBar(
                      title: "Try agin",
                      info: failure,
                      status: SnackbarType.fail);
                }, (right) {
                  pushSnackBar(
                      title:
                          "Welcome aboard,${_fullNameController.text.split(' ')[0]}",
                      info: "Get ready to explore some awesome tunes.",
                      status: SnackbarType.sucsess);
                  _clearTextFields();
                  Get.toNamed(Routes.homePage, arguments: right);
                });
              }
              context.read<LoadingCubit>().stopLoading();
            },
            width: Get.width.w,
            height: 70.h,
          );
        },
      ),
    );
  }

  void _clearTextFields() {
    _fullNameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  Row _doYouHaveAnAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Do you have an account ?", style: AppFontStyles.regular14),
        horizantalSpaceing(5),
        InkWell(
            onTap: () => Get.offAndToNamed('/signInPage'),
            child: Text(
              "Sign in",
              style: AppFontStyles.greenRegular14
                  .copyWith(fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Row _signWithAccount() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppIcons.google,
          height: 30,
        ),
        horizantalSpaceing(50),
        Image.asset(
          AppIcons.apple,
          height: 35,
        ),
      ],
    );
  }

  Widget _passwordTextField() {
    return BlocProvider(
      create: (context) => PasswordTFFCubit(),
      child: BlocBuilder<PasswordTFFCubit, PasswordTFFState>(
        builder: (context, state) {
          return CustomTextFormField(
            isObsecure: state is IsObsecure,
            hintText: "Enter a password",
            controller: _passwordController,
            validator: (password) =>
                AppValidators.passwordValidator(password, false),
            suffixIcon: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  if (state is IsObsecure) {
                    context.read<PasswordTFFCubit>().turnOffObsecure();
                  } else {
                    context.read<PasswordTFFCubit>().turnOnObsecure();
                  }
                },
                child: Icon(
                  state is IsObsecure
                      ? CupertinoIcons.eye_fill
                      : CupertinoIcons.eye_slash_fill,
                  color: Colors.grey,
                  size: 20,
                )),
          );
        },
      ),
    );
  }

  CustomTextFormField _emailTextField() {
    return CustomTextFormField(
      validator: (email) => AppValidators.emailValidator(email),
      controller: _emailController,
      hintText: "Enter your email",
    );
  }

  CustomTextFormField _fullNameTextField() {
    return CustomTextFormField(
      validator: (fullName) => AppValidators.fullNameValidator(fullName),
      controller: _fullNameController,
      hintText: "Full name",
    );
  }

  Row _support() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("If You need any help", style: AppFontStyles.regular12),
        horizantalSpaceing(5),
        InkWell(
            onTap: () {},
            child: Text(
              "Click Here",
              style: AppFontStyles.greenRegular12,
            )),
      ],
    );
  }
}

Widget _orDivider() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
          width: Get.width * .35,
          child: const Divider(thickness: 1.0, color: Colors.black12)),
      horizantalSpaceing(5),
      const Text('OR', style: TextStyle(color: Colors.grey)),
      horizantalSpaceing(5),
      SizedBox(
          width: Get.width * .35,
          child: const Divider(thickness: 1.0, color: Colors.black12)),
    ],
  );
}
