import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class view extends StatefulWidget {

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('form').snapshots();
  CollectionReference users = FirebaseFirestore.instance.collection('form');
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body:
    Card(shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.redAccent)),
      child: StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.redAccent,color: Colors.cyanAccent,),);
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return Slidable(endActionPane: ActionPane(motion: DrawerMotion(), children:[
            SlidableAction(borderRadius: BorderRadius.circular(10),backgroundColor: Colors.red,foregroundColor: Colors.white,onPressed: (context) {
                        deleteUser(document);
            },icon: Icons.delete,),
            SlidableAction(borderRadius: BorderRadius.circular(10),backgroundColor: Colors.green,foregroundColor: Colors.white,onPressed: (context) {
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                   return home(document);
                 },));
            },icon: Icons.edit,),
            ],),
              child: ListTile(
                  title: Text(data['user_name']),
                subtitle: Text(data['contact']),
                trailing: IconButton(onPressed: () {

                }, icon: Icon(Icons.info_outline_rounded),)
              ),
            );
          }).toList(),
        );
      }),
    ));
  }
  Future<void> deleteUser(DocumentSnapshot document) {
    return users
        .doc(document.id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
