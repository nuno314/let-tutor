# Migrate from BLoC to Riverpod

## Why Riverpod?

- Another state management solution I want to apply to this project. 
- Impressed me with its simplicity, flexibility, performance and testability.

## Scenario
I will create a profile module with BLoC to manage state and then migrate to Riverpod. The presentation flow will describe how it was created.

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
```dart
class ProfileRepositoryImpl implements ProfileRepository {
  final _repository = MockProfileRepository();

  @override
  Future<User?> getUserInformation() {
    return _repository.getUserInfomation();
  }
}
```

#### Event
An abstract event class and implemenetation class to get Profile.
```dart
part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}
```
#### State
An abstract state class to store data and implemenetation classes for diffenrent cases.
```dart
part of 'profile_bloc.dart';

abstract class ProfileState {
  final User? user;

  ProfileState({this.user});

  T copyWith<T extends ProfileState>({
    User? user,
  }) {
    return _factories[T == ProfileState ? runtimeType : T]!(
      user ?? this.user,
    );
  }
}

class ProfileInitial extends ProfileState {
  ProfileInitial({
    User? user,
  }) : super();
}

final _factories = <
    Type,
    Function(
  User? user,
)>{
  ProfileInitial: (user) => ProfileInitial(
        user: user,
      ),
};

```
#### BLoC
Using `bloc` to take a `Stream` of `Events` as input and transforms them into a `Stream` of `States` as output.

```dart
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _repository = ProfileRepository(ProfileRepositoryImpl());
  ProfileBloc() : super(ProfileInitial(viewModel: _ViewModel())) {
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
#### BLoC Overview
In this example, the processing flow will be: data is taken from the repository layer, then passed to the block. BloC registers functions to handle events. For each event, there will be processing logic and states that are emitted to the UI layer.

When the module expands, in addition to having to be very explicit in declaring events to register the event handler, getting data at the repository layer is not in the constructor, so it is difficult to test. Obviously we can put the repository in the constructor, but that will affect Routing & Navigation. See the example below.

```dart
class ProfileRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.profile: (context) {
          return BlocProvider(
            create: (context) => ProfileBloc(),
            child: const ProfileScreen(),
          );
        },
      };
}
```
## Migration
The main part of this topic will be started here. We started the BLoC to Riverpod migration by reusing ProfileState and adding something to the repository class. Let's back to Repository layer.
#### Structure
Just replace bloc with provider.
```
├── provider
│   ├── profile_provider.dart
|   └── profile_state.dart
├── repository
│   ├── profile_repostiory.dart
|   └── profile_repository.impl.dart
├── views
│   ├── profile_screen.dart
|   └── profile.action.dart
└── profile.dart
#### Repository`
```
#### Repository


```dart
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl();
});
```
A new concept `Provider` is added to repository, an access point to a shared state.
From now on, we can use and access this globally. 
#### Provider
We will create a whole new state management sysyem for this module. Firstly, create class ProfileProfile.
```dart
class ProfileProvider extends StateNotifier<ProfileState> {
  final ProfileRepository repository;
  ProfileProvider(this.repository) : super(ProfileState());

  Future<void> getUserInformation() async {
    final res = await repository.getUserInformation();
    state = state.copyWith(user: res);
  }
}
```
This class extends StateNotifier storing a ProfileState. It will be able to:

- compare previous and new state.
- implement undo-redo mechanism.
- debug the application state.

Then define some functions to get data and update current state. So what will happen when state changes?
```dart
final profileProvider =
    StateNotifierProvider<ProfileProvider, ProfileState>((ref) {
  return ProfileProvider(ref.read(profileRepositoryProvider));
});
```
When the state of a `StateNotifier` changes, it will call the `stateChanged()` method of the StateNotifierProvider. This method will notify any dependent widgets that the state has changed, which will trigger a rebuild of those widgets.

During the rebuild, the `StateNotifierProvider` will obtain the new state of the `StateNotifier` and provide it to the dependent widgets. This ensures that the widgets always have access to the latest state of the `StateNotifier`.

In short, when state changes, this provider will notify and trigger rebuild of dependent widgets.
#### Usage in `views`
A simple example of watching and listening for state changes. Remember to use ConsumerWidget to use ref, an object that allows widgets to interact with providers.
```dart
late ProfileProvider provider;

@override
void initState() {

  provider = ref.read(profileProvider.notifier)..getUserInformation();
  
  super.initState();
  
}

...
 
late User? _user;
 
@override
Widget build(BuildContext context) {

  final state = ref.watch(profileProvider);
  
  _user = state.user;
  
  ...
  
 }
```
## Conclusion

Both Bloc and Riverpod are powerful and advanced state management solutions. Every state management solution has its pros and cons, and as we stated earlier, there isn’t a solution that is best for every single application. If you are want to migrate from Bloc to Riverpod, I hope this blog helped you understand the basics and how they work. 

Happy coding!