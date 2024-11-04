import 'package:actual/common/const/colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: (Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'asset/img/food/ddeok_bok_gi.jpg',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('떡볶이',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
                Text('전통 떡볶이의 정석\n대존맛 허리가 아파오기 시작했어요 살려주세용오ㅗ오오',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    // clip: 넘치면 걍 자르기, fade: 흐리게, ellipsis: ...
                    style: TextStyle(
                      fontSize: 14.0,
                      color: BODY_TEXT_COLOR,
                    )),
                Text(
                  '₩10000',
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
