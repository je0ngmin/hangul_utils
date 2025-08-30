# hangul_utils
[![Pub Version](https://img.shields.io/pub/v/hangul_utils)](https://pub.dev/packages/hangul_utils)

hangul_utils는 Dart에서 한글을 효과적으로 다룰 수 있도록 돕는 패키지입니다.

hangul_utils is an effective package for handling Hangul in Dart.

# Install

```sh
$ dart pub add hangul_utils
```

## Features

## Getting started

## Usage

### HangulCharacter
HangulCharacter는 한글 한 글자를 표현하는 클래스입니다. 한글 음절을 초성, 중성, 종성 단위로 분해해 표현하며 다시 합성할 수 있습니다.
HangulCharacter.fromCharacter로 생성합니다.

```dart
var river = HangulCharacter.fromCharacter("강");
var g = HangulCharacter.fromCharacter("ㄱ");

print(river); // 강
print(g); // ㄱ

print(river.choseong); // ㄱ
print(river.jungseong); // ㅏ
print(river.jongseong); // ㅇ

print(g.choseong); // ㄱ
print(g.jungseong); // null
print(g.jongseong); // null

print(river.romanize()); // gang
```

### hangulJosa
HangulJosaSelection에서 입력받은 텍스트의 마지막 글자의 받침 여부를 josaNoFinalConsonant와 josaWithFinalConsonant를 텍스트와 합쳐 반환합니다.

HangulJosaSelectionIGa, HangulJosaSelectionEulReul, HangulJosaSelectionEunNeun, HangulJosaSelectionWaGwa, HangulJosaSelectionIrangRang 같은 프리셋들도 있습니다.

```dart
print("${hangulJosa("강아지", HangulJosaSelectionIGa())} 노래를 한다."); // 강아지가 노래를 한다.
print("${hangulJosa("친구", HangulJosaSelectionWaGwa())} 놀러 나갔다.");
print("${hangulJosa("바깥", HangulJosaSelection("으로", "로"))} 돌을 던졌다."); // 바깥으로 돌을 던졌다.
```

마지막 글자가 한글이 아닌 경우 HangulJosaSelection의 을(를) 형식으로 조사가 정해집니다. 

```dart
print("${hangulJosa("Dart", HangulJosaSelectionEulReul())} 실행했습니다."); // Dart을(를) 실행했습니다.
```

### hangulRomainze
한국어 텍스트를 입력받아 로마자로 표기한 문자열을 반환합니다.

[국어의 로마자 표기법](https://korean.go.kr/kornorms/regltn/regltnView.do?regltn_code=0004)에 따라 로마자로 표기합니다.

```dart
print(hangulRomainze("백마")); //baengma
print(hangulRomainze("신라")); // silla
print(hangulRomainze("학여울")); // hangnyeoul
print(hangulRomainze("놓다")); // nota
print(hangulRomainze("집현전")); // jiphyeonjeon
print(hangulRomainze("잡혀")); // japyeo
print(hangulRomainze("Dart는 프로그래밍 언어입니다.")); // Dartneun peurogeuraeming eoneoimnida.
```

### hangulChoseong
한글 텍스트의 초성을 반환합니다.

```dart
print(hangulChoseong("다람쥐 헌 쳇바퀴에 타고파")); // ㄷㄹㅈ ㅎ ㅊㅂㅋㅇ ㅌㄱㅍ
print(hangulChoseong("Dart는 프로그래밍 언어입니다.")); // Dartㄴ ㅍㄹㄱㄹㅁ ㅇㅇㅇㄴㄷ.
```


### isHangul
매개변수로 받은 텍스트가 모두 한글인지 확인하는 함수입니다.

공백을 제외하고, 만약 한 글자라도 한글이 아닌 문자가 있을 시 false를 반환하고 모두 한글일 시 true를 반환합니다.

```dart
print(isHangul("한글")); // true
print(isHangul("이것은 한글입니다")); // true
print(isHangul("Hangul")); // false
print(isHangul("It's 한글")); // false
print(isHangul("저는 한글입니까?")); // false
```
