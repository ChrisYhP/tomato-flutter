import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryEvent {
  const CategoryEvent({this.item});
  final CategoryItem item;
}

class CategoryItem {
  const CategoryItem({this.name, this.color});
  final String name;
  final Color color;
}

abstract class CategoryState {}

class AddCategoryState extends CategoryState {
  AddCategoryState({this.list});
  final List<CategoryItem> list;
}

class CategoryBloc extends Bloc<CategoryEvent, AddCategoryState> {
  @override
  AddCategoryState get initialState => AddCategoryState();

  @override
  Stream<AddCategoryState> mapEventToState(CategoryEvent event) async* {
    yield AddCategoryState(list: [event.item]);
    print(state.list);
  }
}
