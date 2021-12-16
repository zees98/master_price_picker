import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:master_price_picker/core/locator.dart';
import 'package:master_price_picker/core/router_constants.dart';
import 'package:master_price_picker/products.dart';
import 'package:master_price_picker/scraper.dart';
import 'package:master_price_picker/views/favorite_screen/favorite_screen_view.dart';
import 'package:master_price_picker/views/favourite_ads/favourite_ads_view.dart';
import 'package:master_price_picker/views/login_screen/login_screen_view.dart';
import 'package:master_price_picker/views/my_profile/my_profile_view.dart';
import 'package:master_price_picker/views/product_detail/product_detail_view.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:simple_permissions/simple_permissions.dart';
import 'package:stacked/stacked.dart';
import 'package:master_price_picker/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

// import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:path/path.dart';
// import 'package:excel/excel.dart';

class MasterPricePickerViewModel extends BaseViewModel {
  Logger log;

  final _navService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _snackbarService = locator<SnackbarService>();

  final _scraper = WebScraperAPI();

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
    var data = await Future.wait<List<Product>>([
      _scraper.runAliBabaScraper(searchQuery),
      _scraper.runOlxScraper(searchQuery),
    ]);

    products = [...data[0], ...data[1]];

    products.sort((a, b) => a.getPrice < b.getPrice ? -1 : 1);
    isFetching = false;
    // print(products[0].getName);
    notifyListeners();
    print(products.length);
  }

  onAdPress(index) {
    // var link = products[index].getLink;
    // launcher.launch(link);
    _navService.navigateToView(ProductDetailView(), arguments: products[index]);
  }

  createExcelOfProducts() async {
    if (products.isEmpty) {
      return _snackbarService.showSnackbar(
        message:
            "Products list is empty. Can not create excel for empty searches.",
        title: "OOPS!",
      );
    }

    var status = await Permission.storage.status;
    if (status.isPermanentlyDenied) {
      return _snackbarService.showSnackbar(
          title: "Problem!",
          message: "Please enable storage permission in the Settings.");
    }
    if (await Permission.storage.request().isGranted) {
      createExcelSheet();
//       var excel = Excel.createExcel();
//       // code of read or write file in external storage (SD card)
//       excel.insertRowIterables("Items", ["Google", "Yahoo", "Chrome"], 0);
// // products.map((e) => e.getName).toList()
//       // excel.insertRowIterables(sheet, row, rowIndex)
//       Directory downloadsDirectory =
//           await DownloadsPathProvider.downloadsDirectory;
//       var path = downloadsDirectory.path + "/excel.xlsx";
//       excel.encode().then((onValue) {
//         File(join(path))
//           ..createSync(recursive: true)
//           ..writeAsBytesSync(onValue);
//         _snackbarService.showSnackbar(
//           message: path,
//           title: "File saved",
//         );
//       });
    }
    // print(excel.sheets[0].9sheetName);
  }

  createExcelSheet() async {
    final Workbook workbook = new Workbook();

    final Worksheet worksheet = workbook.worksheets[0];

    worksheet.getRangeByName("A1").setText("Name");
    worksheet.getRangeByName("B1").setText("Price");
    worksheet.getRangeByName("C1").setText("Rating");
    worksheet.getRangeByName("D1").setText("URL");
    for (var i = 0; i < products.length; i++) {
      worksheet.getRangeByName("A${i + 2}").setText(products[i].getName);
      worksheet.getRangeByName("B${i + 2}").setNumber(products[i].getPrice);
      worksheet.getRangeByName("C${i + 2}").setText(products[i].getRatings);
      worksheet.getRangeByName("D${i + 2}").setText(products[i].getLink);
    }

    List<int> bytes = workbook.saveAsStream();

    Directory downloadsDirectory =
        await DownloadsPathProvider.downloadsDirectory;
    var path = downloadsDirectory.path +
        "/excel_${DateTime.now().millisecondsSinceEpoch}.xlsx";
    File(path).writeAsBytes(bytes).then((value) {
      _snackbarService.showSnackbar(
          message: value.path,
          title: "File saved",
          // mainButtonTitle: "Open File",
          onTap: (e) {
            OpenFile.open(path);
          });
    });
  }

  addToFavorite(data) async {
    var user = await FirebaseAuth.instance.currentUser();
    Firestore.instance
        .collection("favorite")
        .document()
        .setData({
          "uid": user.uid,
          "product": data,
          "DateTime": DateTime.now().toString(),
        })
        .then((result) => {
              _navService.navigateToView(FavouriteAdsView()),
            })
        .catchError((err) {
          notifyListeners();
          _snackbarService.showSnackbar(
            message: err.message.toString(),
            title: "Error",
          );
        });
    notifyListeners();
  }

  navigateTofavourites() {
    _navService.navigateToView(FavouriteAdsView());
  }

  navigateToLoginScreen(data) {
    _navService.navigateToView(LoginScreenView(), arguments: {"data": data});
  }

  goToMyProfile() {
    _navService.navigateWithTransition(
      MyProfileView(),
      duration: Duration(
        milliseconds: 500,
      ),
      transition: "leftToRight",
    );
  }

  MasterPricePickerViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
