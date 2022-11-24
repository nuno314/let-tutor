part of 'settings_screen.dart';

extension SettingsAction on _SettingsScreenState {
  void _blocListener(BuildContext context, SettingsState state) {
    if (state is ChangeLanguageSuccess) {
      hideLoading();
      Navigator.pop(context);
    }
  }

  void showLanguagePicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(trans.language),
        content: Row(children: [
          Expanded(
            child: CountryItem(
                name: trans.vietnamese,
                iconPath: Assets.image.imgVietnam,
                onTap: () {
                  showLoading();
                  bloc.add(SetVietnameseLanguageEvent());
                }),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: CountryItem(
                name: trans.english,
                iconPath: Assets.image.imgUs,
                onTap: () {
                  showLoading();
                  bloc.add(SetEnglishLanguageEvent());
                }),
          )
        ]),
      ),
    );
  }

  void onChangePassword() {
    Navigator.pushNamed(context, RouteList.changePassword);
  }
}
