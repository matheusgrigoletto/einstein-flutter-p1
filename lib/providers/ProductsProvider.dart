import 'package:flutter/material.dart';
import 'package:einstein_flutter_p1/models/Product.dart';
import 'package:einstein_flutter_p1/data/mockdata.dart';

class ProductsProvider with ChangeNotifier {
  final Map<int, Product> _items = {...MOCK_DATA };

  int get count => _items.length;

  double get total {
    double t = 0.0;
    _items.values.forEach((Product p) => t += p.price);
    return t;
  }

  Product byIndex(int index) => _items.values.elementAt(index);

  void _update(Product product) {
    _items.update(product.id, (_) => product);
  }

  int _generateId() {
    int id = 1;
    if (this.count > 0) {
      id = _items.values.last.id + 1;
    }
    return id;
  }

  void _create(Product product) {
    final int id = this._generateId();

    _items.putIfAbsent(id, () => Product(
      id: id,
      name: product.name,
      price: product.price,
    ));
  }

  void save(Product product) {
    if (product == null) {
      return;
    }

    if (product.id != null && _items.containsKey(product.id)) {
      this._update(product);
    } else {
      this._create(product);
    }

    notifyListeners();
  }

  void destroy(Product product) {
    if (product != null && product.id != null) {
      _items.remove(product.id);
      notifyListeners();
    }
  }
}