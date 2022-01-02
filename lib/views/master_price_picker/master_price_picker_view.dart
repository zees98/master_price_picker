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
                        "SMART\nPRICE SELECTOR",
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
                    flex: 2,
                    child: Column(
                      children: [
                        _buildDrawerButton(),
                        _buildDrawerButton(
                          icon: Icons.file_copy,
                          title: "Export",
                          subtitle: "Save your search as Excel sheet",
                          onPressed: viewModel.createExcelOfProducts,
                        ),
                        if (FirebaseAuth.instance.currentUser != null)
                          _buildDrawerButton(
                              icon: Icons.favorite,
                              title: "View Favourites",
                              subtitle: "View your past favourite ads",
                              onPressed: viewModel.navigateTofavourites)
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
              title: Text(
                "Smart Price Selector",
                style: titleFont.copyWith(
                  fontSize: 18,
                ),
              ),
              actions: [
                Builder(builder: (context) {
                  if (FirebaseAuth.instance.currentUser != null)
                    return GestureDetector(
                        onTap: viewModel.goToMyProfile,
                        child: CircleAvatar(
                          backgroundColor: compColor,
                          child: Icon(Icons.person_outline_rounded),
                        ));
                  return Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10).copyWith(right: 10),
                    child: MaterialButton(
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: cardColor,
                            )),
                        child: Row(
                          children: [
                            Icon(Icons.lock),
                            SizedBox(width: 10),
                            Text("Login"),
                          ],
                        ),
                        onPressed: () =>
                            viewModel.navigateToLoginScreenNoArgs()),
                  );
                }),
              ],
            ),
            body: Center(
                child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    labelText: viewModel.searchQuery.isEmpty
                        ? "Search your product here."
                        : viewModel.searchQuery,
                    onChanged: viewModel.onQueryChange,
                    suffix: Row(
                      children: [
                        IconButton(
                            onPressed: viewModel.onClickSearch,
                            icon: Icon(
                              Icons.search,
                              color: compColor,
                            )),
                        IconButton(
                            onPressed: viewModel.onClearSearch,
                            icon: Icon(
                              Icons.cancel,
                              color: compColor,
                            )),
                      ],
                    ),
                  ),
                  if (viewModel.searchQuery.isEmpty &&
                      viewModel.products.isEmpty)
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3.2 / 4,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          itemCount: viewModel.gridPictures.length,
                          itemBuilder: (context, i) {
                            var thisCategory = viewModel.gridPictures[i];
                            return CategoryCard(
                                category: thisCategory,
                                onPress: () => viewModel.onGridItemPress(i));
                          }),
                    ),
                  if (viewModel.isFetching)
                    Center(child: CircularProgressIndicator()),
                  if (viewModel.products.isNotEmpty)
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Search Results",
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
                                      var userId =
                                          FirebaseAuth.instance.currentUser.uid;
                                      print('UserID: ${userId}');
                                      if (userId != null) {
                                        // FirebaseAuth.instance.signOut();
                                        viewModel.addToFavorite(
                                            thisProduct.toJson());
                                      } else {
                                        viewModel.navigateToLoginScreen(
                                            thisProduct.toJson());
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
                backgroundColor: backgroundColor2.withRed(10).withGreen(120),
                selectedItemColor: cardColor,
                unselectedItemColor: Colors.white54,
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

class CategoryCard extends StatelessWidget {
  final String category;
  final onPress;

  const CategoryCard({Key key, this.category, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onPress,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0).copyWith(bottom: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/$category.png'),
              Text(
                "${category[0].toUpperCase()}${category.substring(1)}",
                style: smallHeading,
              ),
            ],
          )),
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
