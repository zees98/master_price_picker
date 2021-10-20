import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'product_detail_view_model.dart';

class ProductDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      builder:
          (BuildContext context, ProductDetailViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('ProductDetail View'),
          ),
        );
      },
      viewModelBuilder: () => ProductDetailViewModel(context),
    );
  }
}
