import 'package:actual/common/const/colors.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;

  const ProductCard(
      {required this.image,
      required this.name,
      required this.detail,
      required this.price,
      super.key});

  factory ProductCard.fromModel({
    required RestaurantProductModel model,
  }) {
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: (Row(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(8.0), child: image),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(name,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
                Text(detail,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    // clip: 넘치면 걍 자르기, fade: 흐리게, ellipsis: ...
                    style: TextStyle(
                      fontSize: 14.0,
                      color: BODY_TEXT_COLOR,
                    )),
                Text(
                  '￦$price',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
