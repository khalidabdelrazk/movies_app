import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
    this.image, {
    super.key,
    this.width = 100,
    this.height = 100,
    this.bgColor,
    this.borderWidth = 0,
    this.borderColor,
    this.trBackground = false,
    this.fit = BoxFit.cover,
    this.isNetwork = true,
    this.radius = 50,
    this.isShadow = true,
  });
  final String image;
  final double width;
  final double height;
  final double borderWidth;
  final bool isShadow;
  final Color? borderColor;
  final Color? bgColor;
  final bool trBackground;
  final bool isNetwork;
  final double radius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final isValidUrl =
        image.startsWith('http://') || image.startsWith('https://');

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          if (isShadow)
            const BoxShadow(
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
        ],
      ),
      child: isNetwork
          ? (isValidUrl
              ? CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: fit,
                      ),
                    ),
                  ),
                )
              : const Icon(Icons.broken_image)) // fallback if URL is invalid
          : Image(image: AssetImage(image), fit: fit),
    );
  }
}

class BlankImageWidget extends StatefulWidget {
  const BlankImageWidget({super.key});

  @override
  BlankImageWidgetState createState() => BlankImageWidgetState();
}

class BlankImageWidgetState extends State<BlankImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Center(
        child: SizedBox(
          child: Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            elevation: 0.0,
          ),
        ),
      ),
    );
  }
}
