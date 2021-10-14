import 'dart:io';

import 'package:flutter/material.dart';
import 'package:master_price_picker/theme/colors.dart';
import 'package:master_price_picker/widgets/dumb_widgets/CustomTextField.dart';
import 'package:stacked/stacked.dart';
import 'master_price_picker_view_model.dart';

class MasterPricePickerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MasterPricePickerViewModel>.reactive(
      builder: (BuildContext context, MasterPricePickerViewModel viewModel,
          Widget _) {
        return SafeArea(
          child: Scaffold(
            drawer: Drawer(),
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
                                    onLike: () {},
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
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
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
