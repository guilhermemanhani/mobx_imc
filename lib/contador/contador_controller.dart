import 'package:mobx/mobx.dart';
import 'package:mobx_imc/model/full_name.dart';

class ContadorController {
  final _counter = Observable<int>(0, name: 'counter observable');
  final _fullName =
      Observable<FullName>(FullName(first: 'first', last: 'last'));
  late Action increment;
  late Computed _saudacaoComputed;

  ContadorController() {
    increment = Action(_incrementCounter);
    _saudacaoComputed =
        Computed(() => 'Olá ${_fullName.value.first} ${_counter.value}');
  }

  int get counter => _counter.value;
  FullName get fullName => _fullName.value;

  String get saudacao => _saudacaoComputed.value;

  void _incrementCounter() {
    _counter.value++;
    // ignore: avoid_print
    print('Antes');
    // ignore: avoid_print
    print(_fullName.value.hashCode);
    // ! Não pode fazer isso aqui
    // _fullName.value.first = 'Guilherme';
    // _fullName.value.last = 'Manhani';
    // !Trocar isso
    // _fullName.value = FullName(first: 'Guilherme', last: 'Manhani');
    // !Por:
    _fullName.value = _fullName.value.copyWith(first: 'Gui', last: 'Rocha');

    // ignore: avoid_print
    print(_fullName.value.hashCode);
  }
}
