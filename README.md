# hangul_utils
[![Pub Version](https://img.shields.io/pub/v/hangul_utils)](https://pub.dev/packages/hangul_utils)

hangul_utils은 Dart에서 한글을 효과적으로 다룰 수 있는 패키지입니다.

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
var kang = HangulCharacter.fromCharacter("강");
var k = HangulCharacter.fromCharacter("ㄱ");

print(kang); // 강
print(k); // ㄱ

print(kang.choseong); // ㄱ
print(kang.jungseong); // ㅏ
print(kang.jongseong); // ㅇ

print(k.choseong); // ㄱ
print(k.jungseong); // null
print(k.jongseong); // null
```

### hangulJosa
HangulJosaSelection에서 입력받은 텍스트의 마지막 글자의 받침 여부를 josaNoFinalConsonant와 josaWithFinalConsonant를 텍스트와 합쳐 반환합니다. HangulJosaSelectionIGa와 HangulJosaSelectionEulReul는 이/가, 을/를입니다.

```dart
print("${hangulJosa("강아지", HangulJosaSelectionIGa())} 노래를 한다."); // 강아지가 노래를 한다.
print("${hangulJosa("바깥", HangulJosaSelection("으로", "로"))} 돌을 던졌다."); // 바깥으로 돌을 던졌다.
```

마지막 글자가 영어인 경우는 받침이 없는 것으로 판단해 HangulJosaSelection의 josaNoFinalConsonant와 합쳐 반환합니다.

```dart
print("${hangulJosa("Dart", HangulJosaSelectionEulReul())} 실행했습니다."); // Dart를 실행했습니다.
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
