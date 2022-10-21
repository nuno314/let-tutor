part of 'reset_password_screen.dart';

class ResetPasswordConfirmScreen extends StatefulWidget {
  const ResetPasswordConfirmScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordConfirmScreen> createState() =>
      _ResetPasswordConfirmScreenState();
}

class _ResetPasswordConfirmScreenState
    extends State<ResetPasswordConfirmScreen> {
  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return ScreenForm(
      trans: trans,
      showHeaderImage: false,
      iconTitle: SvgPicture.asset(
        Assets.svg.icLogo,
        height: 40,
      ),
      child: _buildConfirm(),
    );
  }

  Widget _buildLanguageSelection() {
    final languageList = [
      DropdownLanguageArgs(
        title: trans.vietnamese,
        iconPath: Assets.svg.icVietnam,
      ),
      DropdownLanguageArgs(
        title: trans.english,
        iconPath: Assets.svg.icUs,
      ),
    ];
    var _selectedLanguage = languageList[0];

    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<DropdownLanguageArgs>(
          value: _selectedLanguage,
          items: languageList
              .map(
                (e) => DropdownMenuItem<DropdownLanguageArgs>(
                  child: Container(
                    width: 100,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(e.title),
                        Spacer(),
                        SvgPicture.asset(
                          e.iconPath,
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                  value: e,
                ),
              )
              .toList(),
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget _buildConfirm() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              trans.resetPassword,
              style: textTheme.bodyText1?.copyWith(fontSize: 30),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              trans.checkMail,
              style: textTheme.bodyText2?.copyWith(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
