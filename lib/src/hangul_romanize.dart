import 'package:hangul_utils/hangul_utils.dart';

/// 한국어 텍스트를 [국어의 로마자 표기법](https://korean.go.kr/kornorms/regltn/regltnView.do?regltn_code=0004)에 따라 로마자로 표기합니다.
///
/// ```dart
/// print(hangulRomainze("백마")); //baengma
/// print(hangulRomainze("신라")); // silla
/// print(hangulRomainze("학여울")); // hangnyeoul
/// print(hangulRomainze("놓다")); // nota
/// print(hangulRomainze("집현전")); // jiphyeonjeon
/// print(hangulRomainze("잡혀")); // japyeo
/// print(hangulRomainze("Dart는 프로그래밍 언어입니다.")); // Dartneun peurogeuraeming eoneoimnida.
/// ```
String hangulRomainze(String koreanText) {
  var textArr = _koreanRomanizationRule1(koreanText).split('');
  List<String> resultTextArr = List.from(textArr);
  // print(textArr.join());
  for (var (index, c) in textArr.indexed) {
    if (isHangul(c) && c != ' ') {
      var hangul = HangulCharacter.fromCharacter(c);
      var romanized = hangul.romanize();

      // [붙임 2] ‘ㄹ’은 모음 앞에서는 ‘r’로, 자음 앞이나 어말에서는 ‘l’로 적는다. 단, ‘ㄹㄹ’은 ‘ll’로 적는다.
      if (hangul.choseong == "ㄹ" && index > 0) {
        if (isHangul(textArr[index - 1]) && textArr[index - 1] != ' ') {
          if (HangulCharacter.fromCharacter(textArr[index - 1]).jongseong ==
              "ㄹ") {
            romanized = romanized.replaceFirst("r", "l");
          }
        }
      }

      resultTextArr[index] = romanized;
    } else {
      resultTextArr[index] = c;
    }
  }
  return resultTextArr.join();
}

/// 국어의 로마자 표기법 제1항 (https://korean.go.kr/kornorms/regltn/regltnView.do?regltn_code=0004)
///
/// 음운 변화가 일어날 때에는 변화의 결과에 따라 다음 각호와 같이 적는다.
String _koreanRomanizationRule1(String text) {
  var textArr = text.split('');

  for (int textArrIdx = 0; textArrIdx < textArr.length; textArrIdx++) {
    if (textArrIdx >= textArr.length - 1) continue;
    var charther = textArr[textArrIdx];
    var nextCharther = textArr[textArrIdx + 1];
    if (isHangul(charther) &&
        isHangul(nextCharther) &&
        charther != ' ' &&
        nextCharther != ' ') {
      var hangul = HangulCharacter.fromCharacter(charther);
      var nextHangul = HangulCharacter.fromCharacter(nextCharther);
      if (hangul.jongseong == null) continue;

      // 2. ‘ㄴ, ㄹ’이 덧나는 경우
      if (nextHangul.choseong == "ㅇ" &&
          ["ㅑ", "ㅕ", "ㅛ", "ㅠ", "ㅒ", "ㅖ"].contains(nextHangul.jungseong)) {
        if (hangul.jongseong == "ㄹ") {
          nextHangul.choseong = "ㄹ";
        } else {
          nextHangul.choseong = "ㄴ";
        }
      }

      // 1. 자음 사이에서 동화 작용이 일어나는 경우
      if (["ㄱ", "ㄷ", "ㅂ"].contains(hangul.jongseong!) &&
          ["ㄴ", "ㅁ"].contains(nextHangul.choseong)) {
        hangul.jongseong = [
          "ㅇ",
          "ㄴ",
          "ㅁ",
        ][["ㄱ", "ㄷ", "ㅂ"].indexOf(hangul.jongseong!)];
      }

      if (["ㅁ", "ㅇ"].contains(hangul.jongseong!) &&
          nextHangul.choseong == "ㄹ") {
        nextHangul.choseong = "ㄴ";
      }

      if (["ㄱ", "ㄷ", "ㅂ"].contains(hangul.jongseong!) &&
          nextHangul.choseong == "ㄹ") {
        hangul.jongseong = [
          "ㅇ",
          "ㄴ",
          "ㅁ",
        ][["ㄱ", "ㄷ", "ㅂ"].indexOf(hangul.jongseong!)];
        nextHangul.choseong = "ㄴ";
      }

      if (hangul.jongseong == "ㄴ" && nextHangul.choseong == "ㄹ") {
        hangul.jongseong = "ㄹ";
      }

      if (hangul.jongseong == "ㄹ" && nextHangul.choseong == "ㄴ") {
        nextHangul.choseong = "ㄹ";
      }

      // 3. 구개음화가 되는 경우

      if (hangul.jongseong == "ㅌ" &&
          nextHangul.choseong == "ㅇ" &&
          nextHangul.jungseong == "ㅣ") {
        hangul.jongseong = null;
        nextHangul.choseong = "ㅊ";
      }

      if (hangul.jongseong == "ㄷ" &&
          nextHangul.choseong == "ㅇ" &&
          nextHangul.jungseong == "ㅣ") {
        hangul.jongseong = null;
        nextHangul.choseong = "ㅈ";
      }

      // 4. ‘ㄱ, ㄷ, ㅂ, ㅈ’이 ‘ㅎ’과 합하여 거센소리로 소리 나는 경우
      //
      // 다만, 체언에서 ‘ㄱ, ㄷ, ㅂ’ 뒤에 ‘ㅎ’이 따를 때에는 ‘ㅎ’을 밝혀 적는다.
      if (hangul.jongseong == "ㅎ" && nextHangul.choseong == "ㄱ") {
        hangul.jongseong = null;
        nextHangul.choseong = "ㅋ";
      }
      if (hangul.jongseong == "ㅎ" && nextHangul.choseong == "ㄷ") {
        hangul.jongseong = null;
        nextHangul.choseong = "ㅌ";
      }
      if (hangul.jongseong == "ㅎ" && nextHangul.choseong == "ㅂ") {
        hangul.jongseong = null;
        nextHangul.choseong = "ㅍ";
      }
      if (hangul.jongseong == "ㅎ" && nextHangul.choseong == "ㅈ") {
        hangul.jongseong = null;
        nextHangul.choseong = "ㅊ";
      }

      // [붙임] 된소리되기는 표기에 반영하지 않는다.

      textArr[textArrIdx] = hangul.toString();
      textArr[textArrIdx + 1] = nextHangul.toString();
    }
  }

  return textArr.join();
}
