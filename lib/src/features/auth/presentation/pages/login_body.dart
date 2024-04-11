import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/src/app/logic/app_settings.dart';
import 'package:task_manager/src/app/theme/app_colors.dart';
import 'package:task_manager/src/core/common/widgets/alert_dialog.dart';
import 'package:task_manager/src/core/common/widgets/button_view.dart';
import 'package:task_manager/src/core/common/widgets/custom_form_field.dart';
import 'package:task_manager/src/core/common/widgets/loading_view.dart';
import 'package:task_manager/src/core/common/widgets/text_view.dart';
import 'package:task_manager/src/features/auth/domain/entities/login_form_entity.dart';
import 'package:task_manager/src/features/auth/presentation/bloc/login_bloc.dart';
import 'package:task_manager/src/features/injection.dart';
import 'package:task_manager/src/features/task_management/presentation/pages/home_page.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();
  LoginFormEntity? loginFormEntity = LoginFormEntity();
  AutovalidateMode? autovalidateMode;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          showDialog(
              context: context,
              barrierColor: Colors.black.withOpacity(0.6),
              builder: (_) {
                return AlertDialogView(
                  content: state.errorModel.error ?? '',
                );
              });
        } else if (state is LoginSuccessState) {
          final token = serviceLocator<AppSettings>().token;
          if (token.toString() != 'null') {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
          } else {
            showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.6),
                builder: (_) {
                  return AlertDialogView(
                    content: state.loginResponseEntity.error.toString(),
                  );

                  // content: state.loginResponseEntity.token!,
                });
          }

          // context.router.replaceNamed("main");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Form(
              key: _formGlobalKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: 40.0.h)),
                    TextView(
                      text: "Login into your account",
                      style: TextStyle(
                        color: AppColors.blue,
                        fontSize: 30.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 40.0.h)),
                    SizedBox(
                      width: 335.0.w,
                      child: CustomFormField(
                        hintText: "E-mail",
                        title: "",
                        isPassword: false,
                        autoValidate: false,
                        controller: emailController,
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: AppColors.blue,
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter E-mail';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 19.0)),
                    SizedBox(
                      width: 335.0.w,
                      child: CustomFormField(
                          hintText: "Password",
                          title: "",
                          isPassword: true,
                          obscureText: true,
                          controller: passwordController,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.blue,
                          ),
                          autoValidate: false,
                          suffixIcon: Icons.abc_sharp,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          }),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 40.0.h)),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginILoadingState) {
                          return Center(child: LoadingView());
                        } else {
                          return SizedBox(
                            width: 320.0.w,
                            child: ButtonView(
                              buttonType: ButtonType.customElevatedButton,
                              onClick: () {
                                if (_formGlobalKey.currentState!.validate()) {
                                  _formGlobalKey.currentState?.save();
                                  BlocProvider.of<LoginBloc>(context).add(DoLogin(
                                      loginFormEntity:
                                          LoginFormEntity(email: emailController.text, password: passwordController.text),
                                      context: context));
                                } else {
                                  setState(() {
                                    autovalidateMode = AutovalidateMode.onUserInteraction;
                                  });
                                }
                              },
                              title: 'Confirm',
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      // builder: (context, state) => state.maybeWhen(
      //   orElse: () {
      //     return SizedBox(
      //       child: Form(
      //         key: _formGlobalKey,
      //         child: Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const SizedBox(
      //                 height: 48,
      //               ),
      //               TextFormFieldView(
      //                 prefixIcon: IconButton(
      //                   icon: Row(
      //                     mainAxisSize: MainAxisSize.min,
      //                     children: [
      //                       CountryCodePicker(
      //                         onChanged: (CountryCode? code) {
      //                           setState(() {
      //                             countryCode = code?.dialCode ?? "+964";
      //                           });
      //                         },
      //                         // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
      //                         initialSelection: 'IQ',
      //                         // favorite: ['+964', 'IQ'],
      //                         // optional. Shows only country name and flag
      //                         showCountryOnly: false,
      //                         // optional. Shows only country name and flag when popup is closed.
      //                         showOnlyCountryWhenClosed: false,
      //                         // optional. aligns the flag and the Text left
      //                         // alignLeft: false,
      //                         showFlag: false,
      //                         textStyle:
      //                             Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14, color: Colors.grey.shade500),
      //                       ),
      //                       Text('|',
      //                           style:
      //                               Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14, color: Colors.grey.shade500))
      //                     ],
      //                   ),
      //                   onPressed: () {},
      //                 ),
      //                 onSave: (String? content) {
      //                   loginFormEntity?.userName = content ?? "";
      //                 },
      //                 textEditingController: emailController,
      //                 textFormFieldTypes: TextFormFieldTypes.phone,
      //                 hint: "phone",
      //                 keyboardType: TextInputType.number,
      //                 errorMessage: "please_provide_valid_phone".tr(),
      //               ),
      //               const SizedBox(
      //                 height: 10,
      //               ),
      //               PasswordField(
      //                 title: "".tr(),
      //                 hint: "Password".tr(),
      //                 controller: passwordController,
      //                 onSaved: (content) {
      //                   loginFormEntity?.password = content ?? "";
      //                 },
      //                 autovalidateMode: autovalidateMode,
      //               ),
      //               Expanded(
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.end,
      //                   children: [
      //                     BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      //                       return state.maybeWhen(orElse: () {
      //                         return Center(
      //                           child: Padding(
      //                             padding: const EdgeInsets.only(bottom: 32.0),
      //                             child: SizedBox(
      //                                 width: double.infinity,
      //                                 height: 55,
      //                                 child: ButtonView(
      //                                   buttonType: ButtonType.customElevatedButton,
      //                                   onClick: () {
      //                                     if (_formGlobalKey.currentState!.validate()) {
      //                                       _formGlobalKey.currentState?.save();
      //                                       BlocProvider.of<LoginCubit>(context).doLogin(LoginFormEntity(
      //                                               password: passwordController.text, userName: emailController.text) ??
      //                                           // userName: "${countryCode}${userNameController.text}") ??
      //                                           LoginFormEntity());
      //                                     } else {
      //                                       setState(() {
      //                                         autovalidateMode = AutovalidateMode.onUserInteraction;
      //                                       });
      //                                     }
      //                                   },
      //                                   title: 'Confirm'.tr(),
      //                                 )),
      //                           ),
      //                         );
      //                       }, loading: () {
      //                         return Center(child: LoadingView());
      //                       });
      //                     }),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
