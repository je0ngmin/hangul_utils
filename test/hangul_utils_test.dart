import 'package:hangul_utils/hangul_utils.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {});

    test("HangulCharacter test", () {
      expect(HangulCharacter.fromCharacter("강").choseong, "ㄱ");
      expect(HangulCharacter.fromCharacter("강").jungseong, "ㅏ");
      expect(HangulCharacter.fromCharacter("강").jongseong, "ㅇ");
      expect(HangulCharacter.fromCharacter("강").toString(), "강");
    });

    test("isHangul test", () {
      expect(isHangul("한글"), isTrue);
      expect(isHangul("한글로 작성한 문장입니다"), isTrue);
      expect(isHangul("Hangul"), isFalse);
      expect(isHangul("Hangul입니다."), isFalse);
    });

    test('Josa Test', () {
      expect(
        "${hangulJosa("강아지", HangulJosaSelectionIGa())} 밥을 먹었다.",
        "강아지가 밥을 먹었다.",
      );
      expect(
        "${hangulJosa("오랑우탄", HangulJosaSelectionIGa())} 밥을 먹었다.",
        "오랑우탄이 밥을 먹었다.",
      );
      expect(
        "${hangulJosa("Dart", HangulJosaSelectionEulReul())} 실행했습니다.",
        "Dart를 실행했습니다.",
      );
    });
  });
}
