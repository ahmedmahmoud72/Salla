import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/register/register_cubit/states.dart';

import '../../../../models/shop_models/register_model.dart';
import '../../../../shared/network/end_point.dart';
import '../../../../shared/network/remote/dio_helper.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  ShopRegisterModel? registerModel;

  static  ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name ,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      print(value.data);
      registerModel = ShopRegisterModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(registerModel!));

    }).catchError((error) {
      print('YOUR FUCKIN STUPID ERROR : ${error.toString()}');
      emit(ShopRegisterErrorState(error.toString()));
    });
  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegChangePasswordVisibilityState());
  }
}