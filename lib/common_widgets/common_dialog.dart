import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixabay_project/constants/Colours.dart';
import 'package:pixabay_project/constants/Dimens.dart';
import 'package:pixabay_project/constants/Fonts.dart';
import 'package:pixabay_project/constants/Strings.dart';

class CommonDialog {
  static showDialogWithOkButton(BuildContext context, String title,
      String description, Function onPress) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
              height: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Color(Colours.COLOUR_000000),
                        fontSize: Dimens.SIZE_17,
                        fontFamily: Fonts.FONT_MONTSERRAT_BLACK,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 16, right: 16, bottom: 16),
                    child: Text(
                      description,
                      style: TextStyle(
                          color: Color(Colours.COLOUR_666666),
                          fontSize: 14,
                          fontFamily: Fonts.FONT_MONTSERRAT_LIGHT),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: onPress,

                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8)
                              )
                            ),
                            visualDensity: VisualDensity.comfortable,
                            color: Color(Colours.COLOUR_333333),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical:8.0),
                              child: Text(
                                Strings.OK,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimens.SIZE_17,
                                  fontFamily: Fonts.FONT_MONTSERRAT_BOLD,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: ()=>Navigator.of(context).pop(),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
