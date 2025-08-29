import 'package:hangul_utils/hangul_utils.dart';

/// [hangulJosa]에서 조사를 선택하기 위한 클래스입니다.
///
/// HangulJosaSelection("(마지막 글자가 받침이 있을 때)", "(마지막 글자가 받침이 없을 때)")
///
/// ```dart
/// print("${hangulJosa("대한민국", HangulJosaSelection("으로", "로"))} 간다."); // 대한민국으로 간다.
/// print("${hangulJosa("학교", HangulJosaSelection("으로", "로"))} 간다."); // 학교로 간다.
/// ```
class HangulJosaSelection {
  final String josaWithFinalConsonant;
  final String josaNoFinalConsonant;

  HangulJosaSelection(this.josaWithFinalConsonant, this.josaNoFinalConsonant);
}

/// 한글 조사: 이/가
///
/// 이 클래스는 HangulJosaSelection("이", "가")로도 나타낼 수 있습니다.
///
/// ```dart
/// print("${hangulJosa("강아지", HangulJosaSelectionIGa())} 노래를 한다."); // 강아지가 노래를 한다.
/// ```
class HangulJosaSelectionIGa extends HangulJosaSelection {
  HangulJosaSelectionIGa() : super("이", "가");
}

/// 한글 조사: 을/를
///
/// 이 클래스는 HangulJosaSelection("을", "를")로도 나타낼 수 있습니다.
///
/// ```dart
/// print("${hangulJosa("중고 물품", HangulJosaSelectionEulReul())} 거래하기 위해 지하철 역에 갔다 왔다."); // 중고 물품을 거래하기 위해 지하철 역에 갔다 왔다.
/// ```
class HangulJosaSelectionEulReul extends HangulJosaSelection {
  HangulJosaSelectionEulReul() : super("을", "를");
}

/// 받은 문장에서 마지막 글자의 받침 여부로 HangulJosaSelection에서 조사를 선택한 후
/// 문장과 조사를 합쳐 반환합니다.
///
/// 조사는 [HangulJosaSelectionIGa] (이/가), [HangulJosaSelectionEulReul] (을/를) 또는 [HangulJosaSelection]를 넣어 조사를 선택합니다.
/// 마지막 글자가 한글이 아닐 경우 받침이 없는 것으로 판단하여 [HangulJosaSelection]의 josaNoFinalConsonant를 선택합니다.
///
/// ```dart
/// print("${hangulJosa("과자", HangulJosaSelectionEulReul())} 구매하시겠습니까?"); // 과자를 구매하시겠습니까?
/// print("${hangulJosa("포인트", HangulJosaSelectionIGa())} 부족합니다."); // 포인트가 부족합니다.
/// print("${hangulJosa("Dart", HangulJosaSelectionEulReul())} 배우고 있습니다."); // Dart를 배우고 있습니다.
/// ```
String hangulJosa(String str, HangulJosaSelection selection) {
  var lastChar = str.trimRight()[str.trimRight().length - 1];
  str = str.trim();
  if (!isHangul(str)) {
    return str + selection.josaNoFinalConsonant;
  }
  return str +
      (HangulCharacter.fromCharacter(lastChar).jongseong != null
          ? selection.josaWithFinalConsonant
          : selection.josaNoFinalConsonant);
}
