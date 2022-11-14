

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';

import '../../../models/shop_models/categories_model.dart';
import '../../../models/shop_models/home_model.dart';
import '../../../shared/components/components.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        if (state is ShopSuccessChangeFavState)
        {
          if (!state.model!.status!)
          {
            showToast(message: state.model!.message!, state: ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
            builder: (context) =>
                productsBuilder(ShopCubit.get(context).homeModel!, ShopCubit.get(context).categoriesModel!, context ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }
}

Widget productsBuilder(HomeModel model, CategoriesModel category, context) {
  return SingleChildScrollView(
    child: Column(children: [
      CarouselSlider(
        items: model.data!.banners
            .map(
              (e) => Image(
                image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )
            .toList(),
        options: CarouselOptions(
          scrollDirection: Axis.horizontal,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          reverse: false,
          height: 250.0,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayInterval: const Duration(seconds: 3),
          initialPage: 0,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 120,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildCategoriesItem(category.data!.data[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                  itemCount: category.data!.data.length),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Products',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        color: Colors.grey[300],
        child: GridView.count(
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 1 / 1.55,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          children: List.generate(model.data!.products.length,
              (index) => buildGridProduct(model.data!.products[index], context)),
        ),
      )
    ]),
  );
}

Widget buildGridProduct(ProductModel model, context) => Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
            Image.network(
              model.image!,
              width: double.infinity,
              height: 180,
            ),
            if (model.discount != 0)
              Container(
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Discount'),
                ),
              )
          ]),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price!}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice!}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                        icon: ShopCubit.get(context).favorites[model.id]!? const Icon(Icons.favorite, size: 25, color: Colors.red,) : const Icon(Icons.favorite_border, size: 25,
                          // color: Colors.white,
                        ),
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
Widget buildCategoriesItem(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
       Image(
        image: NetworkImage(
            '${model.image}'),
        height: 120,
        width: 120,
        fit: BoxFit.cover,
      ),
      Container(
          width: 120,
          height: 25.0,
          color: Colors.black.withOpacity(0.6),
          child: Center(
            child: Text(
              '${model.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white, fontSize: 15.0),
            ),
          )),
    ]);
