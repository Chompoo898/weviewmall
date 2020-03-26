import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weviewmall/models/product_model.dart';

class ShowListProduct extends StatefulWidget {
  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {


  // Field
  List<ProductModel> productModels = List();

  //Method
  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Product');
    await collectionReference.snapshots().listen(
      (response) {
        List<DocumentSnapshot> snapshots = response.documents;
        for (var snapshot in snapshots) {
          print('snapshot = $snapshot');
          print('Name = ${snapshot.data['Name']}');

          ProductModel productModel = ProductModel.fromMap(snapshot.data);
          setState(
            () {
              productModels.add(productModel);
            },
          );
        }
      },
    );
  }

  Widget showImage(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(productModels[index].pathImage),
    );
  }

  Widget showName(int index){
    return Text(productModels[index].name);
  }

  Widget showText(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(children: <Widget>[showName(index),],),
    );
  }

  Widget showListView(int index) {
    return Row(
      children: <Widget>[
        showImage(index),
        showText(index),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return showListView(index);
        },
      ),
    );
  }
}
