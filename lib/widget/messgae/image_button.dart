import 'package:flutter/material.dart';

class ImageButton extends StatefulWidget {
  final ImageProvider image;
  final Function onPressed;

  const ImageButton({
    Key key,
    this.onPressed,
    this.image,
  }) : super(key: key);

  @override
  _ImageButtonState createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        child: Image(
          image: widget.image,
          width: 35,
          height: 35,
        ),
      ),
    );
  }
}
