# Convert BLoC to Riverpod

## Why Riverpod?

- Another state management solution I want to apply to this project. 
- Impressed me with its simplicity, flexibility, performance and testability.

## Scenario
I will create a profile module with BLoC to manage state and then convert to Riverpod. The presentation flow will describe how it was created.

### Project Setup

Add required dependencies in pubspec.yaml file.
```
  flutter_riverpod: ^2.3.2
```

### Data Source
Mock a future response to return an ```User```
```dart
class MockProfileRepository {
	Future<User?> getUserInfomation() {
    	return Future.value(
        	User(name:"Nuno"),
        );
    }
}
```

### Profile Module
#### Structure
We will implement a module repository, pass in `BLoC` to get data, and build `flutter_bloc` widgets in `views` to handle and update UI when state changes.
```
├── bloc
│   ├── profile_bloc.dart
│   ├── profile_event.dart
|   └── profile_state.dart
├── repository
│   ├── profile_repostiory.dart
|   └── profile_repository.impl.dart
├── views
│   ├── profile_screen.dart
|   └── profile.action.dart
└── profile.dart
```
#### Repository
The abstract class to define the function and the implementation class has been added `MockProfileRepository` above to get the data.
```
class ProfileRepositoryImpl implements ProfileRepository {
  final _repository = MockProfileRepository();

  @override
  Future<User?> getUserInformation() {
    return _repository.getUserInfomation();
  }
}
```

#### BLoC
```
class ProfileBloc extends AppBlocBase<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;
  ProfileBloc({required ProfileRepository repository})
      : super(ProfileInitial(viewModel: _ViewModel())) {
    _repository = repository;
    on<GetProfileEvent>(_onProfileEvent);
  }

  Future<void> _onProfileEvent(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final res = await _repository.getUserInfomation();
    emit(
      state.copyWith(
        viewModel: state.viewModel.copyWith(
          user: res?.user,
        ),
      ),
    );
  }
  ```
