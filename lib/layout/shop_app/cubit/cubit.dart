import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';

import '../../../models/shop_models/categories_model.dart';
import '../../../models/shop_models/change_fav_model.dart';
import '../../../models/shop_models/favourites_model.dart';
import '../../../models/shop_models/home_model.dart';
import '../../../models/shop_models/search_model.dart';
import '../../../models/shop_models/user_model.dart';
import '../../../modules/shop_app/categories/categories_screen.dart';
import '../../../modules/shop_app/favorites/favourite_screen.dart';
import '../../../modules/shop_app/products/products_screen.dart';
import '../../../modules/shop_app/settings/settings_screen.dart';
import '../../../shared/components/constans.dart';
import '../../../shared/network/end_point.dart';
import '../../../shared/network/remote/dio_helper.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopAppInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouriteScreen(),
     const SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopAppChangeBottomNavState());
  }

  HomeModel? homeModel;

  //    id  fav?
  Map<int, bool> favorites = {};

  void getHomeData() {
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products) {
        favorites.addAll({
          element.id!: element.inFav!,
        });
      }
      print(favorites);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }



  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessGetCategoriesState());
      // print(value.data);
    }).catchError((error) {
      emit(ShopErrorGetCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] =! favorites[productId]!;
    emit(ShopChangeFavState());
    DioHelper.postData(
      url: FAVOURITES,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessChangeFavState(changeFavoritesModel));
      if (changeFavoritesModel!.status! == false) {
        favorites[productId] =! favorites[productId]!;
    }else
      {
        getFavouritesData();
      }

    }).catchError((error) {
      favorites[productId] =! favorites[productId]!;

      emit(ShopErrorChangeFavState());
    });
  }


  FavoritesModel? favoritesModel;

void getFavouritesData() {
  emit(ShopLoadingFavDataState());
  DioHelper.getData(url: FAVOURITES, token: token).then((value)
  {
    favoritesModel = FavoritesModel.fromJson(value.data);
    print(value.data);
    emit(ShopSuccessGetFavouritesState());


  }).catchError((error) {
    print(error.toString());
    emit(ShopErrorGetFavouritesState());
  });
}

  UserModel? profileModel;
void getProfile()
{
  emit(ShopLoadingGetProfileState());
  DioHelper.getData(url: GET_PROFILE,token: token,).then((value)
  {
    profileModel = UserModel.fromJson(value.data);
    print(value.data);
    emit(ShopSuccessGetProfileState(profileModel!));
  }).catchError((error)
  {
    emit(ShopSuccessGetProfileState(profileModel!));
  });
}

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}

