import 'package:flutter/material.dart';
import 'package:preguntame/main.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

/* void main() => runApp(const Login()); */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://cmlennssxegtkemyqpda.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNtbGVubnNzeGVndGtlbXlxcGRhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTE1NDg4MDQsImV4cCI6MjAyNzEyNDgwNH0.qY8wkhs-JPlm6Ahwtd-QHBMvvLkzumn5uTIQbkhm2RM',
  );
  runApp(user());
// ignore: camel_case_types
}

class user extends StatelessWidget {
  user({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: NewUser());
  }
}

//final _stream = Supabase.instance.client;
TextEditingController correo = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController username = TextEditingController();

class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  State<NewUser> createState() => _loginState();
}

class _loginState extends State<NewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 50),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromRGBO(0, 0, 0, 120),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      tooltip: 'Volver',
                      icon: const Icon(
                        Icons.chevron_left_outlined,
                        size: 80,
                      ),
                    ),
                  ],
                ),
                const Center(
                    child: Icon(
                  Icons.person_pin,
                  size: 120,
                  color: Colors.white60,
                )),
              ],
            ),
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
                    "Nuevo Usuario",
                    style: TextStyle(
                        fontFamily: "Minecraft",
                        fontSize: 28,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Expanded(
                      child: TextField(
                        controller: username,
                        autocorrect: true,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2)),
                            hintStyle: const TextStyle(color: Colors.white),
                            hintText: "Nombre de usuario",
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
                          fixedSize: const Size(150, 80),
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: const Color.fromARGB(0, 0, 0, 120)),
                      onPressed: () {
                        setState(() {
                          _Buscar(context, correo, password, username);
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<void> _Buscar(BuildContext context, TextEditingController correo,
    TextEditingController password, TextEditingController username) async {
  final supabase = Supabase.instance.client;
  final _usuario = await supabase
      .from('usuario')
      .select()
      .eq('nombre_usuario', username.text.toString());
  final _correo = await supabase
      .from('usuario')
      .select()
      .eq('correo', correo.text.toString());

  // final _insercion = Supabase.instance.client;

  final response = await supabase.from('usuario').insert([
    {
      'correo': correo.text,
      'contraseña': password.text,
      'nombre_usuario': username.text,
      'status': 'Activo',
    }
  ]);
  correo.clear();
  password.clear();
  username.clear();
  Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const Login()));
}
