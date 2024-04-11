import 'package:flutter/material.dart';

import '../api/api.dart';
import '../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User>? users; 
  var isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //fetch data from API
    getData();
  }

  getData() async{
    users = await api().getUsers();
    if(users != null){
      setState((){
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: users?.length,
          itemBuilder: (context, index) {
            return Container(
              child: Text(users![index].firstName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        )
      )
    );
  }
}