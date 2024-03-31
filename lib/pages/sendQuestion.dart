import 'package:flutter/material.dart';
import 'package:preguntame/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  runApp(Mensaje(id_usuario: 0));
}

TextEditingController mensaje = TextEditingController();
TextEditingController titulo = TextEditingController();

class Mensaje extends StatelessWidget {
  int id_usuario;
  Mensaje({super.key, required this.id_usuario});

  @override
  Widget build(BuildContext context) {
    return Home(
      id_usuario: 0,
    );
  }
}

class Home extends StatefulWidget {
  int id_usuario;
  Home({super.key, required this.id_usuario});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 40),
          body: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    tooltip: 'Volver',
                    icon: const Icon(
                      Icons.chevron_left_outlined,
                      size: 80,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width / 14,
                    left: MediaQuery.of(context).size.width / 14,
                    top: MediaQuery.of(context).size.height / 10),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: titulo,
                          autocorrect: true,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2)),
                              hintStyle: const TextStyle(color: Colors.white),
                              hintText: "Coloque el titulo de su mensaje",
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
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width / 14,
                    left: MediaQuery.of(context).size.width / 14,
                    top: MediaQuery.of(context).size.height / 10),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: mensaje,
                          autocorrect: true,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2)),
                              hintStyle: const TextStyle(color: Colors.white),
                              hintText: "Escriba su mensaje",
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
                      IconButton(
                          onPressed: () async {
                            final _insercion = Supabase.instance.client;

                            final response =
                                await _insercion.from('pregunta').insert([
                              {
                                'titulo': titulo.text,
                                'descripcion': mensaje.text,
                                'id_usuario': widget.id_usuario,
                                'status': 'Activo',
                              }
                            ]);
                            titulo.clear();
                            mensaje.clear();
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.send,
                            size: 45,
                          )),
                    ],
                  ),
                ),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
