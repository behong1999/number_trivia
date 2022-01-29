import 'dart:io';

//* Read the entire file as String
String fixture(String name) => File('test/fixtures/$name').readAsStringSync();
