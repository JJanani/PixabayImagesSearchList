import 'dart:async';
import 'dart:core';
import 'package:pixabay_project/common_classes/api_constant.dart';
import 'package:pixabay_project/common_classes/network/app_exception.dart';
import 'package:pixabay_project/common_classes/network/http.dart';
import 'package:pixabay_project/common_classes/utils.dart';
import 'package:pixabay_project/model/images_model.dart';

class ImagesSearchListRepository {
  Future<ImagesModel> getImages() async {
    try {
      String path = ApiConstants.IMAGES_ENDPOINT;
      var response = await httpClient().get(path,
          queryParameters: {"key": "4154781-c5f6512209417b02e70c93613"});
      if (response.statusCode == 200) {
        return ImagesModel.fromJson(response.data);
      } else {
        throw AppException(
          errorCode: response.statusCode,
          errorMessage: response.data,
        );
      }
    } catch (e) {
      return null;
    }
  }

  Future<ImagesModel> getRequestedImage({
    String searchTerm,
    String imageType,
    int page,
  }) async {
    try {
      String path = ApiConstants.IMAGES_ENDPOINT;
      final query = Map<String, dynamic>();
      query['key'] = "24154781-c5f6512209417b02e70c93613";
      if (isNotNull(searchTerm) && searchTerm.isNotEmpty) {
        query['q'] = searchTerm;
      }
      if (isNotNull(imageType) && imageType.isNotEmpty) {
        query['image_type'] = imageType;
      }
      if (isNotNull(page) && !page.isNegative) {
        query['page'] = page;
      }
      var response = await httpClient().get(
        path,
        queryParameters: query,
      );
      print(response);
      if (response.statusCode == 200) {
        return ImagesModel.fromJson(response.data);
      } else {
        throw AppException(
          errorCode: response.statusCode,
          errorMessage: response.data,
        );
      }
    } catch (e) {
      return null;
    }
  }
}
