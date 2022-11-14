

import '../../modules/shop_login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void singOut(context) {

  CacheHelper.removeData(
    key: 'token',
  )!
      .then((value) {
    if (value) {
      navigateToAndKill(context,  ShopLogin());
    }
  });
}

String? token = CacheHelper.getData(key: 'token');


