import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'favourite_ads_view_model.dart';

class FavouriteAdsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavouriteAdsViewModel>.reactive(
      builder:
          (BuildContext context, FavouriteAdsViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("My favourites"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                viewModel.isBusy
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView(
                          children: <Widget>[
                            ...viewModel.data.documents.map((e) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white60,
                                ),
                                child: ListTile(
                                  leading: Image.network(
                                      e.data['product']['imgURL']),
                                  title: Text(e.data['product']['name']),
                                  subtitle:
                                      Text("\$ ${e.data['product']['price']}"),
                                  trailing: IconButton(
                                    onPressed: () => viewModel
                                        .openURL(e.data['product']['link']),
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                    ),
                                  ),
                                ),
                              );
                            })
                          ],
                        ),
                      ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => FavouriteAdsViewModel(),
    );
  }
}
