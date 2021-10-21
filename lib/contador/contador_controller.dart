import 'package:mobx/mobx.dart';

class ContadorController {
  var _counter = Observable<int>(0, name: 'counter observable');
  var _fullName = Observable<FullName>(FullName(first: 'first', last: 'last'));
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

class FullName {
  String first;
  String last;

  FullName({
    required this.first,
    required this.last,
  });

  FullName copyWith({
    String? first,
    String? last,
  }) {
    return FullName(
      first: first ?? this.first,
      last: last ?? this.last,
    );
  }
}
