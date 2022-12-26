import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class EmailSignInPage extends StatefulWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  State<EmailSignInPage> createState() => _EmailSignInPageState();
}

enum FormStatus { signIn, register }

class _EmailSignInPageState extends State<EmailSignInPage> {
  FormStatus _formStatus = FormStatus.signIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _formStatus == FormStatus.signIn
            ? buildSignInForm()
            : buildRegisterForm(),
      ),
    );
  }

  Widget buildSignInForm() {
    final _signInFormKey = GlobalKey<FormState>();

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
              onPressed: () {
                print(_signInFormKey.currentState?.validate());
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
            )
          ],
        ),
      ),
    );
  }

  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();

  Widget buildRegisterForm() {
    final _registerFormKey = GlobalKey<FormState>();

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
              onPressed: () {
                if (_registerFormKey.currentState!.validate()) {
                  final user = Provider.of<Auth>(context, listen: false)
                      .createCreateUserWithEmailAndPassword(
                          controllerEmail, controllerPassword);
                } else {}
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
}
