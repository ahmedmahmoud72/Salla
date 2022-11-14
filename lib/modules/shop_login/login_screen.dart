import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_login/cubit/states.dart';

import '../../layout/shop_app/shop_app_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../shop_app/register/shop_app_register_screen.dart';
class ShopLogin extends StatefulWidget {
  const ShopLogin({Key? key}) : super(key: key);

  @override
  State<ShopLogin> createState() => _ShopLoginState();
}

class _ShopLoginState extends State<ShopLogin> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      // بشغل ال cubit بتاعي
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            try {
              if (state is ShopLoginSuccessState) {
                if (state.loginModel.status!) {

                  CacheHelper.saveData(key: 'token', value: state.loginModel
                      .data!.token,)!.then((value)
                  {
                    navigateToAndKill(context, const ShopLayout());
                  });
                } else {
                  debugPrint(state.loginModel.message);

                  showToast(
                      message: '${state.loginModel.message}',
                      state: ToastStates.error);
                }
              }
            } catch (error) {
              debugPrint(error.toString());
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LOGIN',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),

                          // لو انا مختار لون من ال theme وعايز اعدل عليه بستخدم copy with.
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'login in now to browse our hot offers',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultTFF(
                              labelText: 'Email Address',
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              prefixIcon: Icons.email_outlined,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return ('Enter Your Email Please');
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultTFF(
                            isPassword: ShopLoginCubit
                                .get(context)
                                .isPassword,
                            labelText: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: ShopLoginCubit
                                .get(context)
                                .suffix,
                            suffixPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return ('Password Address is required');
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          ConditionalBuilder(
                              fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                              condition: state is! ShopLoginLoadingState,
                              builder: (context) =>
                                  defaultButton(
                                      function: () {
                                        if (formKey.currentState!.validate()) {
                                          ShopLoginCubit.get(context).userLogin(
                                              email: emailController.text,
                                              password: passwordController
                                                  .text);
                                        }
                                      },
                                      text: 'LOGIN')),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("If you don't have an account?"),
                              textButton(
                                  onPressed: () {
                                    navigateTo(context, ShopRegisterScreen());
                                  },
                                  name: 'REGISTER NOW'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
