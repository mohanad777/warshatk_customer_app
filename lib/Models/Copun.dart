class Coupn {
  int _id;

  int get id => _id;

  set id(int id) {
    _id = id;
  }
  String _name;

  String get name => _name;

  set name(String name) {
    _name = name;
  }
  DateTime _expireDate;

  DateTime get expireDate => _expireDate;

  set expireDate(DateTime expireDate) {
    _expireDate = expireDate;
  }
  double _discount;

  double get discount => _discount;

  set discount(double discount) {
    _discount = discount;
  }
  Coupn(this._id, this._name, this._discount);
}
