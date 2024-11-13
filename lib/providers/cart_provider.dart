import 'package:riverpod_files/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  //initial value
  @override
  Set<Product> build() {
    return const {};
  }

  //method to update the state
  void addProduct(Product product) {
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

  //remove items from state
  void removeProduct(Product product) {
    if (state.contains(product)) {
      state = state.where((p) => p.id != product.id).toSet();
    }
  }
}

//dependent provider
@riverpod
int cartTotal(ref) {
  //watching another state
  final cartProducts = ref.watch(cartNotifierProvider);

  int total = 0;
  for (Product product in cartProducts) {
    total += product.price;
  }
  return total;
}
