import 'dart:math';

import 'package:assignmentfinal/Model/users.dart';
import 'package:assignmentfinal/databest-hleper/databese.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  DatabaseConnection db = DatabaseConnection();
  List<Users> userlist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db.initializeUserDB().then((value) {
      setState(() {
        userlist.add(Users(
            title: titleController.text,
            note: noteController.text));
      });
    });
  }

  void adduser() async {
    await db
        .insert(Users(title: titleController.text, note: noteController.text));
    setState(() {
      userlist.insert(
          0, Users(title: titleController.text, note: noteController.text));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 60),
            const Text(
              'Add Note',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(width: 60),
            TextButton(
              onPressed: () {
                setState(() {
                  adduser();
                });
                Get.back();
              },
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Title'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: noteController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Wirte a note...'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
