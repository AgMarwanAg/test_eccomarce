import 'dart:math';
import 'package:flutter/material.dart';

import '../di/locator.dart';
import '../localization/localization_service.dart';

/// A singleton class responsible for generating dummy text in English or Arabic.
/// The class supports customization for adding tabs, emojis, and controlling paragraph formatting.
class TxtGen {
  /// Private constructor for internal initialization.
  TxtGen._internal();

  /// Singleton instance of [TxtGen].
  static TxtGen? _instance;

  /// Getter for the singleton instance of [TxtGen].
  static TxtGen get instance {
    _instance ??= TxtGen._internal();
    return _instance!;
  }

  /// Boolean flag indicating whether to generate Arabic text instead of English.
  bool arabicText = sl<LocalizationService>().isAr;

  /// Initializes the [TxtGen] with an optional parameter to set the language to Arabic.
  /// 
  /// [arabicText]: If true, generates Arabic dummy text. Defaults to false.
  // static void init({bool arabicText = false}) {
  //   _instance ??= TxtGen._internal();
  //   instance.arabicText = arabicText;
  // }

  static const Color starColor = Color(0xfff9c700); // Color for star elements
  static const Color goldColor = Color(0xffFFDF00); // Color for gold elements
  static const Color silverColor = Color(0xffC0C0C0); // Color for silver elements

  static const String _englishDummyText =
      "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc. Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc";

  static const String _arabicDummyText =
      "لوريم إيبسوم، أو ليبسوم كما يعرف أحيانًا، هو نص دمية يستخدم في تخطيط التصميمات الطباعية أو الرسوم البيانية أو على شبكة الإنترنت. يعود النص إلى ناشر غير معروف في القرن الخامس عشر الذي يعتقد أنه قد قلب أجزاءً من 'دي فينيبوس بونوروم إت مالوروم' لسيسرو لاستخدامها في كتاب عينة نوع الطباعة. هناك العديد من الاختلافات في مقاطع لوريم إيبسوم المتاحة، ولكن الغالبية قد تعرضت لتعديل بشكل ما، سواء بواسطة الفكاهة المدمجة أو بواسطة كلمات عشوائية لا تبدو مصداقية حتى القليل. إذا كنت ستستخدم مقطعًا من لوريم إيبسوم، فيجب أن تتأكد من أنه لا يوجد شيء محرج مخفي في وسط النص. جميع مُولِّدَي لوريم إيبسوم على الإنترنت يميلون إلى تكرار أجزاء معينة حسب الضرورة، مما يجعل هذا أول مولد حقيقي على الإنترنت. إنه يستخدم قاموسًا يحتوي على أكثر من 200 كلمة لاتينية، بالإضافة إلى مجموعة صغيرة من هياكل الجمل النموذجية، لتوليد لوريم إيبسوم الذي يبدو معقولًا. النص الذي تم إنشاؤه بواسطة لوريم إيبسوم هو دائمًا خالي من التكرار والفكاهة المدمجة أو الكلمات غير المميزة وما إلى ذلك.";

  static const String _emojiText = "😀 😃 😄 😁 😆 😅 😂 🤣 😍 🥰 😘 😠 😡 💩 👻 🧐 🤓 😎 😋 😛 😝 😜 😢 😭 😤 🥱 😴 😾";

  /// Generates dummy text with a specified number of words.
  /// 
  /// [words]: The number of words to generate.
  /// [withTab]: If true, adds a tab at the beginning of the text. Defaults to false.
  /// [withEmoji]: If true, includes emojis in the generated text. Defaults to false.
  /// [withStop]: If true, adds a period at the end of the text. Defaults to true.
  String getDummyText(
    int words, {
    bool withTab = false,
    bool withEmoji = false,
    bool withStop = true,
  }) {
    var rand = Random();
    List<String> dummyTexts = arabicText ? _arabicDummyText.split(" ") : _englishDummyText.split(" ");

    if (withEmoji) {
      dummyTexts.addAll(_emojiText.split(" "));
    }

    int size = dummyTexts.length;
    String text = "";
    if (withTab) text += "\t\t\t\t";
    String firstWord = dummyTexts[rand.nextInt(size)];
    firstWord = firstWord[0].toUpperCase() + firstWord.substring(1);
    text += "$firstWord ";

    for (int i = 1; i < words; i++) {
      text += dummyTexts[rand.nextInt(size)] + (i == words - 1 ? "" : " ");
    }

    return text + (withStop ? "." : "");
  }

  /// Generates paragraphs of dummy text.
  /// 
  /// [words]: The number of words per paragraph. Defaults to 20.
  /// [paragraph]: The number of paragraphs to generate. Defaults to 1.
  /// [withHyphen]: If true, adds hyphen as a separator between paragraphs. Defaults to false.
  /// [withEmoji]: If true, includes emojis in the generated text. Defaults to false.
  String getParagraphsText({
    int words = 20,
    int paragraph = 1,
    bool withHyphen = false,
    bool withEmoji = false,
  }) {
    String text = "";
    for (int i = 0; i < paragraph; i++) {
      if (withHyphen) {
        text += "\t\t-\t\t";
      } else {
        text += "\t\t\t\t";
      }
      text += getDummyText(words, withEmoji: withEmoji);
    }
    return text;
  }
}