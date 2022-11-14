

import '../../../models/shop_models/change_fav_model.dart';
import '../../../models/shop_models/user_model.dart';

abstract class ShopStates {}

class ShopAppInitialState extends ShopStates {}

class ShopAppChangeBottomNavState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessGetCategoriesState extends ShopStates {}

class ShopErrorGetCategoriesState extends ShopStates {}

class ShopChangeFavState extends ShopStates {}

class ShopSuccessChangeFavState extends ShopStates {
  ChangeFavoritesModel? model;

  ShopSuccessChangeFavState(this.model);
}

class ShopErrorChangeFavState extends ShopStates {}

class ShopLoadingFavDataState extends ShopStates {}

class ShopSuccessGetFavouritesState extends ShopStates {}

class ShopErrorGetFavouritesState extends ShopStates {}

class ShopLoadingGetProfileState extends ShopStates {}

class ShopSuccessGetProfileState extends ShopStates {
  final UserModel profileModel;

  ShopSuccessGetProfileState(this.profileModel);
}

class ShopErrorGetProfileState extends ShopStates {}

class SearchInitialState extends ShopStates {}

class SearchLoadingState extends ShopStates {}

class SearchSuccessState extends ShopStates {}

class SearchErrorState extends ShopStates {}
