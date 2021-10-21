import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart' as parser;
import 'package:master_price_picker/products.dart';
import 'package:web_scraper/web_scraper.dart';

class WebScraperAPI {
  var _url = 'https://www.alibaba.com/trade';

  runAliBabaScraper(query) async {
    var route = "/search?fsb=y&IndexArea=product_en&CatId=&SearchText=$query";
    var cardClassName = "J-offer-wrapper";
    List<Product> products = [];
    try {
      final loadPage = await http.get(_url + route);
      html.Document document = parser.parse(loadPage.body);
      var prices = document.getElementsByClassName(cardClassName);

      for (int i = 0; i < prices.length; i++) {
        var imgLink = prices[i]
            .getElementsByClassName("seb-img-switcher__imgs")[0]
            .attributes['data-image'];
        var name = prices[i]
            .getElementsByClassName("elements-title-normal__content")[0]
            .text;
        var ratingsElements = prices[i]
            .getElementsByClassName("seb-supplier-review-gallery-test__score");
        print(ratingsElements);
        var ratings =
            ratingsElements.isEmpty ? "N/A" : ratingsElements.first.text;
        // print(imgLink);
        var url = prices[i].querySelectorAll("[href]")[0].attributes['href'];
        // print(url);
        var price = prices[i]
            .getElementsByClassName("elements-offer-price-normal__price")[0]
            .text;
        price = price.split("-")[0].replaceAll("US\$", "").replaceAll(",", "");
        var doublePrice = double.parse(price);
        // print(name);
        products.add(
          Product(
            name: name,
            link: "https:$url",
            price: doublePrice,
            imgURL: "https:$imgLink",
            ratings: ratings,
          ),
        );
      }

      print(products.length);
      return products;
    } on Exception catch (e) {
      print("Scraper stuck on an error");
      return products;
    }
  }

  scrapOneAd(adLink) async {
    try {
      final loadPage = await http.get(adLink);
      print("Scraping started");
      html.Document document = parser.parse(loadPage.body);
      // var ratings = document.getElementsByClassName("next-rating-medium");
      // print(ratings.length);
      // for (int i = 0; i < document.body.classes.length; i++)
      print(document.body.classes.contains("rating-wrapper"));
      return [0];
    } catch (e) {
      return [];
    }
  }
}

main(List<String> args) {
  // WebScraperAPI().runScraper();
}
