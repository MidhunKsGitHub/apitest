import 'dart:convert';

import 'package:apitest/Pages/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Config/base_client.dart';
import '../Model/Product.dart';

class HomeProduct extends StatefulWidget {
  const HomeProduct({Key? key}) : super(key: key);

  @override
  State<HomeProduct> createState() => _HomeProductState();
}

class _HomeProductState extends State<HomeProduct> {
  String? base = "https://aryaas.hawkssolutions.com/basicapi/public/";
  String? data;
  List? productList;
  Product? product;
  Map? list;
  Map? list1;

  // Map? list2;
  List? listP;

  callAPIandAssignData() async {
    var response =
        await BaseClient().post('products/ByCombination').catchError((err) {});
    if (response != null) {
      debugPrint('api successful:');

      setState(() {
        data = response.toString();
        list = jsonDecode(response);
        list1 = list!["pagination"];
        listP = list1!["pageData"];

        Fluttertoast.showToast(
            msg: "Success ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else {
      debugPrint('api failed:');
      Fluttertoast.showToast(
          msg: "failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    callAPIandAssignData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.dark,
        ),
        title: Text(
          "ARYAAS",
          style:
              TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Icon(
            Icons.location_on,
            color: Colors.red,
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                      height: 45,
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              "Search for Restaurants,food and more",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            )
                          ]))),
            ],
          ),
          Expanded(
            child: ListView.builder(
              // itemCount: listP == null ? 0 : listP?.length,
              itemCount: listP == null ? 0 : listP?.length,
              itemBuilder: (context, index) => getRow(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget getRow(int index) {
    var image = base! + listP![index]["image"];
    var price = "₹ " + listP![index]["combinationPrice"].toString();
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductView(
                        text: listP![index]["combinationName"].toString(),
                        url: image,
                      )));
        },
        title: Column(

          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(60), // Image radius
                      child: Image.network(image),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),

                Expanded(

                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                    listP == null
                        ? Text("null data")
                        : Text(
                            listP![index]["combinationName"].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      listP![index]["description"].toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.red),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(
          Icons.emoji_food_beverage,
          color: Colors.green,
        ),
      ),
    );
  }
}
