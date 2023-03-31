import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductView extends StatefulWidget {
  final String text;
  final String url;

  ProductView({Key? key, required this.text, required this.url})
      : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.text),
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
            ClipRRect(
            borderRadius: BorderRadius.circular(20), // Image border
      child: SizedBox.fromSize(
        size: Size.fromRadius(48), // Image radius
        child: Image.network(widget.url, fit: BoxFit.cover),
      ),
    ),

    SizedBox(
                  width: 10,
                ),
                Text("${widget.text}"),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
