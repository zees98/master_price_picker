import 'package:flutter/material.dart';
import 'package:master_price_picker/theme/colors.dart';
import 'package:master_price_picker/theme/fonts.dart';
import 'package:stacked/stacked.dart';
import 'product_detail_view_model.dart';

class ProductDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      builder:
          (BuildContext context, ProductDetailViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              viewModel.product.getName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(
                    16.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.network(
                    viewModel.product.getImgURL,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      )),
                  margin: EdgeInsets.only(
                    top: 8.0,
                  ),
                  padding: EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Column(
                    children: [
                      Container(
                        // height: 200,
                        child: Text(
                          viewModel.product.getName,
                          style: titleFont.copyWith(fontSize: 24),
                          maxLines: 2,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // height: 200,
                          margin: EdgeInsets.only(
                            top: 16.0,
                          ),
                          child: GridView.count(
                            childAspectRatio: 16 / 9,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: [
                              _buildStatCard(
                                  Icon(
                                    Icons.money,
                                    color: compColor,
                                  ),
                                  "Price",
                                  "\$ ${viewModel.product.getPrice}"),
                              _buildStatCard(
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  "Ratings",
                                  "${viewModel.product.getRatings}"),
                            ],
                          ),
                        ),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: viewModel.openAd,
                        child: Text("View this Ad."),
                        color: Colors.cyan,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => ProductDetailViewModel(context),
    );
  }

  Container _buildStatCard(icon, title, value) {
    return Container(
      color: Colors.white54,
      padding: EdgeInsets.all(
        8.0,
      ),
      height: 50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              icon,
              SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: smallHeading,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            value,
            style: titleFont,
          ),
        ],
      ),
    );
  }
}
