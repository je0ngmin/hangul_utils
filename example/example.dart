import 'package:hangul_utils/hangul_utils.dart';

void main() {
  var kang = HangulCharacter.fromCharacter("강");
  var ka = HangulCharacter(choseong: "ㄱ", jungseong: "ㅏ");
  var k = HangulCharacter.fromCharacter("ㄱ");

  print(kang); // 강
  print(ka); // 가
  print(k); // ㄱ

  print(kang.choseong); // ㄱ
  print(kang.jungseong); // ㅏ
  print(kang.jongseong); // ㅇ

  print(k.choseong); // ㄱ
  print(k.jungseong); // null
  print(k.jongseong); // null

  print(isHangul("한글")); // true
  print(isHangul("이것은 한글입니다")); // true
  print(isHangul("Hangul")); // false
  print(isHangul("It's 한글")); // false
  print(isHangul("저는 한글입니까?")); // false

  print(
    "${hangulJosa("강아지", HangulJosaSelectionIGa())} 노래를 한다.",
  ); // 강아지가 노래를 한다.
  print(
    "${hangulJosa("바깥", HangulJosaSelection("으로", "로"))} 돌을 던졌다.",
  ); // 바깥으로 돌을 던졌다.
  print(
    "${hangulJosa("과자", HangulJosaSelectionEulReul())} 구매하시겠습니까?",
  ); // 과자를 구매하시겠습니까?
}
