import 'hangul_character.dart';

/// 한글 음절을 초성, 중성, 종성 단위로 분해하고
/// 다시 합성할 수 있도록 도와주는 클래스입니다.
///
/// [HangulCharacter.fromCharacter]로 만들 수 있습니다.
///
/// ```dart
/// var char = HangulCharacter.fromCharacter("강");
/// print(char.choseong); // ㄱ
/// print(char.jungseong); // ㅏ
/// print(char.jongseong); // ㅇ
///
/// print(char.toString()); // "강"
/// ```
class HangulCharacter {
  /// 초성
  String choseong;

  /// 중성
  String? jungseong;

  /// 종성
  String? jongseong;

  HangulCharacter({required this.choseong, this.jungseong, this.jongseong});

  /// [String]에 있는 여러 개의 한글을 전부 [HangulCharacter]로 변환해 [List]로 반환합니다.
  /// 한글이 아닌 문자는 무시됩니다.
  static List<HangulCharacter> fromString(String str) {
    return str
        .split('')
        .where((char) => isHangul(char))
        .map((char) => HangulCharacter.fromCharacter(char))
        .toList();
  }

  /// 단일 한글 문자(음절 또는 자모)를 가져와 [HangulCharacter]로 생성합니다.
  ///
  /// 한글이 아니거나 한 글자가 아닌 여러 글자일 경우 예외를 발생시킵니다.
  factory HangulCharacter.fromCharacter(String newChar) {
    if (newChar.length != 1) {
      throw Exception("The input string must be a single character.");
    }

    int code = newChar.codeUnitAt(0);
    if (isHangul(newChar[0])) {
      if (code >= 0x3131 && code <= 0x314E) {
        return HangulCharacter(choseong: newChar);
      }
      int syllableIndex = code - 0xAC00;
      int choseongIndex = syllableIndex ~/ (21 * 28);
      int jungseongIndex = (syllableIndex % (21 * 28)) ~/ 28;
      int jongseongIndex = syllableIndex % 28;

      return HangulCharacter(
        choseong: choseongs[choseongIndex],
        jungseong: jungseongs[jungseongIndex],
        jongseong: jongseongIndex == 0 ? null : jongseongs[jongseongIndex],
      );
    } else {
      throw Exception("The input value is not a Hangul character.");
    }
  }

  /// [HangulCharacter]를 다시 한글 음절로 합성해 한 글자의 [String] 형식으로 반환합니다.
  @override
  String toString() {
    int codePoint = 0xAC00 + (choseongs.indexOf(choseong) * 21 * 28);
    if (jungseong != null) {
      int jungIndex = jungseongs.indexOf(jungseong!);
      codePoint += jungIndex * 28;
      if (jongseong != null) {
        int jongIndex = jongseongs.indexOf(jongseong!);
        codePoint += jongIndex;
      }
    } else {
      return choseong;
    }

    return String.fromCharCode(codePoint);
  }

  /// 한글 글자를 국어의 로마자 표기법에 따라 로마자 표기법으로 변환합니다.
  ///
  /// https://korean.go.kr/kornorms/regltn/regltnView.do?regltn_code=0004
  String romanize() {
    String result = "";

    result += romanChoseongs[choseongs.indexOf(choseong)];
    if (jungseong != null) {
      result += romanJungseongs[jungseongs.indexOf(jungseong!)];
      if (jongseong != null) {
        result += romanJongseongs[jongseongs.indexOf(jongseong!)];
      }
    }
    return result;
  }
}

/// 매개변수로 받은 [String]이 모두 한글인지 확인하는 함수입니다.
///
/// 공백을 제외하고, 만약 한 글자라도 한글이 아닌 문자가 있을 시 false를 반환하고
/// 모두 한글일 시 true를 반환합니다.
///
/// ```dart
/// print(isHangul("한글")); // true
/// print(isHangul("이것은 한글입니다")); // true
/// print(isHangul("Hangul")); // false
/// print(isHangul("It's 한글")); // false
/// print(isHangul("저는 한글입니까?")); // false
/// ```
bool isHangul(String text) {
  for (var char in text.split('')) {
    if (char == ' ') continue;
    int code = char.codeUnitAt(0);
    if (!((code >= 0x3131 && code <= 0x314E) ||
        (code >= 0xAC00 && code <= 0xD7A3))) {
      return false;
    }
  }
  return true;
}

/// [String] 타입의 문자열을 받아 한글을 전부 초성으로 변환해 반환합니다.
///
/// ```dart
/// print(hangulChoseong("한글")); // ㅎㄱ
/// print(hangulChoseong("It's 한글")); // It's ㅎㄱ
/// ```
String hangulChoseong(String text) {
  return text
      .split('')
      .map(
        (char) => isHangul(char)
            ? HangulCharacter.fromCharacter(char).choseong
            : char,
      )
      .toList()
      .join('');
}
