import 'package:get_it/get_it.dart';
import 'package:pixabay_project/ImagesList/viewModel/images_searchlist_viewModel.dart';
import 'package:pixabay_project/repository/images_searchList_repository.dart';

GetIt locator=GetIt.instance;
void setupLocator(){
  locator.registerFactory(() => ImagesSearchListRepository());
  locator.registerFactory(() => ImagesSearchListViewmodel());
}