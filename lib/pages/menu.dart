import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preguntame/pages/newUser.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'sendQuestion.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(menu(text: 0));

// ignore: must_be_immutable, camel_case_types
class menu extends StatelessWidget {
  int text;
  menu({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Menu(
      id_usuario: text,
    );
  }
}

final xd = Supabase.instance.client
    .from("usuario")
    .select()
    .order('id', ascending: true);
final _stream = Supabase.instance.client
    .from('pregunta')
    .stream(primaryKey: ['id']).order('fecha_envio', ascending: false);

// ignore: must_be_immutable
class Menu extends StatefulWidget {
  // ignore: non_constant_identifier_names
  int id_usuario;
  // ignore: non_constant_identifier_names
  Menu({super.key, required this.id_usuario});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* routes: {
        '/': (context) => const MyApp(),
        '/menu': (context) => const menu(),
        '/send': (context) => const Mensaje(),
      }, */
      title: 'Menu',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 40),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 15,
                      left: MediaQuery.of(context).size.width / 15),
                  child: Text(
                    "¿Necesitas ayuda en algo? \n ¡No dudes en preguntar!",
                    style: TextStyle(
                        color: Colors.green[200],
                        fontSize: 22,
                        fontFamily: "Minecraft"),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 14,
                      left: MediaQuery.of(context).size.width / 3),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[
                          700], /*borderRadius: BorderRadius.circular(20)*/
                    ),
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height / 8,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(
                                id_usuario: widget.id_usuario,
                              ),
                            ));

                        //_showMainPage(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16.0)),
                      child: const Center(
                        child: Text(
                          "Hacer\npregunta",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "Minecraft",
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ), /* 
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 14,
                      left: MediaQuery.of(context).size.width / 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[
                          700], /*borderRadius: BorderRadius.circular(20)*/
                    ),
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height / 8,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login())),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16.0)),
                      child: const Text(
                        "Responder\npreguntas",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Minecraft",
                            fontSize: 28),
                      ),
                    ),
                  ),
                ), */
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 17,
                  left: MediaQuery.of(context).size.width / 10),
              child: const Text(
                "Preguntas agregadas recientemente",
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: "Minecraft",
                  fontSize: 22,
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 26),
              child: StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final preguntas = snapshot.data!;

                    return SizedBox(
                      width: MediaQuery.of(context).size.width / 1.05,
                      height: MediaQuery.of(context).size.height / 2,
                      child: ListView.builder(
                          //shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: preguntas.length,
                          itemBuilder: (context, index) {
                            final pregunta = preguntas[index];
                            final double xds;
                            if (pregunta['descripcion'].toString().length >=
                                286) {
                              xds = pregunta['descripcion'].toString().length -
                                  50;
                            } else {
                              xds = 200;
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: itemlist(
                                pregunta: pregunta,
                                xds: xds,
                              ),
                            );
                          }),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class itemlist extends StatelessWidget {
  const itemlist({super.key, required this.pregunta, this.xds});
  // ignore: prefer_typing_uninitialized_variables
  final xds;
  final Map<String, dynamic> pregunta;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: xd,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final usuarios = snapshot.data!;

        final usuario = usuarios[pregunta['id_usuario'] - 1];

        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.5),
            child: Container(
                height: 250,
                // width: MediaQuery.of(context).size.width - 33,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /* AutoSizeText(
                  pregunta['titulo'] + "\n" + pregunta['descripcion'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Minecraft",
                      fontSize: 22),
                ), */
                    ListTile(
                      leading: const Icon(Icons.account_circle_rounded),
                      title: AutoSizeText(
                        usuario['nombre_usuario'],
                        style: const TextStyle(
                            color: Colors.green,
                            fontFamily: "Minecraft",
                            fontSize: 18),
                      ),
                      subtitle: AutoSizeText(
                        pregunta['titulo'] + "\n" + pregunta['descripcion'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Minecraft",
                            fontSize: 14),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /* IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.send_outlined)), */
                        /*  Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 10),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  side: const BorderSide(color: Colors.white),
                                  backgroundColor: Colors
                                      .grey[700] /*fixedSize: Size(200, 50)*/),
                              onPressed: () {},
                              child: Text(
                                "Responder",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Minecraft",
                                    color: Colors.grey[200]),
                              )),
                        ) */
                      ],
                    )
                  ],
                )));
      },
    );
  }
}
/* 
void _showMainPage(BuildContext context) {
  debugPrint("bello x3");
  final ruta = MaterialPageRoute(builder: (BuildContext context) {
    return const Mensaje();
  });
  Navigator.of(context).push(ruta);
} */