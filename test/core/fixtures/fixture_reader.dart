import 'dart:io';

String fixture(String filename) =>
    File('test/core/fixtures/$filename').readAsStringSync();
