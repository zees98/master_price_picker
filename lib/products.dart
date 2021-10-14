class Product {
  String _name;
  double _price;
  String _link;
  String _imgURL;

  Product({name, price, link, imgURL}) {
    _name = name;
    _price = price;
    _link = link;
    _imgURL = imgURL;
  }

  String get getName => _name;
  double get getPrice => _price;
  String get getLink => _link;
  String get getImgURL => _imgURL;

  set setName(name) {
    _name = name;
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
}
