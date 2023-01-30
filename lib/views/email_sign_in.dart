import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class EmailSignInPage extends StatefulWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  State<EmailSignInPage> createState() => _EmailSignInPageState();
}

enum FormStatus { signIn, register, reset }

class _EmailSignInPageState extends State<EmailSignInPage> {
  FormStatus _formStatus = FormStatus.signIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _formStatus == FormStatus.signIn
            ? buildSignInForm()
            : _formStatus == FormStatus.register
                ? buildRegisterForm()
                : buildResetInForm(),
      ),
    );
  }

  Widget buildSignInForm() {
    final _signInFormKey = GlobalKey<FormState>();
    TextEditingController controllerMail = new TextEditingController();
    TextEditingController controllerSifre = new TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        // TUM YAPIYI FORM WIDGETI ILE SARMALADIK FORM VALDITION YAPABİLİRİZ
        key: _signInFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LÜTFEN GİRİŞ YAPINIZ.",
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              controller: controllerMail,
              validator: (value) {
                if (!EmailValidator.validate(value.toString())) {
                  return 'Lütfen Geçerli bir adres giriniz!';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "E-mail",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            TextFormField(
              controller: controllerSifre,
              validator: (value) {
                if (value.toString().length < 6) {
                  return 'Lütfen en az 6 haneli bir şifre giriniz.';
                } else
                  return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: "Şifre",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_signInFormKey.currentState!.validate()) {
                  final user = await Provider.of<Auth>(context, listen: false)
                      .signInUserWithEmailAndPassword(
                          controllerMail.text, controllerSifre.text);
                  if (!user!.emailVerified) {
                    await _showMyDialog();
                    await Provider.of<Auth>(context, listen: false).signOut();
                  }
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Giriş",
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _formStatus = FormStatus.register;
                });
              },
              child: Text("Yeni Kayıt İçin Tıklayınız.",
                  style: TextStyle(fontSize: 16)),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    _formStatus = FormStatus.reset;
                  });
                },
                child: Text("Şifrenizi mi Unuttunuz ?"))
          ],
        ),
      ),
    );
  }

  Widget buildResetInForm() {
    final _resetFormKey = GlobalKey<FormState>();
    TextEditingController controllerMail = new TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        // TUM YAPIYI FORM WIDGETI ILE SARMALADIK FORM VALDITION YAPABİLİRİZ
        key: _resetFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ŞİFRE YENİLEME",
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              controller: controllerMail,
              validator: (value) {
                if (!EmailValidator.validate(value.toString())) {
                  return 'Lütfen Geçerli bir adres giriniz!';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "E-mail",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_resetFormKey.currentState!.validate()) {
                  await Provider.of<Auth>(context, listen: false)
                      .sendPasswordResetEmail(controllerMail.text);
                  await _showResetDialog();
                  Navigator.pop(context);
                }
              },
              child: Text(
                "GÖNDER",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRegisterForm() {
    final _registerFormKey = GlobalKey<FormState>();
    TextEditingController controllerPassword = new TextEditingController();
    TextEditingController controllerEmail = new TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key:
            _registerFormKey, // bütün formdaki elemanların validate'lerini kontrol eder.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "KAYIT FORMU",
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              controller: controllerEmail,
              validator: (value) {
                if (!EmailValidator.validate(value.toString())) {
                  return 'Lütfen Geçerli bir adres giriniz!';
                } else
                  return null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "E-mail",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            TextFormField(
              controller: controllerPassword,
              validator: (value) {
                if (value.toString().length < 6) {
                  return 'Lütfen En az 6 haneli bir şifre giriniz';
                }
              },
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: "Şifre",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (controllerPassword.text == value) {
                  return null;
                } else {
                  return 'Şifreleriniz uyuşmamaktadır.';
                }
              },
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: "Şifrenizi tekrar giriniz",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  if (_registerFormKey.currentState!.validate()) {
                    // bütün form elemanları okey verdiyse yani verilen kurallar tamamsa
                    final user = await Provider.of<Auth>(context, listen: false)
                        .createCreateUserWithEmailAndPassword(
                            controllerEmail.text, controllerPassword.text);
                    print(user?.uid);

                    if (!user!.emailVerified) {
                      await user.sendEmailVerification();
                    }
                    _showMyDialog();
                    await Provider.of<Auth>(context, listen: false).signOut();

                    setState(() {
                      _formStatus = FormStatus.signIn;
                    });
                  }
                } on FirebaseAuthException catch (e) {
                  print("kayıt problemi oluştu : ${e.message}");
                }
              },
              child: Text(
                "KAYIT OL",
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _formStatus = FormStatus.signIn;
                });
              },
              child: Text("Zaten Üye Misiniz?", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Onay Gerekiyor !'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Merhaba Lütfen Mail adresinizi kontrol ediniz.'),
                Text(
                    'Mailinizi onayladıktan sonra tekrar giriş yapabilirsiniz.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ANLADIM.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showResetDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ŞİFRE DEĞİŞİKLİĞİ GÖNDERİLDİ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Merhaba Lütfen Mail adresinizi kontrol ediniz.'),
                Text(
                    'Şifrenizi değiştirdikten sonra sonra tekrar giriş yapabilirsiniz.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ANLADIM.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
