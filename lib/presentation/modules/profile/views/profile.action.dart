part of 'profile_screen.dart';

extension ProfileAction on _ProfileScreenState {
  void _blocListener(BuildContext context, ProfileState state) {}

  void loadData() {
    _nameController.text = user.name;
    _emailController.text = user.email;
    _countryController.text = user.country;
    _phoneNumberController.text = user.phoneNumber;
    _dobController.text = user.dob;
    _levelController.text = user.level;
  }

  void saveChanges() {
    Navigator.pop(context);
  }
}
