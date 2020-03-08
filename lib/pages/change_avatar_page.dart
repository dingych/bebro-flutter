import 'package:bebro/config/my_icon.dart';
import 'package:bebro/pages/clip_img_page.dart';
import 'package:bebro/config/theme.dart';
import 'package:bebro/state/global.dart';
import 'package:bebro/state/profile_change_notifier.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ChangeAvatarPage extends StatelessWidget {
  final int type;

  const ChangeAvatarPage({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type == 1
            ?'更改头像'
            :'更改背景', style: textDisplayDq),
        bottom: PreferredSize(
          child: Container(),
          preferredSize: Size.fromHeight(-8),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(150)),
            width: ScreenUtil().setWidth(1080),
            height: ScreenUtil().setWidth(1080),
            child: _buildImage()
          ),
          Container(
            width: ScreenUtil().setWidth(390),
            child: FlatButton(
              child: Text(
                '选择图片',
                style: textDisplayDq.copyWith(
                    color: Colors.white, fontSize: ScreenUtil().setSp(46)),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                ImagePicker.pickImage(
                    source: ImageSource.gallery, imageQuality: 60)
                    .then((image) {
                  if (image != null) {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ClipImgPage(image: image,type: type,)));
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    var widget;
    if(type== 1){
      widget = Global.profile.user.avatarUrl ==null
      ? Image.asset('images/flutter_logo.png')
      : ExtendedImage.network(Global.profile.user.avatarUrl);
    }else{
      widget = Global.profile.user.backImgUrl ==null
          ? Image.asset('images/back.jpg')
          : ExtendedImage.network(Global.profile.user.backImgUrl);
    }
    return widget;
  }
}