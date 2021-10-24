class Product {
  String _name;
  double _price;
  String _link;
  String _imgURL;
  String _ratings;

  Product({name, price, link, imgURL, ratings}) {
    _name = name;
    _price = price;
    _link = link;
    _imgURL = imgURL;
    _ratings = ratings;
  }

  String get getName => _name;
  double get getPrice => _price;
  String get getLink => _link;
  String get getImgURL => _imgURL;
  String get getRatings => _ratings;

  set setName(name) {
    _name = name;
  }

  set setRatings(ratings) {
    _ratings = ratings;
  }

  set setPrice(price) {
    _price = price;
  }

  set setLink(link) {
    _link = link;
  }

  set setImg(imgURL) {
    _imgURL = imgURL;
  }

  Map<String, dynamic> toJson() => {
        'name': _name,
        'price': _price,
        'link': _link,
        'imgURL': _imgURL,
        'ratings': _ratings,
      };
}
