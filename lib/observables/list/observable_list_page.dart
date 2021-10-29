import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_imc/observables/list/observable_list_controller.dart';

class ObservableListPage extends StatelessWidget {
  ObservableListPage({Key? key}) : super(key: key);
  final controller = ObservableListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista MOBX'),
      ),
      body: Column(
        children: [
          Expanded(child: Observer(
            builder: (_) {
              return ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final productName = controller.products[index].name;
                  return CheckboxListTile(
                    value: false,
                    onChanged: (_) {},
                    title: Text(productName),
                  );
                },
              );
            },
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  controller.addProductor();
                },
                child: const Text('Adicionar'),
              ),
              TextButton(
                onPressed: () {
                  controller.removeProduct();
                },
                child: const Text('Remover'),
              ),
              TextButton(
                onPressed: () {
                  controller.loadProducts();
                },
                child: const Text('Carregar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}