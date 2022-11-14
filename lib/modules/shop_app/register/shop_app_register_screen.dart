import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/register/register_cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/register/register_cubit/states.dart';

import '../../../layout/shop_app/shop_app_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constans.dart';
import '../../../shared/network/local/cache_helper.dart';


class ShopRegisterScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state)
        {
          if (state is ShopRegisterSuccessState)
          {
            if (state.registerModel.status!)
            {
              print(state.registerModel.message);
              print(state.registerModel.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.data!.token,
              )!.then((value)
              {
                token = state.registerModel.data!.token!;

                navigateToAndKill(
                  context,
                  const ShopLayout(),
                );
              });
            } else {
              print(state.registerModel.message);

              showToast(
                message: state.registerModel.message!,
                state: ToastStates.error,
              );
            }
          }
        },
        builder: (context, state)
        {
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
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTFF(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                          labelText: 'User Name',
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTFF(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String ?value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          labelText: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTFF(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: ShopRegisterCubit.get(context).suffix,
                          onFieldSubmitted: (value)
                          {

                          },
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validator: (String ?value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          labelText: 'Password',
                          prefixIcon: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTFF(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (String ?value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }
                          },
                          labelText: 'Phone',
                          prefixIcon: Icons.phone,
                        ),
                        SizedBox(
                          height: 30.0,
                        ), defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,

                                );
                              }
                            },
                            text: 'REGISTER')
                ]
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}