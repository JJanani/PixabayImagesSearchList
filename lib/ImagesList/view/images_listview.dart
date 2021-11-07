import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixabay_project/ImagesList/viewModel/images_searchlist_viewModel.dart';
import 'package:pixabay_project/common_classes/base_widget.dart';
import 'package:pixabay_project/common_classes/utils.dart';
import 'package:pixabay_project/common_classes/view_state.dart';
import 'package:pixabay_project/common_widgets/check_internet_dialog.dart';
import 'package:pixabay_project/common_widgets/common_dialog.dart';
import 'package:pixabay_project/constants/Assets.dart';
import 'package:pixabay_project/constants/Colours.dart';
import 'package:pixabay_project/constants/Dimens.dart';
import 'package:pixabay_project/constants/Strings.dart';

import 'fullscreen_image.dart';

class ImagesListView extends StatefulWidget {
  const ImagesListView({Key key}) : super(key: key);

  @override
  _ImagesListViewState createState() => _ImagesListViewState();
}

class _ImagesListViewState extends State<ImagesListView> {
  ImagesSearchListViewmodel _viewModel;
  String _searchText = "";
  String _imageType = Strings.IMAGE_TYPE;
  int _page = 1;
  var _controller = ScrollController();
  var _textController = TextEditingController();
  BuildContext _mContext;

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print("bottom");
      _viewModel.isLoading = true;
      _viewModel.getNextPage(_searchText, _imageType, ++_page, context);
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print("top");
    }
  }

  void _dismissDialog() {
    Navigator.pop(_mContext);
  }

  @override
  void initState() {
    _controller = ScrollController();
    isConnected().then(
      (value) => {
        if (value)
          {_controller.addListener(_scrollListener)}
        else
          {
            CommonDialog.showDialogWithOkButton(
              context,
              Strings.INTERNET_CONNECTION_HEADING,
              Strings.INTERNET_CONNECTION_DESCRIPTION,
              _dismissDialog,
            )
          }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidget<ImagesSearchListViewmodel>(
        onModelReady: (model) => {
          model.getFirstPage(
            _searchText,
            _imageType,
            _page,
            context,
          ),
          _viewModel = model,
        },
        builder: (context, model, child) {
          if (model.apiCall.state == ViewState.BUSY && !model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (model.apiCall.isSuccess && isNotNull(model.apiCall.data) ) {
            return SafeArea(
              child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        bottom: 10.0,
                      ),
                      child: Container(
                        height: 50.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: TextField(
                                controller: _textController,
                                cursorColor: Color(Colours.COLOUR_5E56E7),
                                onChanged: (value) {
                                  _searchText = value;
                                },
                                decoration: InputDecoration(
                                  hintText: Strings.SEARCH_IMAGES,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _textController.clear();
                                      _searchText = "";
                                    },
                                    icon: Icon(Icons.close),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        Dimens.SIZE_4,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                isConnected().then(
                                  (value) => {
                                    if (value)
                                      {
                                        if (_searchText.isNotEmpty)
                                          model.getFirstPage(
                                            _searchText,
                                            _imageType,
                                            _page,
                                            context,
                                          )
                                      }
                                    else
                                      {
                                        CommonDialog.showDialogWithOkButton(
                                          context,
                                          Strings.INTERNET_CONNECTION_HEADING,
                                          Strings
                                              .INTERNET_CONNECTION_DESCRIPTION,
                                          _dismissDialog,
                                        )
                                      }
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Icons.search,
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isNotNullOrEmpty(model?.apiCall?.data?.hits)
                          ? GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.5,
                                crossAxisSpacing: 10,
                              ),
                              itemCount:
                                  model?.apiCall?.data?.hits?.length ?? 0,
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext count, int index) {
                                final images = model.apiCall.data.hits[index];
                                return GestureDetector(
                                  onTap: () {
                                    isConnected().then(
                                      (value) => {
                                        if (value)
                                          {
                                            {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                        return FullScreenImage(
                                                          imageUrl: images
                                                              .largeImageURL,
                                                          tag: "generate_a_unique_tag",
                                                        );
                                                      }))
                                            }
                                          }else
                                          {
                                            CommonDialog.showDialogWithOkButton(
                                              context,
                                              Strings
                                                  .INTERNET_CONNECTION_HEADING,
                                              Strings
                                                  .INTERNET_CONNECTION_DESCRIPTION,
                                              _dismissDialog,
                                            )
                                          }
                                      },
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Visibility(
                                          visible: isNotNull(images.webformatURL),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 120.0,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0x54000000),
                                                    spreadRadius: 4,
                                                    blurRadius: 2,
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.none,
                                                imageUrl: isNotNull(images.webformatURL)
                                                    ? images.webformatURL
                                                    : Strings.NO_IMAGE_AVAILABLE,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: isNull(images.webformatURL),
                                        child: Image(
                                          image: AssetImage(Assets.IC_CANCEL),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Text(
                            Strings.NO_IMAGES_FOUND,
                          ),
                    ),
                    Visibility(
                      visible: model.isLoading && isNotNullOrEmpty(model?.apiCall?.data?.hits),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text(Strings.ERROR);
          }
        },
      ),
    );
  }
}
