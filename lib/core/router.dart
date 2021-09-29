// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:master_price_picker/core/router_constants.dart';

import 'package:master_price_picker/views/master_price_picker/master_price_picker_view.dart' as view0;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case masterPricePickerViewRoute:
        return MaterialPageRoute(builder: (_) => view0.MasterPricePickerView());
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