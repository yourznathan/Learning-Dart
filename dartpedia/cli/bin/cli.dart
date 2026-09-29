import 'dart:io'; // Is a core library that provides APIs to deal with files, directories, sockets and HTTP clients and servers, and more.
import 'package:http/http.dart' as http; // Is a package that provides a composable, Future-based API for making HTTP requests.
import 'package:command_runner/command_runner.dart';

const version = '0.0.1';

void main(List<String> arguments) async {
  var runner = CommandRunner();
  await runner.run(arguments);
}

