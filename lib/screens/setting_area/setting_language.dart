import 'package:flutter/material.dart';
import 'package:flutter_application_3/constants/all_constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';

import '../../../widgets/w_custom_divider.dart';
import '../../provider/main_provider.dart';
import '../../widgets/w_custom_back_button.dart';
import '../../widgets/w_setting_language_item.dart';

class SettingLanguageScreen extends StatefulWidget {
  const SettingLanguageScreen({Key? key}) : super(key: key);

  @override
  State<SettingLanguageScreen> createState() => _SettingLanguageScreenState();
}

class _SettingLanguageScreenState extends State<SettingLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        alignment: Alignment.center,
        width: double.infinity,
        color: AppColors.greyColor,
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: BackButtonCustom(
                        content: SvgPicture.asset(AppAssets.iconBack),
                        function: () {
                          Navigator.pop(context);
                        }),
                  ),
                ),
                Positioned(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).test,
                        style: mediumTextStyle(
                            color: AppColors.greyColor,
                            size: 19,
                            fontFamily: boldFont,
                            decoration: TextDecoration.none),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 48,
            ),
            Container(
              margin: const EdgeInsets.all(24),
              // height: ,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: Align(
                      child: Text(
                        S.of(context).language,
                        style: mediumTextStyle(
                            color: AppColors.greyColor,
                            size: 14,
                            decoration: TextDecoration.none),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        SettingLanguageItem(
                          language: S.of(context).vietnamese,
                          visible: mainProvider.getVisible,
                          locale: 'vi',
                        ),
                        const CustomDivider(
                            height: 0.8,
                            padding: EdgeInsets.symmetric(horizontal: 40)),
                        SettingLanguageItem(
                          language: S.of(context).english,
                          visible: !mainProvider.getVisible,
                          locale: 'en',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
