import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preguntame/main.dart';
import 'package:preguntame/pages/newUser.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'sendQuestion.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(menu(text: 0));

/* Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://cmlennssxegtkemyqpda.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNtbGVubnNzeGVndGtlbXlxcGRhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTE1NDg4MDQsImV4cCI6MjAyNzEyNDgwNH0.qY8wkhs-JPlm6Ahwtd-QHBMvvLkzumn5uTIQbkhm2RM',
  );
  runApp(const menu());
} */

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

class Menu extends StatefulWidget {
  int id_usuario;
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
                        fontSize: 40,
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
                      child: const Text(
                        "Hacer\npregunta",
                        style: TextStyle(
                            color: Colors.blue,
                            fontFamily: "Minecraft",
                            fontSize: 28),
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
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 17),
              child: const Text(
                "Preguntas agregadas recientemente",
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: "Minecraft",
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
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
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: preguntas.length,
                          itemBuilder: (context, index) {
                            final pregunta = preguntas[index];
                            final xds;
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
        debugPrint(pregunta['id_usuario'].toString());
        final usuario = usuarios[pregunta['id_usuario'] - 1];
        debugPrint(usuarios.toString());
        debugPrint("-----------------");
        debugPrint(usuario['nombre_usuario']);

        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.5),
            child: Container(
                height: xds,
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
                      title: AutoSizeText(
                        usuario['nombre_usuario'],
                        style: const TextStyle(
                            color: Colors.green,
                            fontFamily: "Minecraft",
                            fontSize: 22),
                      ),
                      subtitle: AutoSizeText(
                        pregunta['titulo'] + "\n" + pregunta['descripcion'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Minecraft",
                            fontSize: 18),
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