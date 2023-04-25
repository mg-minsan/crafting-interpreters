import 'package:lox/src/token_type.dart';

class Token {
  final TokenType type;
  final String? lexeme;
  final Object? literal;
  final int line;

  Token({
    required this.type,
    required this.lexeme,
    required this.literal,
    required this.line,
  });

  @override
  String toString() {
    return '$type $lexeme $literal';
  }
}
