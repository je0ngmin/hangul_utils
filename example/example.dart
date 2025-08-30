import 'package:hangul_utils/hangul_utils.dart';

void main() {
  var han = HangulCharacter.fromCharacter("한");
  var ha = HangulCharacter(choseong: "ㅎ", jungseong: "ㅏ");
  var h = HangulCharacter.fromCharacter("ㅎ");

  print(han); // 한
  print(ha); // 하
  print(h); // ㅎ

  print(han.choseong); // ㅎ
  print(han.jungseong); // ㅏ
  print(han.jongseong); // ㄴ

  print(h.choseong); // ㅎ
  print(h.jungseong); // null
  print(h.jongseong); // null

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

  print(han.romanize()); // han

  print(hangulRomainze("백마")); // baengma
  print(hangulRomainze("신라")); // silla
  print(
    hangulRomainze("Dart는 프로그래밍 언어입니다."),
  ); // Dartneun peurogeuraeming eoneoimnida.
}
