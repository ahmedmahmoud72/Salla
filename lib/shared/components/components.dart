import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/shop_app/cubit/cubit.dart';


Widget defaultButton(
        {double width = double.infinity,
        Color color = Colors.blue,
        required Function function,
        required String text}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),

        color: color,

      ),
      width: width,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );

Widget defaultTFF({
  required String labelText,
  required TextInputType keyboardType,
  required TextEditingController controller,
  required IconData prefixIcon,
  IconData? suffixIcon,
  required Function validator,
  Function? onFieldSubmitted,
  Function? onChanged,
  bool isPassword = false,
  Function? suffixPressed,
  Color cursorColor = Colors.black,
  Function()? onTap,
}) =>
    TextFormField(
      cursorColor: cursorColor,
      obscureText: isPassword,
      // onChanged: (value)
      // {
      //   onChanged!(value);
      // },
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: IconButton(
            icon: (Icon(suffixIcon)),
            onPressed: () {
              suffixPressed!();
            },
          ),
          labelText: labelText),
      validator: (value) {
        return validator(value);
      },
      onFieldSubmitted: (value) {
        onFieldSubmitted!(value);
      },
      // onTap: () {
      //   onTap!();
      // }
    );


Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        color: Colors.grey,
        height: 2,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToAndKill(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

Widget textButton({required Function onPressed, required String name}) =>
    TextButton(
      onPressed: () {
        onPressed();
      },
      child: Text(name),
    );

void showToast({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: changeToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { success, error, warning } // when i have more than 1 choice

Color? changeToastColor(ToastStates state) {
  Color? color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
Widget favBuilder (model, context,{bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: SizedBox(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 150.0,
              height: 150.0,
            ),
            if (model.discount != 0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    model.price!.toString(),
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  Expanded(
                    child: isOldPrice?
                    (IconButton(icon:
                     ShopCubit.get(context).favorites[model.id]! ? const Icon(
                      Icons.favorite,
                      size:25.0,
                      color: Colors.red
                    )
                        : const Icon(
                      Icons.favorite_border,
                      size: 25.0,
                      // color: Colors.white,
                    ),
                        onPressed: () {
                      if(isOldPrice) {
                          ShopCubit.get(context)
                              .changeFavorites(model.id!);}
                      else {
                        null;
                      }
                        }) ):
                        ShopCubit.get(context).favorites[model.id]! ? const Icon(
                          Icons.favorite,
                          size:25.0,
                          color: Colors.red
                      )
                          : const Icon(
                        Icons.favorite_border,
                        size: 25.0,
                        // color: Colors.white,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
