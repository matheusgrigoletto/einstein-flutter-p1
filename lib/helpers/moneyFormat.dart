String moneyFormat(double n) {
  return n.toStringAsFixed(2).replaceAll('.', ',');
}
