import 'package:chat_app/providers/userAdons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  @override

  // void initState() {
  //   Future.delayed(Duration.zero).then((value) {
  //     Provider.of<Products>(context, listen: false).searchProds();
  //   });
  //   super.initState();
  // }

  Widget build(BuildContext context) {
    final searchData = Provider.of<UserAdons>(context).sitems;

    return Scaffold(
        appBar: AppBar(
          title: Text("Search Result : ${searchData.length} items found"),
        ),
        body: ListView.builder(
            itemCount: searchData.length,
            itemBuilder: (BuildContext context, int index) {
              return SearchedProduct(prodsData[index].id, prodsData[index].name,
                  prodsData[index].price, "assets/images/gaminglaptop.jpg");
            }));
  }
}
