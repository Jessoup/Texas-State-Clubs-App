import 'package:flutter/material.dart';

class Clublist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clubs'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            FractionallySizedBox(
              widthFactor: 1,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Texas State Soccer',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ),
              ),
            ),
            SizedBox(height: 15),
            FractionallySizedBox(
              widthFactor: 1,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('.EXE: Computer Science Club',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ),
              ),
            ),
            SizedBox(height: 15),
            FractionallySizedBox(
              widthFactor: 1,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Gamers at Texas State',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ),
              ),
            ),
            SizedBox(height: 15),
            FractionallySizedBox(
              widthFactor: 1,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('American Marketing Association',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ),
              ),
            ),
            SizedBox(height: 15),
            FractionallySizedBox(
              widthFactor: 1,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Texas State Esports',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}