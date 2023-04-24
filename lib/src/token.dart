import 'package:lox/src/token_type.dart';

class Token {
  final TokenType type;
  final String lexeme;
  final String literal;
  final int line;

  Token(this.type, this.lexeme, this.literal, this.line);

  @override
  String toString() {
    return '$type $lexeme $literal';
  }
}
