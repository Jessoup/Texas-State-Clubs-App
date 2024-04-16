import 'package:flutter/material.dart';
import 'clubs.dart';


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
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Club(
                    clubID: 1,
                    clubName: 'Texas State Esports',
                    clubDescrip: 'we are a silly folk',)
                  ),
                );
              },
              child: FractionallySizedBox(
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
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Club(
                    clubID: 1,
                    clubName: 'Texas State Mens Soccer',
                    clubDescrip: 'we are a silly folk',)
                  ),
                );
              },
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Card(
                  elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Texas State Mens Soccer',
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
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Club(
                    clubID: 1,
                    clubName: 'Texas State Womens Soccer',
                    clubDescrip: 'we are a silly folk',)
                  ),
                );
              },
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Card(
                  elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Texas State Womens Soccer',
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
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Club(
                    clubID: 1,
                    clubName: 'Texas State Lacrosse',
                    clubDescrip: 'we are a silly folk',)
                  ),
                );
              },
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Card(
                  elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Texas State Lacrosse',
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
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Club(
                    clubID: 1,
                    clubName: 'Texas State Chess club',
                    clubDescrip: 'we are a silly folk',)
                  ),
                );
              },
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Card(
                  elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Texas State Chess club',
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
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Club(
                    clubID: 1,
                    clubName: 'Texas State Mens Basketball',
                    clubDescrip: 'we are a silly folk',)
                  ),
                );
              },
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Card(
                  elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Texas State Mens Basketball',
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
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Club(
                    clubID: 1,
                    clubName: 'Texas State Womens Basketball',
                    clubDescrip: 'we are a silly folk',)
                  ),
                );
              },
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Card(
                  elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Texas State Womens Basketball',
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
            )
          ],
        ),
      ),
    );
  }
}

/* 
make a club object in this file and then grab from the data base in here 
hopefully it will iterate through and display what we need it too.
*/