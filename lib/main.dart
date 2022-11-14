import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/themes.dart';
import 'layout/shop_app/shop_app_layout.dart';
import 'modules/shop_app/onboarding/onboarding_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'modules/shop_login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget? widget;
  bool? isBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');
  print(token);

  if (isBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = const ShopLogin();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(
    MyApp(
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  // final bool isDark;
  final Widget? startWidget;

  const MyApp(
      {Key? key,
      // required this.isDark,
      required this.startWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavouritesData()
        ..getProfile(),
      child:MaterialApp(
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: startWidget,
          ));
  }
}
