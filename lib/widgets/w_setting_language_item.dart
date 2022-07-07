import 'package:flutter/material.dart';
import 'package:flutter_application_3/constants/all_constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../provider/main_provider.dart';

class SettingLanguageItem extends StatelessWidget {
  const SettingLanguageItem({
    Key? key,
    required this.language,
    required this.visible,
    required this.locale,
  }) : super(key: key);
  final String language;
  final bool visible;
  final String locale;
  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);
    return GestureDetector(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        height: 48,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.only(left: 4),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                language,
                style: medium400TextStyle(
                    color: AppColors.indyBlue,
                    size: 16,
                    decoration: TextDecoration.none),
              ),
              Expanded(child: Container()),
              Visibility(
                visible: visible,
                child: Container(
                    margin: const EdgeInsets.only(right: 22),
                    child: SvgPicture.asset(AppAssets.iconSelect)),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        mainProvider.setVisible(!mainProvider.getVisible);
        mainProvider.setLocale(locale);
        // settingProvider.setLocale()
      },
    );
  }
}
