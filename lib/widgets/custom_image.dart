import 'package:flutter/material.dart';
class CustomImage extends StatefulWidget {
   CustomImage({
    Key? key,
    required this.label, required this.mainImageUrlsController,
  }) :  super(key: key);

  final TextEditingController mainImageUrlsController;
  final String label;

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
   String imageUrls ='';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10)
        ),
        child: TextField(
          controller: widget.mainImageUrlsController,
          decoration:  InputDecoration(
              label: Text(widget.label)
          ),
          onSubmitted: (value){
            setState(() {
              imageUrls = value;
            });

          },
        ),
      ),
    );
  }
}
