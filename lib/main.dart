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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pos = 0;

  _changePosition(int newPos) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _pos = newPos;
      });
    });
  }

  List<CharacterModel> characters = [
    CharacterModel(
        imageSource: "assets/captain_america.jpg",
        name: "Captain America",
        color: const Color(0xFFE9EDEE)),
    CharacterModel(
        imageSource: "assets/daredevil.jpg",
        name: "Daredevil",
        color: const Color(0xFFA30F0F)),
    CharacterModel(
        imageSource: "assets/loki.jpg",
        name: "Loki",
        color: const Color(0xFFE89F30)),
    CharacterModel(
        imageSource: "assets/spider_man.jpg",
        name: "Spider Man",
        color: const Color(0xFFC13238)),
    CharacterModel(
        imageSource: "assets/shang_chi.jpg",
        name: "Shang Chi",
        color: const Color(0xFF5E0B15))
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFF2A272B),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(top: 60, bottom: 20),
                        child: Image.asset('assets/marvel_256.png',
                            height: 30, fit: BoxFit.fill))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "Choose your hero",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none),
                    )
                  ],
                ),
                Expanded(
                    child: Stack(children: <Widget>[
                  CustomPaint(
                      size: Size(MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height),
                      painter: TrianglePainter(color: characters[_pos].color)),
                  PageView.builder(
                      itemBuilder: (context, position) {
                        return Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 40, horizontal: 20),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  elevation: 5,
                                  child: Image.asset(
                                      characters[position].imageSource,
                                      fit: BoxFit.fill)),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 50, horizontal: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      characters[position].name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ))
                          ],
                        );
                      },
                      itemCount: 5,
                      onPageChanged: _changePosition
                      )
                ]))
              ]),
        ));
  }
}

class CharacterModel {
  String imageSource;
  String name;
  Color color;

  CharacterModel(
      {required this.imageSource, required this.name, required this.color});
}

class TrianglePainter extends CustomPainter {
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => true;

  TrianglePainter({required this.color});
}
