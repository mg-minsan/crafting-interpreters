import 'dart:io';

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
