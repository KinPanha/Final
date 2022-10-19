import 'package:assignmentfinal/Model/users.dart';
import 'package:assignmentfinal/view/addnote.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../databest-hleper/databese.dart';

class NoteKeep extends StatefulWidget {
  const NoteKeep({Key? key}) : super(key: key);

  @override
  State<NoteKeep> createState() => _NoteKeepState();
}

class _NoteKeepState extends State<NoteKeep> {
  late DatabaseConnection db;
  Future<List<Users>>? userlist;
  Future<List<Users>> getList() async {
    return await db.get();
  }

  @override
  void initState() {
    super.initState();
    db = DatabaseConnection();
    db.initializeUserDB().whenComplete(() async {
      setState(() {
        userlist = db.get();
        print('kkk');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Center(
          child: Text(
            'Note Keep',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
      body: FutureBuilder(
        future: userlist,
        builder: (BuildContext context, AsyncSnapshot<List<Users>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                var item = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(
                      item.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis),
                    ),
                    subtitle: Text(
                      item.note,
                      style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await DatabaseConnection()
                            .detele(item.title)
                            .whenComplete(() {
                          setState(() {
                            print('delete Success');
                          });
                        });
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddNote());
        },
        child: const Center(child: Icon(Icons.add)),
      ),
    );
  }
}
