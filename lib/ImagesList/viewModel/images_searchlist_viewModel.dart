import 'package:flutter/material.dart';
import 'package:pixabay_project/common_classes/base_viewmodel.dart';
import 'package:pixabay_project/common_classes/locator.dart';
import 'package:pixabay_project/common_classes/network/api_call.dart';
import 'package:pixabay_project/common_classes/view_state.dart';
import 'package:pixabay_project/constants/Strings.dart';
import 'package:pixabay_project/model/images_model.dart';
import 'package:pixabay_project/repository/images_searchList_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ImagesSearchListViewmodel extends BaseViewModel {
  ApiCall<ImagesModel> _apiCall = ApiCall();

  ApiCall<ImagesModel> get apiCall => _apiCall;
  ImagesSearchListRepository _imagesListRepository = locator<ImagesSearchListRepository>();
  BuildContext buildContext;
  bool isLoading = false;

  void _getImages(
    String searchTerm,
    String imageType,
    int page,
    BuildContext context,
  ) async {
    this.buildContext = context;
    setState(apiCall, ViewState.BUSY);
    try {
      ImagesModel response = await _imagesListRepository.getRequestedImage(
        searchTerm: searchTerm,
        imageType: imageType,
        page: page,
      );
      if (page == 1) {
        setSuccessResponse(_apiCall, response);
      } else {
        addMoreData(apiCall, page, response);
      }
    } catch (e) {
      setErrorResponse(_apiCall, e);
    }
  }

  void getFirstPage(
    String searchTerm,
    String imageType,
    int page,
    BuildContext context,
  ) {
    _getImages(searchTerm, imageType, 1, context);
  }

  void getNextPage(
    String searchTerm,
    String imageType,
    int page,
    BuildContext context,
  ) {
    if (page > 0)
      _getImages(
        searchTerm,
        imageType,
        page,
        context,
      );
    else {
      isLoading = false;
      setState(
        apiCall,
        ViewState.IDLE,
      );
    }
  }

  Future<int> addMoreData(
    ApiCall<ImagesModel> apiCall,
    int page,
    ImagesModel data,
  ) async {
    apiCall.isSuccess = true;
    apiCall.data.hits.addAll(data.hits);
    apiCall.state = ViewState.IDLE;
    notifyListeners();
    return page;
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print(Strings.CANNOT_OPEN);
    }
  }

  void openImageWithUrl(BuildContext context, Hits hits) async {
    _launchUrl(hits.largeImageURL);
  }



}
