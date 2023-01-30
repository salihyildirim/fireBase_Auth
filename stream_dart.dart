import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

main() {
  /*myStreamFunction().listen((event) {
    print(event);
  });*/
  functionForStreamController();
  _myStreamController.stream.listen(
    (event) {
      // burdaki event sink.add(x) ile gelen x'i dinliyor.
      print(event * 10);
    },
    onDone: () {
      print('bitti');
    },
    onError: (error) {
      print(error);
    },
    cancelOnError: true,
  ); // hata verdiğinde dinlemeyi kes. ! ! abonelikten çık !

  // BURADAN AŞAĞISI EXPCEPTİON İLE İLGİLİ FARKLI KONU

  try {
    birFonksiyon(150);
  } on ExceptionA {
    print("A TİPİ BİR HATA YAKALANDI");
  } on ExceptionB {
    print("B TİPİ BİR HATA YAKALANDI");
  } catch (e) {
    print(e);
  } finally {
    print('HER DURUMDA ÇALIŞIR');
  }
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

// BURADAN AŞAĞISI EXCEPTION ILE ILGILI BİR KONU

void birFonksiyon(int numara) {
  if (numara < 100) {
    print("Numara OKEY");
  } else if (numara > 100 && numara < 200) {
    throw ExceptionA();
  } else if (numara > 200 && numara < 300) {
    throw ExceptionB();
  } else {
    Exception("Farklı bir hata");
  }
}

void araFonksiyon() {
  try {
    birFonksiyon(150);
  } catch (e) {
    print('Ara Fonksiyon hata yakaldı $e');
    rethrow; // BU FONKSİYONU KİM ÇAĞIRIYORSA ONA DA HATAYI GÖNDERİR e' yi gönderir yani
  }
}

class ExceptionA implements Exception {}

class ExceptionB implements Exception {}
