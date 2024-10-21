import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Soma: '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _y = 0;
  final TextEditingController _controlaSoma = TextEditingController();
  Icon certo = const Icon(Icons.check);
  Icon errado = const Icon(Icons.close);
  Icon saida = const Icon(Icons.question_mark);
  int _x = 1;
  Map<String, Icon> _respostas = {};
  List<int> _indicesRestantes = [];

  @override
  void initState() {
    super.initState();
    _y = Random().nextInt(9) + 1;
    for (int i = 1; i <= 9; i++) {
      _respostas["$_x+$i"] = saida;
      _indicesRestantes.add(i);
    }
  }
  void trocaOperador() {
    setState(() {
      _x = Random().nextInt(10);
      _respostas.clear();
      for (int i = 1; i <= 9; i++) {
        _respostas["$_x+$i"] = saida;
      }
      _indicesRestantes = List<int>.generate(9, (index) => index + 1);
      getNumero();


    });
  }

  void corrigir() {
    int soma = _x + _y;
    String digitado = _controlaSoma.text;
    int resultado = int.parse(digitado);

    setState(() {
      if (soma == resultado) {
        _respostas["$_x+$_y"] = certo;
      } else {
        _respostas["$_x+$_y"] = errado;
      }
      _controlaSoma.clear();
      getNumero();
    });
  }

  void getNumero() {
    if (_indicesRestantes.isEmpty) {
      return; // Todas as questões foram respondidas.
    }

    setState(() {
      int randomIndex = Random().nextInt(_indicesRestantes.length);
      _y = _indicesRestantes[randomIndex];
      _indicesRestantes.removeAt(randomIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Text('$_x + $_y = '),
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _controlaSoma,
                  ),
                ),
              ],
            ),
            ElevatedButton(onPressed: corrigir, child: const Text("Corrigir")),
            ElevatedButton(onPressed: trocaOperador, child: const Text("Trocar Operador")),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    for (int i = 1; i <= 9; i++)
                      TableCell(
                        child: SizedBox(
                          width: 36,
                          height: 36,
                          child: _respostas['$_x+$i'],
                        ),
                      ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
