import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constans.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state){},
        builder: (context, state)
        {
          return Stack(
            children: [
              SizedBox.expand(
                child: Image.asset(
                  'assets/images/background_image.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              DraggableScrollableSheet(
                  minChildSize: 0.1,
                  initialChildSize: 0.25,
                  builder: (context, scrollController) => SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height),
                      color: Colors.black54,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                  top: 30,
                                  bottom: 30,
                                ),
                                child: SizedBox(
                                  height: 100.0,
                                  width: 100.0,
                                  child: CircleAvatar(
                                    radius: 2.5,
                                    backgroundColor: Colors.black,
                                    child: ClipOval(
                                      child: Image.network(
                                        '${ShopCubit.get(context).profileModel!.data!.image}',
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${ShopCubit.get(context).profileModel!.data!.name}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white.withOpacity(0.7)),
                                      ),
                                      Text(

                                        'Mobile App Developer',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey.withOpacity(0.7)),
                                      ),
                                    ],
                                  ),
                                ),
                              // ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child:
                            Row(
                              children: [
                                Icon(Icons.email_outlined,color: Colors.white.withOpacity(0.7),size: 30,),
                                const SizedBox(width: 30,),
                                Text(
                                  '${ShopCubit.get(context).profileModel!.data!.email}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.5)
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child:
                            Row(
                              children: [
                                Icon(Icons.phone_android,color: Colors.white.withOpacity(0.7),size: 30,),
                                const SizedBox(width: 30,),
                                Text(
                                  '+2${ShopCubit.get(context).profileModel!.data!.phone}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.5)
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: defaultButton(function: ()
                            {

                              singOut(context);
                            }, text: 'LOGOUT',color: Colors.grey.withOpacity(0.15)),
                          )

                        ],
                      ),
                    ),
                  )),
            ],
          );
        },
        );


  }
}






























