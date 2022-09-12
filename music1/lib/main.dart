import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Muzic(),
    );
  }
}

class Muzic extends StatefulWidget {
  const Muzic({Key? key}) : super(key: key);

  @override
  State<Muzic> createState() => _MuzicState();
}

class _MuzicState extends State<Muzic> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  late AudioPlayer _player;
  late AudioCache cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider() {
    return Slider.adaptive(
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
        value: position.inSeconds.toDouble(),
        max: musicLength.inSeconds.toDouble(),
        onChanged: (value) {
          seekToSec(value.toInt());
        });
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(prefix: _player.toString());

    _player.onDurationChanged.listen((d) => setState(() {
          musicLength = d;
        }));

    _player.onPositionChanged.listen((p) => setState(() {
          position = p;
        }));

    cache.load('bishkek.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 20, 98, 186),
              Color.fromARGB(255, 144, 203, 251)
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      'Music Beats',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 38.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      'Слушай любимую музыку',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Center(
                    child: Container(
                      height: 400.0,
                      width: 350.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: const DecorationImage(
                          image: AssetImage('assets/44.jpg'),
                        ),
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Stargazer',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          slider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 45,
                                color: Colors.blue,
                                onPressed: () {},
                                icon: const Icon(Icons.skip_previous),
                              ),
                              IconButton(
                                iconSize: 45,
                                color: const Color.fromARGB(255, 20, 98, 186),
                                onPressed: () {
                                  if (!playing) {
                                    cache.load('bishkek.mp3');
                                    setState(() {
                                      playBtn = Icons.pause;
                                      playing = true;
                                    });
                                  } else {
                                    _player.pause();
                                    setState(() {
                                      playBtn = Icons.play_arrow;
                                      playing = false;
                                    });
                                  }
                                },
                                icon: Icon(playBtn),
                              ),
                              IconButton(
                                iconSize: 45,
                                color: Colors.blue,
                                onPressed: () {},
                                icon: const Icon(Icons.skip_next),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
