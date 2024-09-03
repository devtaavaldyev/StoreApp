// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/core/extension.dart';
import 'package:taskproject/future/data/model/store_model.dart';

import 'package:taskproject/future/presentation/provider/store_provider.dart';
import 'package:taskproject/core/cache/cache_image.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({
    Key? key,
    required this.detailModel,
  }) : super(key: key);
  StoreModel detailModel;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void didChangeDependencies() {
    final storeProvider = Provider.of<StoreProvider>(context)
        .getProduct(product: widget.detailModel);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Product'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.network(
            widget.detailModel.image ??
                'https://st4.depositphotos.com/9999814/28360/i/1600/depositphotos_283604498-stock-photo-beautiful-wooden-path-in-plitvice.jpg',
            fit: BoxFit.fill,
            height: context.height * 0.280,
          ),
          SizedBox(height: context.height * 0.016),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kod:   ${widget.detailModel.id.toString()}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  'Title:   ${widget.detailModel.title ?? 'SomeError Brother'}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  'Category:   ${widget.detailModel.category ?? 'SomeError Brother'}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  'Description:   ${widget.detailModel.description ?? 'SomeError Brother'}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
