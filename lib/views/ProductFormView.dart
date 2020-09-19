import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:einstein_flutter_p1/models/Product.dart';
import 'package:einstein_flutter_p1/providers/ProductsProvider.dart';
import 'package:einstein_flutter_p1/helpers/moneyFormat.dart';

class ProductFormView extends StatefulWidget {
  @override
  _ProductFormView createState() => _ProductFormView();
}

class _ProductFormView extends State<ProductFormView> {
  final _form = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {};

  String title = "Adicionar produto";

  void _loadFormData(Product product) {
    if (product != null) {
      _formData['id'] = product.id;
      _formData['name'] = product.name;
      _formData['priceString'] = moneyFormat(product.price);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Product _product = ModalRoute.of(context).settings.arguments as Product;
    _loadFormData(_product);

    if (_product != null) {
      this.title = "Editar produto";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Nome do produto'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Campo obrigatório';
                  }

                  if (value.trim().length < 3) {
                    return 'Mínimo de 3 caracteres';
                  }

                  return null;
                },
                onSaved: (value) => _formData['name'] = value,
              ),
              TextFormField(
                initialValue: _formData['priceString'],
                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                decoration: InputDecoration(labelText: 'Valor R\$'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Campo obrigatório';
                  }

                  if (double.parse(value.replaceAll(',', '.').trim()) == 0.0) {
                    return 'Valor não pode ser zero';
                  }

                  return null;
                },
                onSaved: (value) {
                  _formData['priceString'] = value;
                  _formData['price'] = double.parse(value.replaceAll(',', '.').trim());
                },
              ),
              Spacer(),
              RaisedButton(
                padding: const EdgeInsets.only(top: 12.0, right: 36.0, bottom: 12.0, left: 36.0),
                child: const Text(
                  'Salvar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                color: Colors.deepOrange,
                textColor: Colors.white,
                onPressed: () {
                  final isValid = _form.currentState.validate();

                  if (isValid) {
                    _form.currentState.save();

                    Provider.of<ProductsProvider>(context, listen: false).save(
                      Product(
                        id: _formData['id'],
                        name: _formData['name'],
                        price: _formData['price'],
                      ),
                    );
                    Navigator.of(context).pop();
                  }
                },
              ),
              SizedBox(height: 10),
              FlatButton(
                child: const Text('Cancelar'),
                color: Colors.white,
                textColor: Colors.orange,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
