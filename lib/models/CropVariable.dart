import 'package:flutter/cupertino.dart';

class CropVariable {
  String id;
  String title;
  String subtitle;
  IconData leftIcon;
  IconData topRightIcon;
  IconData bottomRightIcon;
  bool isEnable;
  CropVariable(
      {this.title,
      this.subtitle,
      this.leftIcon,
      this.topRightIcon,
      this.bottomRightIcon,
      this.isEnable,
      this.id});
}
