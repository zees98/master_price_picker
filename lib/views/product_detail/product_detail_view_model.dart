import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:master_price_picker/products.dart';
import 'package:master_price_picker/scraper.dart';
import 'package:stacked/stacked.dart';
import 'package:master_price_picker/core/logger.dart';

class ProductDetailViewModel extends FutureViewModel {
  Logger log;
  Product product;

  ProductDetailViewModel(context) {
    log = getLogger(this.runtimeType.toString());
    var args = ModalRoute.of(context).settings.arguments;
    product = args;
  }

  Future runScraper() {
    print(product.getLink);
    return WebScraperAPI().scrapOneAd(product.getLink);
  }

  @override
  Future futureToRun() => runScraper();
}
