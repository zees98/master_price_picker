// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:master_price_picker/core/router_constants.dart';

import 'package:master_price_picker/views/master_price_picker/master_price_picker_view.dart' as view0;
import 'package:master_price_picker/views/product_detail/product_detail_view.dart' as view1;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case masterPricePickerViewRoute:
        return MaterialPageRoute(builder: (_) => view0.MasterPricePickerView());
      case productDetailViewRoute:
        return MaterialPageRoute(builder: (_) => view1.ProductDetailView());
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