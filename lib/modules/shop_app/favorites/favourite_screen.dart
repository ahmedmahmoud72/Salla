

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';

import '../../../shared/components/components.dart';


class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)

  {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return ShopCubit.get(context).favoritesModel!.data!.data.isEmpty ?  const Center(child:Text('No Products',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),)) :
            ConditionalBuilder(
              condition: state is! ShopLoadingFavDataState,
              builder: (context)=> ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => favBuilder(ShopCubit.get(context).favoritesModel!.data!.data[index].product!, context) ,
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount:ShopCubit.get(context).favoritesModel!.data!.data.length) ,
              fallback:(context)=> const Center(child:  CircularProgressIndicator()) );

        });

  }


 }






