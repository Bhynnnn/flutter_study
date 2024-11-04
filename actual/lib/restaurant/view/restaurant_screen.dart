import 'dart:io';

import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginationRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List>(
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                itemBuilder: (_, index) {
                  final item = snapshot.data![index];
                  final pItem = RestaurantModel.fromJson(json: item);
                  return GestureDetector(
                      onTap: () {
                        // Card누르면 navigate to detail Screen
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) =>
                                  RestaurantDetailScreen(id: pItem.id)),
                        );
                      },
                      child: RestaurantCard.fromModel(model: pItem));
                },
                itemCount: snapshot.data!.length,
                separatorBuilder: (_, index) {
                  return SizedBox(
                    height: 16.0,
                  );
                },
              );
            },
            future: paginationRestaurant(),
          ),
        ),
      ),
    );
  }
}
