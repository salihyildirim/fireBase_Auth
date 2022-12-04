import 'dart:async';

main() {
  /*myStreamFunction().listen((event) {
    print(event);
  });*/
  functionForStreamController();
  _myStreamController.stream.listen((event) {
    // burdaki event sink.add(x) ile gelen x'i dinliyor.
    print(event * 10);
  }, onDone: () {
    print('bitti');
  }, onError: (error) {
    print(error);
  }, cancelOnError: true// hata verdiğinde dinlemeyi kes. ! ! abonelikten çık !);
}

StreamController _myStreamController = StreamController();

void functionForStreamController() async {
  for (int i = 0; i < 10; i++) {
    if (i == 5) {
      _myStreamController
          .addError('5 oldu hata !'); //şartlı hata ekledik streame
    }
    await Future.delayed(Duration(seconds: 1));

    _myStreamController.sink
        .add(i + 1); // streamin akışını başlatmış oluyosun bununla artık açık.
  }
  _myStreamController.close(); // streami kapattın.
}

/*Stream<int> myStreamFunction() async* {
  for (int i = 0; i < 10; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i + 1;
  }
}*/
