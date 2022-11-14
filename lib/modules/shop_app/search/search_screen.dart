

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';


class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
   var formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ShopCubit, ShopStates>
   ( listener:(context, state) {},
      builder: (context, state)
      {
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0
              ),
              child: Column(
                  children: [
                    defaultTFF(
                    labelText: 'Search Product',
                    keyboardType: TextInputType.text,
                    controller: searchController,
                    prefixIcon: Icons.search,
                    validator: (String value)
                    {
                      if (value.isEmpty)
                      {
                        return 'Enter Text to search';
                      }
                      return null;
                    },
                  onFieldSubmitted: (String text)
                  {
                    ShopCubit.get(context).search(text);
                  },
                ),
                    const SizedBox(height: 10.0,),
                    if(state is SearchLoadingState) const
                    LinearProgressIndicator(),
                    const SizedBox(height: 10.0,),
                 if(state is SearchSuccessState)
                 Expanded(
                   child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => favBuilder(ShopCubit.get(context).model!.data!.data[index], context,isOldPrice: false) ,
                separatorBuilder: (context, index) => myDivider(),
                itemCount: ShopCubit.get(context).model!.data!.data.length),
                 ),

                  ]),
            ) ,
          ),
        );
      },
    );
  }
}


