import 'package:logger/logger.dart';
import 'package:master_price_picker/core/locator.dart';
import 'package:master_price_picker/products.dart';
import 'package:master_price_picker/scraper.dart';
import 'package:stacked/stacked.dart';
import 'package:master_price_picker/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class MasterPricePickerViewModel extends BaseViewModel {
  Logger log;

  final _dialogService = locator<DialogService>();

  // var items = [
  //   {
  //     "title": "Item",
  //     "detail": "This is an item",
  //     "price": 9.99,
  //   },
  //   {
  //     "title": "Item",
  //     "detail": "This is an item",
  //     "price": 9.99,
  //   },
  //   {
  //     "title": "Item",
  //     "detail": "This is an item",
  //     "price": 9.99,
  //   },
  // ];

  List<Product> products = [];
  bool isFetching = false;

  String searchQuery = "";

  onQueryChange(str) {
    searchQuery = str;
  }

  onClickSearch() async {
    if (searchQuery.length == 0) {
      return _dialogService.showDialog(
          title: "Error", description: "Your search input is empty.");
    }
    isFetching = true;
    notifyListeners();
    products = await WebScraperAPI().runAliBabaScraper(searchQuery);
    isFetching = false;
    print(products[0].getName);
    notifyListeners();
    print(products.length);
  }

  onAdPress(index) {
    var link = products[index].getLink;
    launcher.launch(link);
  }

  MasterPricePickerViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
