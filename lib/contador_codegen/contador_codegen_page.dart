// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_imc/contador_codegen/contador_codegen_controller.dart';

class ContadorCodegenPage extends StatefulWidget {
  const ContadorCodegenPage({Key? key}) : super(key: key);

  @override
  State<ContadorCodegenPage> createState() => _ContadorCodegenPageState();
}

class _ContadorCodegenPageState extends State<ContadorCodegenPage> {
  final controller = ContadorCodegenController();
  final reactionDisposer = <ReactionDisposer>[];

  @override
  void initState() {
    super.initState();
    // autorun fuca escutando as variaves que estao sendo usadas dentro dele
    // e tambem roda logo quando criado!!!
    final autorunDisposer = autorun((_) {
      print('---------------- auto run -----------------------');
      print(controller.fullName.first);
    });

    // reactuon nos falamos para o mox qual o antributo observavel que queremos observar!!!!
    final reactionDis = reaction((_) => controller.counter, (counter) {
      print('---------------- reaction -----------------------');
      print(counter);
    });

    // Disparado apenas uma vez if que se executa apenas uma vez
    final whenDisposer =
        when((_) => controller.fullName.first == 'Guilherme', () {
      print('---------------- when -----------------------');
      print(controller.fullName.first);
    });
    reactionDisposer.add(autorunDisposer);
    reactionDisposer.add(reactionDis);
    reactionDisposer.add(whenDisposer);
  }

  @override
  void dispose() {
    super.dispose();
    reactionDisposer.forEach((element) => element());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador CodeGen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Observer(
              builder: (_) {
                return Text(
                  '${controller.counter}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            Observer(
              builder: (_) {
                return Text(controller.fullName.first);
              },
            ),
            Observer(
              builder: (_) {
                return Text(controller.fullName.last);
              },
            ),
            Observer(
              builder: (_) {
                return Text(controller.saudacao);
              },
            ),
            TextButton(
              onPressed: () => controller.changeName(),
              child: const Text('Change name'),
            ),
            TextButton(
              onPressed: () => controller.roolbackName(),
              child: const Text('Rollback name'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
