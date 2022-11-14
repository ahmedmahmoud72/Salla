
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';

import '../../../models/shop_models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => buildCategoriesCards(
                  ShopCubit.get(context).categoriesModel!.data!.data[index]),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
              itemCount:
                  ShopCubit.get(context).categoriesModel!.data!.data.length);
        });
  }
}

Widget buildCategoriesItem(DataModel model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(children: [
        Image(
          image: NetworkImage('${model.image}'),
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          '${model.name}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
      ]),
    );

Widget buildCategoriesCards(DataModel model) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 10.0,
    ),
    child: Card(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 10.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(children: [
          Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    image: NetworkImage('${model.image}'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              )),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            '${model.name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black54,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )),
            ),
          )
        ])));
