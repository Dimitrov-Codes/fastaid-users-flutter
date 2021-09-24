import 'package:cached_network_image/cached_network_image.dart';
import 'package:creativedata_app/sizeConfig.dart';
import 'package:flutter/material.dart';
/*
* Created by Mujuzi Moses
*/

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final bool isRound;
  final bool isAd;
  final double radius;
  final double height;
  final double width;
  final BoxFit fit;

  CachedImage({Key key,
    this.imageUrl,
    this.isRound = false,
    this.radius,
    this.height,
    this.isAd,
    this.width,
    this.fit = BoxFit.cover}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    try {
      return SizedBox(
        height: isRound ? radius : height,
        width: isRound ? radius : width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isRound ? 50 :radius),
          child: imageUrl != null ? CachedNetworkImage(
            imageUrl: imageUrl,
            fit: fit,
            placeholder: (context, url) =>
                Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red[300]),)),
            errorWidget: (context, url, error) =>
                isAd != null && isAd == true
                    ? Center(child: Text("AD", style: TextStyle(fontSize: 10 * SizeConfig.textMultiplier, color: Colors.black12),),)
                    : Image.asset("images/user_icon.png"),
          ) : isAd != null && isAd == true
              ? Center(child: Text("AD", style: TextStyle(fontSize: 10 * SizeConfig.textMultiplier, color: Colors.black12),),)
              : Image.asset("images/user_icon.png"),
        ),
      );
    } catch (e) {
      print("CachedImage Error ::: " + e.toString());
      return Image.asset("images/user_icon.png");
    }
  }
}
