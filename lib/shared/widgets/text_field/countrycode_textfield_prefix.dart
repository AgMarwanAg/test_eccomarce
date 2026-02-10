
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../models/country_model.dart';
// import '/shared/extensions/size_ex.dart';

// import '../text_widget.dart';

// class CountryCodeTextFieldPrefix extends StatefulWidget {
//   final ValueChanged<Country>? onChanged;
//   const CountryCodeTextFieldPrefix({super.key, required this.onChanged});

//   @override
//   State<CountryCodeTextFieldPrefix> createState() => _CountryCodeTextFieldPrefixState();
// }

// class _CountryCodeTextFieldPrefixState extends State<CountryCodeTextFieldPrefix> {
//   late List<Country> items;
//   late Country selected;
//   @override
//   void initState() {
//     super.initState();
//     items = Country.fromList();
//     selected = Country.defaultCountry();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DialogDropdown<Country>(
//       items: items,
//       value: selected,
//       width: 100.w,
//       decoration: const BoxDecoration(),
//       selectedItem: TextWidget(selected.code, style: AppTextStyle.s16W500, textAlign: TextAlign.center, withLocale: false),
//       onChanged: (value) {
//         widget.onChanged!(value);
//         setState(() {
//           selected = value;
//         });
//       },
//       itemBuilder: (context, item, isSelected) {
//         return _buildItem(item);
//       },
//     );
//   }

//   Widget _buildItem(Country item) {
//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: Row(children: [ImageNetwork(url: item.flag, width: 30.w, height: 30.w), 5.sizeW, TextWidget(item.code, style: AppTextStyle.s16W500, textAlign: TextAlign.center, withLocale: false)]),
//     );
//   }
// }
