import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:master_price_picker/products.dart';
import 'package:master_price_picker/scraper.dart';
// import 'package:sentiment_dart/sentiment_dart.dart';
import 'package:stacked/stacked.dart';
import 'package:master_price_picker/core/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailViewModel extends FutureViewModel {
  Logger log;
  Product product;
  // Sentiment sentiment = Sentiment();

  ProductDetailViewModel(context) {
    log = getLogger(this.runtimeType.toString());
    // sentiment = Sentiment();
    var args = ModalRoute.of(context).settings.arguments;
    product = args;
  }

  Future<List> runScraper() {
    print(product.getLink);
    return WebScraperAPI().getAliBabaReview(product.getLink);
  }

  openAd() async {
    await launch(product.getLink);
  }

  @override
  Future futureToRun() => runScraper();
}
