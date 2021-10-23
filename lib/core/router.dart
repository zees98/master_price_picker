// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:master_price_picker/core/router_constants.dart';

import 'package:master_price_picker/views/master_price_picker/master_price_picker_view.dart' as view0;
import 'package:master_price_picker/views/login_screen/login_screen_view.dart' as view1;
import 'package:master_price_picker/views/splash_screen/splash_screen_view.dart' as view2;
import 'package:master_price_picker/views/product_detail/product_detail_view.dart' as view3;
import 'package:master_price_picker/views/favorite_screen/favorite_screen_view.dart' as view4;
import 'package:master_price_picker/views/register_screen/register_screen_view.dart' as view5;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case masterPricePickerViewRoute:
        return MaterialPageRoute(builder: (_) => view0.MasterPricePickerView());
      case loginScreenViewRoute:
        return MaterialPageRoute(builder: (_) => view1.LoginScreenView());
      case splashScreenViewRoute:
        return MaterialPageRoute(builder: (_) => view2.SplashScreenView());
      case productDetailViewRoute:
        return MaterialPageRoute(builder: (_) => view3.ProductDetailView());
      case favoriteScreenViewRoute:
        return MaterialPageRoute(builder: (_) => view4.FavoriteScreenView());
      case registerScreenViewRoute:
        return MaterialPageRoute(builder: (_) => view5.RegisterScreenView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}