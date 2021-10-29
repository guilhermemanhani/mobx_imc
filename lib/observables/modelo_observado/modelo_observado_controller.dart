import 'package:mobx/mobx.dart';
import 'package:mobx_imc/model/product_model.dart';
import 'package:mobx_imc/observables/modelo_observado/model/product_store.dart';
part 'modelo_observado_controller.g.dart';

class ModeloObservadoController = _ModeloObservadoControllerBase
    with _$ModeloObservadoController;

abstract class _ModeloObservadoControllerBase with Store {
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
  var products = <ProductStore>[].asObservable();

  @action
  void loadProducts() {
    products.addAll([
      ProductStore(product: ProductModel(name: 'Computador'), selected: false),
      ProductStore(product: ProductModel(name: 'Celular'), selected: false),
      ProductStore(product: ProductModel(name: 'Teclado'), selected: false),
      ProductStore(product: ProductModel(name: 'Mouse'), selected: false),
    ]);
  }

  @action
  void addProductor() {
    products.add(
      ProductStore(product: ProductModel(name: 'Mouse'), selected: false),
    );
  }

  @action
  void removeProduct() {
    products.removeAt(0);
  }

  @action
  void selectedProduct(int index) {
    var productSelected = products[index].selected;
    products[index].selected = !productSelected;
  }
}
