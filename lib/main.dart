import 'package:flutter/material.dart';
import 'package:preguntame/pages/menu.dart';
import 'package:preguntame/pages/newUser.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/* void main() => runApp(const Login()); */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://cmlennssxegtkemyqpda.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNtbGVubnNzeGVndGtlbXlxcGRhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTE1NDg4MDQsImV4cCI6MjAyNzEyNDgwNH0.qY8wkhs-JPlm6Ahwtd-QHBMvvLkzumn5uTIQbkhm2RM',
  );
  runApp(const Login());
// ignore: camel_case_types
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: login());
  }
}

final _stream = Supabase.instance.client;
TextEditingController correo = TextEditingController();
TextEditingController password = TextEditingController();

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool _ispressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 50),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromRGBO(0, 0, 0, 120),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: const Center(
                child: Icon(
              Icons.person_pin,
              size: 120,
              color: Colors.white60,
            )),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 11),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(
                    0, 0, 0, 120), /*Color.fromARGB(0, 0, 0, 80)*/
              ),
              width: MediaQuery.of(context).size.width / 1.40,
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Inicie Sesion",
                    style: TextStyle(
                        fontFamily: "Minecraft",
                        fontSize: 28,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Expanded(
                      child: TextField(
                        controller: correo,
                        autocorrect: true,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2)),
                            hintStyle: const TextStyle(color: Colors.white),
                            hintText: "Correo electronico",
                            labelStyle: const TextStyle(
                                fontFamily: "Minecraft", fontSize: 16),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2))),
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Minecraft",
                            fontSize: 18),
                        cursorColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Expanded(
                      child: TextField(
                        controller: password,
                        obscureText: true,
                        autocorrect: true,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.security),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2)),
                            hintStyle: const TextStyle(color: Colors.white),
                            hintText: "Contraseña",
                            labelStyle: const TextStyle(
                                fontFamily: "Minecraft", fontSize: 16),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2))),
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Minecraft",
                            fontSize: 18),
                        cursorColor: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(150, 80),
                          side: BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Color.fromARGB(0, 0, 0, 120)),
                      onPressed: () {
                        setState(() {
                          _buscar(context, correo, password);
                        });
                        /*  final supabase = Supabase.instance.client;
                        final _Correo = await supabase
                            .from('usuario')
                            .select()
                            .eq('correo', correo)
                            .eq('contraseña', password)
                            .single();
                        debugPrint(_Correo.toString());
                        if (_Correo.isNotEmpty) {
                          debugPrint("Usuario si existeeeee");

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => menu()));
                        } else {
                          debugPrint("Usuario no existeeeee");
                        } */

                        //_buscar(correo.toString(), password.toString());
                      },
                      child: const Text(
                        "Aceptar",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      )),
                  GestureDetector(
                    onTapDown: (details) => setState(() {
                      _ispressed = true;
                    }),
                    onTapUp: (details) => setState(() {
                      _ispressed = false;
                    }),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => (user())));
                    },
                    child: Text(
                      "No tienes cuenta? registrate aqui",
                      style: TextStyle(
                          color: _ispressed ? Colors.grey : Colors.white,
                          decoration: TextDecoration.underline,
                          fontFamily: "Minecraft",
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void mensaje(BuildContext context, final mensaje) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(mensaje),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Aceptar"))
        ],
      );
    },
  );
}

Future<void> _buscar(BuildContext context, TextEditingController correo,
    TextEditingController password) async {
  String Mensaje = "";
  final supabase = Supabase.instance.client;
  final _Correo = await supabase.from('usuario').select();
  int i = 0;
  bool xd = true;

  final usuario = _Correo.toList();
  int id_usuario = 0;
  while (xd == true) {
    try {
      if (usuario[i]['correo'].toString() == correo.text.toString() &&
          usuario[i]['contraseña'].toString() == password.text.toString()) {
        id_usuario = int.parse(usuario[i]['id'].toString());

        xd = false;
      } else {
        xd = true;
        i++;
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Correo o contraseña incorrectos"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Aceptar"))
            ],
          );
        },
      );

      break;
    }
  }
  if (xd == false) {
    Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
            builder: (context) => Menu(
                  id_usuario: id_usuario,
                )));
  }
}
