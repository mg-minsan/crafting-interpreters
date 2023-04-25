import 'dart:io';

import 'package:lox/src/lox.dart';

void main(List<String> args) {
  try {
    if (args.length > 1) {
      print('Usage: jlox [script]');
      exit(64);
    } else if (args.length == 1) {
      Lox.runFile(args[0]);
    } else {
      Lox.runPrompt();
    }
  } catch (e) {
    print(e);
    exit(64);
  }
}
