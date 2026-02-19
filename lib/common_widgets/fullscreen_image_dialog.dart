import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenImageDialog extends StatelessWidget {
  final List<dynamic> images;
  final int initialIndex;

  const FullScreenImageDialog({super.key, required this.images, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black, // Fullscreen effect
      insetPadding: EdgeInsets.zero, // Remove default padding
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: images.length,
            pageController: PageController(initialPage: initialIndex),
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(images[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            backgroundDecoration: BoxDecoration(color: Colors.black),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
