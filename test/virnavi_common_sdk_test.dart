import 'package:flutter_test/flutter_test.dart';
import 'package:virnavi_common_sdk/virnavi_common_sdk.dart';

void main() {
  // ---------------------------------------------------------------------------
  // Either
  // ---------------------------------------------------------------------------
  group('Either', () {
    test('Left.isLeft returns true', () {
      final e = Left<String, int>('error');
      expect(e.isLeft(), isTrue);
      expect(e.isRight(), isFalse);
    });

    test('Right.isRight returns true', () {
      final e = Right<String, int>(42);
      expect(e.isRight(), isTrue);
      expect(e.isLeft(), isFalse);
    });

    test('getOrElse returns data when Right', () {
      final e = Right<String, int>(7);
      expect(e.getOrElse(() => 0), 7);
    });

    test('getOrElse calls callback when Left', () {
      final e = Left<String, int>('oops');
      expect(e.getOrElse(() => 99), 99);
    });

    test('swap turns Left into Right', () {
      final e = Left<String, int>('a');
      final swapped = e.swap();
      expect(swapped.isRight(), isTrue);
    });

    test('fold calls onLeft for Left', () async {
      final e = Left<String, int>('fail');
      final result = await e.fold((l) => 'left:$l', (r) => 'right:$r');
      expect(result, 'left:fail');
    });

    test('fold calls onRight for Right', () async {
      final e = Right<String, int>(3);
      final result = await e.fold((l) => 'left', (r) => 'right:$r');
      expect(result, 'right:3');
    });
  });

  // ---------------------------------------------------------------------------
  // Optional
  // ---------------------------------------------------------------------------
  group('Optional', () {
    test('empty has no data', () {
      final opt = Optional.empty<String>();
      expect(opt.hasData, isFalse);
    });

    test('of has data', () {
      final opt = Optional.of('hello');
      expect(opt.hasData, isTrue);
      expect(opt.data, 'hello');
    });

    test('ofNullable with value has data', () {
      final opt = Optional.ofNullable<int>(5);
      expect(opt.hasData, isTrue);
      expect(opt.data, 5);
    });

    test('ofNullable with null is empty', () {
      final opt = Optional.ofNullable<int>(null);
      expect(opt.hasData, isFalse);
    });

    test('data throws NoSuchElementException when empty', () {
      final opt = Optional.empty<String>();
      expect(() => opt.data, throwsA(isA<NoSuchElementException>()));
    });

    test('orElse returns fallback when empty', () {
      final opt = Optional.empty<String>();
      expect(opt.orElse('fallback'), 'fallback');
    });

    test('orElse returns data when present', () {
      final opt = Optional.of('value');
      expect(opt.orElse('fallback'), 'value');
    });

    test('orElseThrow throws when empty', () {
      final opt = Optional.empty<String>();
      expect(() => opt.orElseThrow(Exception('missing')), throwsException);
    });

    test('ifPresent is called when data present', () {
      final opt = Optional.of(10);
      int? captured;
      opt.ifPresent((v) => captured = v);
      expect(captured, 10);
    });

    test('ifPresent is not called when empty', () {
      final opt = Optional.empty<int>();
      int? captured;
      opt.ifPresent((v) => captured = v);
      expect(captured, isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // EmptyModel
  // ---------------------------------------------------------------------------
  group('EmptyModel', () {
    test('toJson returns empty map', () {
      expect(EmptyModel().toJson(), <String, dynamic>{});
    });

    test('fromJson returns EmptyModel', () {
      final m = EmptyModel.fromJson({});
      expect(m, isA<EmptyModel>());
    });
  });

  // ---------------------------------------------------------------------------
  // NameFormatHelper
  // ---------------------------------------------------------------------------
  group('NameFormatHelper', () {
    test('capitalises first letter and lowercases rest', () {
      expect(NameFormatHelper.format('john'), 'John');
    });

    test('title-cases multi-word string', () {
      expect(NameFormatHelper.format('john doe'), 'John Doe');
    });

    test('handles all-uppercase input', () {
      expect(NameFormatHelper.format('JANE SMITH'), 'Jane Smith');
    });

    test('handles single-character word', () {
      expect(NameFormatHelper.format('a b'), 'A B');
    });

    test('returns empty string for empty input', () {
      expect(NameFormatHelper.format(''), '');
    });
  });

  // ---------------------------------------------------------------------------
  // RegexHelper
  // ---------------------------------------------------------------------------
  group('RegexHelper', () {
    test('valid email passes', () {
      expect(RegexHelper.isEmailFormatValid('user@example.com'), isTrue);
    });

    test('email without @ fails', () {
      expect(RegexHelper.isEmailFormatValid('userexample.com'), isFalse);
    });

    test('email without domain fails', () {
      expect(RegexHelper.isEmailFormatValid('user@'), isFalse);
    });

    test('isValidText true for 3+ chars', () {
      expect(RegexHelper.isValidText('abc'), isTrue);
    });

    test('isValidText false for less than 3 chars', () {
      expect(RegexHelper.isValidText('ab'), isFalse);
    });

    test('isValidText false for empty string', () {
      expect(RegexHelper.isValidText(''), isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // Logger
  // ---------------------------------------------------------------------------
  group('Logger', () {
    test('log returns a non-empty correlation ID', () {
      final logger = Logger(enableLogging: false);
      final cId = logger.log('test message', tag: 'Test');
      expect(cId, isNotEmpty);
    });

    test('provided correlationId is returned as-is', () {
      final logger = Logger(enableLogging: false);
      final cId = logger.log('msg', correlationId: 'my-id');
      expect(cId, 'my-id');
    });

    test('getCorrelationId with tag generates unique IDs', () {
      final logger = Logger(enableLogging: false);
      final id1 = logger.getCorrelationId('Tag');
      final id2 = logger.getCorrelationId('Tag');
      // IDs are time+random based; extremely unlikely to collide
      expect(id1, isNot(equals(id2)));
    });
  });

  // ---------------------------------------------------------------------------
  // NoSuchElementException
  // ---------------------------------------------------------------------------
  group('NoSuchElementException', () {
    test('is an Exception', () {
      expect(NoSuchElementException(), isA<Exception>());
    });
  });
}
