import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:master_price_picker/core/logger.dart';

class MasterPricePickerViewModel extends BaseViewModel {
  Logger log;

  var items = [
    {
      "title": "Item",
      "detail": "This is an item",
      "price": 9.99,
    },
    {
      "title": "Item",
      "detail": "This is an item",
      "price": 9.99,
    },
    {
      "title": "Item",
      "detail": "This is an item",
      "price": 9.99,
    },
  ];

  MasterPricePickerViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
