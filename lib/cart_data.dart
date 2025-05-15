import 'cart_model.dart';

class CartData {
  static final List<CartItem> _cartItems = [];

  static List<CartItem> get items => _cartItems;

  static void addItem(CartItem item) {
    _cartItems.add(item);
  }

  static void removeItem(CartItem item) {
    _cartItems.remove(item);
  }

  static void clearCart() {
    _cartItems.clear();
  }
}
