import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:einstein_flutter_p1/components/ProductTile.dart';
import 'package:einstein_flutter_p1/providers/ProductsProvider.dart';
import 'package:einstein_flutter_p1/routes/AppRoutes.dart';
import 'package:einstein_flutter_p1/helpers/moneyFormat.dart';

class ProductListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsProvider products = Provider.of<ProductsProvider>(context);

    String total = moneyFormat(products.total);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus produtos'),
        centerTitle: false,
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(4),
                    itemCount: products.count,
                    itemBuilder: (ctx, i) => ProductTile(products.byIndex(i)),
                    separatorBuilder: (BuildContext ctx, int index) => const Divider(),
                  ),
              ),
              Divider(height: 20, thickness: 2),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Subtotal\n',
                          style: TextStyle(
                            fontSize: 20,
                            height: 0.52,
                          ),
                        ),
                        Text(
                          'R\$ $total',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 16)
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.FORM);
        },
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        tooltip: 'Adicionar produto',
        child: Icon(Icons.add),
      ),
    );
  }
}