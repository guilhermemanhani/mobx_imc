import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_imc/imc/imc_controller.dart';
import 'package:mobx_imc/widget/imc_gauge.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({Key? key}) : super(key: key);

  @override
  _ImcPageState createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  final controller = ImcController();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var imc = 0.0;
  final reactionDisposer = <ReactionDisposer>[];

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    // controller.dispose();
    super.dispose();
    // ignore: avoid_function_literals_in_foreach_calls
    reactionDisposer.forEach((reactionDisposer) => reactionDisposer());
  }

  @override
  void initState() {
    super.initState();
    final reactionErrorDisposer = reaction<bool>(
      (_) => controller.hasError,
      (hasErro) {
        if (hasErro) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(controller.error ?? 'Erro!!!'),
            ),
          );
        }
      },
    );
    reactionDisposer.add(reactionErrorDisposer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeNoitifier'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Observer(
                  builder: (_) {
                    return ImcGauge(imc: controller.imc);
                  },
                ),
                // AnimatedBuilder(
                //   animation: controller,
                //   builder: (context, child) {
                //     return ImcGauge(
                //       imc: controller.imc,
                //     );
                //   },
                // ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: pesoEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Peso'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      turnOffGrouping: true,
                      decimalDigits: 2,
                    ),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Peso obrigat??rio';
                    }
                  },
                ),
                TextFormField(
                  controller: alturaEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Altura'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      turnOffGrouping: true,
                      decimalDigits: 2,
                    ),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Altura obrigat??ria';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    var formValid = formKey.currentState?.validate() ?? false;
                    if (formValid) {
                      var formatter = NumberFormat.simpleCurrency(
                          locale: 'pt_BR', decimalDigits: 2);
                      double peso = formatter.parse(pesoEC.text) as double;
                      double altura = formatter.parse(alturaEC.text) as double;
                      controller.calcularImc(peso: peso, altura: altura);
                    }
                  },
                  child: const Text('Calcular IMC'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
