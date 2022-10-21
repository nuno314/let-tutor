import '../../../../common/definations.dart';

const listingModuleEvent = '''part of '${moduleNameKey}_bloc.dart';

abstract class ${classNameKey}Event {}

class GetDataEvent extends ${classNameKey}Event {}

class LoadMoreDataEvent extends ${classNameKey}Event {}''';
