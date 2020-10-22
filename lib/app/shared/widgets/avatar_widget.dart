import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_promise/app/shared/utils.dart';

class AvatarWidget extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double width;
  final double height;

  const AvatarWidget(
      {Key key,
      @required this.imageUrl,
      this.width = 100,
      this.height = 100,
      @required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(1),
        color: Colors.white,
        child: ClipOval(
          child: Builder(
            builder: (context) {
              if (imageUrl == null || imageUrl.isEmpty) {
                return Container(
                    color: Theme.of(context).canvasColor,
                    width: width,
                    height: height,
                    child: Center(
                      child: Text(
                        FoodPromiseUtils.getInitials(name).toUpperCase() ?? '',
                        style: TextStyle(fontSize: width / 3),
                      ),
                    ));
              }

              return CachedNetworkImage(
                width: width,
                height: height,
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(
                  color: Theme.of(context).canvasColor,
                  width: 100,
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                ),
                errorWidget: (context, url, error) => Text('Error'),
              );
            },
          ),
        ),
      ),
    );
  }
}
