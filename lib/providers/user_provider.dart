import 'package:flutter/material.dart';
import '../api/firebase_user_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserListProvider with ChangeNotifier {
  late FirebaseUserAPI firebaseService;
  late Stream<QuerySnapshot> _usersStream;
  User? _selectedUser;

  UserListProvider() {
    firebaseService = FirebaseUserAPI();
    fetchUsers();
  }

  // getter
  Stream<QuerySnapshot> get users => _usersStream;
  User get selected => _selectedUser!;

  changeSelectedUser(User user) {
    _selectedUser = user;
  }

  void fetchUsers() {
    _usersStream = firebaseService.getAllUsers();
    notifyListeners();
  }

  Future<void> addUser(String email, String fname, String lname) async {
    User newUser = User(email: email, fname: fname, lname: lname);
    String message = await firebaseService.addUser(newUser.toJson(newUser));
    print(message);
    notifyListeners();
  }

  // void editTodo(int index, String newTitle) {
  //   // _todoList[index].title = newTitle;
  //   print("Edit");
  //   notifyListeners();
  // }

  // void deleteTodo() async {
  //   String message = await firebaseService.deleteTodo(_selectedTodo!.id);
  //   print(message);
  //   notifyListeners();
  // }

  // void toggleStatus(int index, bool status) {
  //   // _todoList[index].completed = status;
  //   print("Toggle Status");
  //   notifyListeners();
  // }
}
