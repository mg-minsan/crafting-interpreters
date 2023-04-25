import 'package:lox/src/lox.dart';
import 'package:lox/src/token.dart';
import 'package:lox/src/token_type.dart';
import 'package:characters/characters.dart';

class Scanner {
  late final String _source;
  final List<Token> _tokens = [];
  var _start = 0;
  var _current = 0;
  var _line = 1;

  Scanner({required String source}) : _source = source;

  List<Token> scanTokens() {
    while (!_isAtEnd()) {
      _start = _current;
      scanToken();
    }

    _tokens.add(
      Token(
        type: TokenType.eof,
        lexeme: "",
        literal: null,
        line: _line,
      ),
    );

    return _tokens;
  }

  scanToken() {
    final c = _advance();
    switch (c) {
      case '(':
        _addToken(TokenType.leftParen);
        break;
      case ')':
        _addToken(TokenType.rightParen);
        break;
      case '{':
        _addToken(TokenType.leftBrace);
        break;
      case '}':
        _addToken(TokenType.rightBrace);
        break;
      case ',':
        _addToken(TokenType.comma);
        break;
      case '.':
        _addToken(TokenType.dot);
        break;
      case '-':
        _addToken(TokenType.minus);
        break;
      case '+':
        _addToken(TokenType.plus);
        break;
      case ';':
        _addToken(TokenType.semicolon);
        break;
      case '*':
        _addToken(TokenType.star);
        break;
      case '!':
        _addToken(_match('=') ? TokenType.bangEqual : TokenType.bang);
        break;
      case '=':
        _addToken(_match('=') ? TokenType.equalEqual : TokenType.equal);
        break;
      case '<':
        _addToken(_match('=') ? TokenType.lessEqual : TokenType.less);
        break;
      case '>':
        _addToken(_match('=') ? TokenType.greaterEqual : TokenType.greater);
        break;
      case '/':
        if (_match('/')) {
          while (_peak() != '\n' && !_isAtEnd()) {
            _advance();
          }
        } else {
          _addToken(TokenType.slash);
        }
        break;
      case ' ':
      case '\r':
      case '\t':
        break;
      case '\n':
        _line++;
        break;
      case '"':
        _string();
        break;
      default:
        _isDigit(c) ? _number() : Lox.error(_line, "Unexpected character.");
        break;
    }
  }

  void _number() {
    while (_isDigit(_peak())) {
      _advance();
    }

    if (_peak() == '.' && _isDigit(_peakNext())) {
      _advance();
      while (_isDigit(_peak())) {
        _advance();
      }
    }
    _addTokenWithLiteral(
        TokenType.number, double.parse(_source.substring(_start, _current)));
  }

  bool _isDigit(String c) => c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57;

  void _string() {
    while (_peak() != '"' && !_isAtEnd()) {
      if (_peak() == "\n") _line++;
      _advance();
    }

    if (_isAtEnd()) {
      Lox.error(_line, "Unterminated string.");
    }
    _advance();

    final value = _source.substring(_start + 1, _current - 1);
    _addTokenWithLiteral(TokenType.string, value);
  }

  bool _match(String expected) {
    if (_isAtEnd()) return false;
    if (_source.characters.elementAt(_current) != expected) return false;

    _current++;
    return true;
  }

  void _addToken(TokenType type) {
    _addTokenWithLiteral(type, null);
  }

  String _peak() {
    if (_isAtEnd()) return '\u0000';
    return _source.characters.elementAt(_current);
  }

  String _peakNext() {
    if (_current + 1 >= _source.length) return '\u0000';
    return _source.characters.elementAt(_current + 1);
  }

  void _addTokenWithLiteral(TokenType type, Object? literal) {
    final text = _source.substring(_start, _current);
    _tokens.add(Token(
      type: type,
      lexeme: text,
      literal: literal,
      line: _line,
    ));
  }

  String _advance() => _source.characters.elementAt(_current++);

  bool _isAtEnd() => _current >= _source.length;
}
