import 'dart:io';

class Lox {
  static void runFile(String path) => _run(File(path).readAsStringSync());

  static void runPrompt() {
    while (true) {
      stdout.write('> ');
      final line = stdin.readLineSync();
      if (line == null) break;
      _run(line);
    }
  }

  static _run(String source) {}

  static void error(int line, String message) {
    _report(line, '', message);
  }

  static void _report(int line, String where, String message) =>
      print('[line $line + ] Error  $where : $message');
}
