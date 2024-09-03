// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:taskproject/future/data/model/store_model.dart';

final url = 'https://fakestoreapi.com/products';

class StoreRepo {
  final Dio dio;

  StoreRepo({required this.dio});
  getProductsRepo({required int page}) async {
    try {
      final response = await dio.get(
        '$url?page=$page',
      );
      final result = response.data as List;
      final users = result.isNotEmpty
          ? result.map((e) => StoreModel.fromJson(e)).toList()
          : [];
      for (StoreModel product in users) {
        await DefaultCacheManager().downloadFile(product.image ?? '');
      }

      return users;
    } on DioError catch (e) {
      log(e.toString());
    }
  }

  getDetailProductsRepo({required id}) async {
    try {
      final response = await dio.get(url, queryParameters: {'id': id});
      final result = response.data as List;
      return result.map((e) => StoreModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }
  }

  deleteProductRepo({required num? id}) async {
    try {
      final response =
          await dio.delete('$url/$id', queryParameters: {'id': id});
      if (response.statusCode == 200) {
        print('Succes');
        return response;
      }
      print('Error');
    } catch (e) {
      print(e);
    }
  }

  createProductRepo({required StoreModel product}) async {
    try {
      product.image =
          'https://st4.depositphotos.com/9999814/28360/i/1600/depositphotos_283604498-stock-photo-beautiful-wooden-path-in-plitvice.jpg';

      final response = await dio.post(url, data: product.toJson());
      final newProduct = StoreModel.fromJson(response.data);
      return newProduct;
    } catch (e) {
      print(e);
      return StoreModel();
    }
  }
}
