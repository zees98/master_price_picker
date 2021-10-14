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
        var name = prices[i].getElementsByClassName("large")[0].text;
        print(imgLink);
        var url = prices[i].querySelectorAll("[href]")[0].attributes['href'];
        print(url);
        var price = prices[i]
            .getElementsByClassName("elements-offer-price-normal__price")[0]
            .text;
        price = price.split("-")[0].replaceAll("US\$", "").replaceAll(",", "");
        var doublePrice = double.parse(price);
        products.add(Product(
            name: name,
            link: "https:$url",
            price: doublePrice,
            imgURL: "https:$imgLink"));
      }

      print(products.length);
      return products;
    } on Exception catch (e) {
      print(e);
    }
  }
}

main(List<String> args) {
  // WebScraperAPI().runScraper();
}
