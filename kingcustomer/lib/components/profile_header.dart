import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kingcustomer/helper/size_configuration.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    this.title = "",
    this.email = "",
    this.imageURL = "",
    this.phoneNumber = "",
    this.rating = const [],
  }) : super(key: key);
  final String title, email, phoneNumber, imageURL;
  final List<dynamic>? rating;
  double ratingg(List rating) {
    double length = rating.length.toDouble() - 1;
    double total = 0;
    for (var r in rating) {
      total += double.parse(r.split(" ")[1]);
    }
    return total / length;
  }

  @override
  Widget build(BuildContext context) {
    final double starRating = ratingg(rating!);
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          height: getProportionateScreenHeight(60),
          width: getProportionateScreenWidth(60),
          child: CircleAvatar(
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageURL,
                fit: BoxFit.cover,
                height: getProportionateScreenHeight(60),
                width: getProportionateScreenHeight(60),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(20),
                    fontWeight: FontWeight.w500),
              ),
              Text(
                email,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                phoneNumber,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RatingBar.builder(
              initialRating:
                  starRating.toStringAsFixed(1) == "Infinity" ? 0 : starRating,
              minRating: 0,
              maxRating: 5,
              itemBuilder: ((context, _) => const Icon(
                    Icons.star,
                    color: Colors.lightBlueAccent,
                  )),
              ignoreGestures: true,
              onRatingUpdate: (newRatingValue) {},
              updateOnDrag: false,
              allowHalfRating: true,
              glow: false,
              itemCount: 5,
              itemSize: getProportionateScreenHeight(15),
              textDirection: TextDirection.ltr,
            ),
            Text(
              starRating.toStringAsFixed(1) == "Infinity"
                  ? ""
                  : starRating.toStringAsFixed(1),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ]),
    );
  }
}
