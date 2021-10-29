import 'package:mobx/mobx.dart';
part 'future_controller.g.dart';

class FutureController = _FutureControllerBase with _$FutureController;

abstract class _FutureControllerBase with Store {
  @observable
  var nomeFuture = ObservableFuture.value('');
  // ! formas diferentes de fazer
  // ObservableFuture<String> nomeFuture = Future.value('').asObservable();

  @action
  Future<void> buscarNome() async {
    // ! formas diferentes de fazer
    // nomeFuture = Future.delayed(const Duration(seconds: 2), () => 'Guilherme')
    //     .asObservable();

    final buscaNomeFuture =
        Future.delayed(const Duration(seconds: 2), () => 'Guilherme');
    // ! formas diferentes de fazer
    // nomeFuture = buscaNomeFuture.asObservable();
    nomeFuture = ObservableFuture(buscaNomeFuture);
    // ! formas diferentes de fazer
    // return 'Guilherme';
  }
}
