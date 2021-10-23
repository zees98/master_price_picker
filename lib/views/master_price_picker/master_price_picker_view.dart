import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:master_price_picker/theme/colors.dart';
import 'package:master_price_picker/theme/fonts.dart';
import 'package:master_price_picker/widgets/dumb_widgets/CustomTextField.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'master_price_picker_view_model.dart';

class MasterPricePickerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MasterPricePickerViewModel>.reactive(
      builder: (BuildContext context, MasterPricePickerViewModel viewModel,
          Widget _) {
        return SafeArea(
          child: Scaffold(
            drawer: Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                            Colors.black54,
                            BlendMode.colorBurn,
                          ),
                          image: AssetImage(
                            "assets/drawer.jpeg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Text(
                        "SMART\nPRICE PICKER",
                        textAlign: TextAlign.center,
                        style: titleFont.copyWith(
                          color: backgroundColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        _buildDrawerButton(),
                        _buildDrawerButton(
                            icon: Icons.file_copy,
                            title: "Export",
                            subtitle: "Save your search as Excel sheet",
                            onPressed: viewModel.createExcelOfProducts),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text("Master Price Picker"),
              actions: [
                CircleAvatar(
                  backgroundColor: compColor,
                  child: Icon(Icons.person_outline_rounded),
                ),
              ],
            ),
            body: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    labelText: "Search your product here.",
                    onChanged: viewModel.onQueryChange,
                    suffix: IconButton(
                        onPressed: viewModel.onClickSearch,
                        icon: Icon(
                          Icons.search,
                          color: compColor,
                        )),
                  ),
                  if (viewModel.isFetching)
                    Center(child: CircularProgressIndicator()),
                  if (viewModel.products.isNotEmpty)
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Recent Items",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white.withOpacity(
                                0.75,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 9 / 17,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 24.0),
                                itemCount: viewModel.products.length,
                                itemBuilder: (context, i) {
                                  var thisProduct = viewModel.products[i];
                                  return ProductCard(
                                    title: thisProduct.getName,
                                    price: thisProduct.getPrice,
                                    description: "",
                                    image: thisProduct.getImgURL,
                                    onLike: () async {
                                      var userId = await FirebaseAuth.instance
                                          .currentUser();
                                      print('UserID: ${userId}');
                                      if (userId != null) {
                                        //await FirebaseAuth.instance.signOut();
                                      } else {
                                        viewModel
                                            .navigateToLoginScreen(thisProduct);
                                      }
                                    },
                                    onPress: () => viewModel.onAdPress(i),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            )),
            floatingActionButton: FloatingActionButton(
              backgroundColor: compColor,
              child: Icon(Icons.search),
              onPressed: () {},
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: backgroundColor2,
                selectedItemColor: compColor,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ]),
          ),
        );
      },
      viewModelBuilder: () => MasterPricePickerViewModel(),
    );
  }

  Container _buildDrawerButton({icon, title, subtitle, onPressed}) {
    return Container(
      margin: EdgeInsets.all(
        8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 50,
          )
        ],
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon ?? Icons.qr_code_scanner,
        ),
        title: Text(title ?? "Barcode scanner"),
        subtitle: Text(subtitle ?? "Search using barcode/ qr code."),
        onTap: onPressed ??
            () async {
              String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                "#ffffff",
                "Back",
                true,
                ScanMode.BARCODE,
              );
              if (barcodeScanRes != "-1")
                launch("https://www.google.com/search?q=${barcodeScanRes}");
            },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final image, title, description, price, onLike, onPress;
  const ProductCard({
    Key key,
    this.image,
    this.title,
    this.description,
    this.price,
    this.onLike,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      // padding: EdgeInsets.all(
      //   8.0,
      // ),
      margin: EdgeInsets.all(
        5.0,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xffdadada),
            blurRadius: 20,
            spreadRadius: 10,
          )
        ],
        borderRadius: BorderRadius.circular(
          20,
        ),
        color: Colors.white,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: Image.network(image),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(description),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$ ${price ?? 290}",
                            style: titleFont,
                          ),
                          IconButton(
                            onPressed: onPress,
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: compColor,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -24,
            top: -5,
            child: MaterialButton(
              padding: EdgeInsets.all(16.0),
              shape: CircleBorder(),
              color: Colors.black54,
              onPressed: onLike,
              child: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
