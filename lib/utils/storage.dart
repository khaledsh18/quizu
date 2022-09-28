import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static FlutterSecureStorage? storage;
  String? _token;
  static Storage? _mInstance;


  Storage(){
     storage = const FlutterSecureStorage();
  }

  Storage getInstance(){
    _mInstance ??= Storage();
    return _mInstance!;
  }
  String? get token => _token;

  Future<void> setToken() async{
    _token = await storage!.read(key: 'token');
  }

  Future<void> addNewToken(String? token) async{
    _token = token;
    await storage!.write(key: 'token', value: token);
  }

  Future<void> removeToken() async{
    await storage!.delete(key: 'token');
  }

  Future<void> addScore() async{

  }
}