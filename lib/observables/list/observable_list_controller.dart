import 'package:mobx/mobx.dart';
import 'package:mobx_imc/model/product_model.dart';
part 'observable_list_controller.g.dart';

class ObservableListController = _ObservableListControllerBase
    with _$ObservableListController;

abstract class _ObservableListControllerBase with Store {
  // @observable
  // var products = <ProductModel>[];

  // @action
  // void loadProducts() {
  //   var productsData = [
  //     ProductModel(name: 'Computador'),
  //     ProductModel(name: 'Celular'),
  //     ProductModel(name: 'Teclado'),
  //     ProductModel(name: 'Mouse'),
  //   ];
  //   products = productsData;
  // }

  // formas diferentes
  // @observable
  // ObservableList products = ObservableList();
  @observable
  var products = <ProductModel>[].asObservable();

  @action
  void loadProducts() {
    products.addAll([
      ProductModel(name: 'Computador'),
      ProductModel(name: 'Celular'),
      ProductModel(name: 'Teclado'),
      ProductModel(name: 'Mouse'),
    ]);
  }

  @action
  void addProductor() {
    products.add(ProductModel(name: 'Computador'));
  }

  @action
  void removeProduct() {
    products.removeAt(0);
  }
}
