import 'package:flutter/material.dart';
import 'package:tdesign_flutter/td_export.dart';

enum TDTagType {
  /// 基础标签
  NORMAL,

  /// 基础标签
  SUCCESS,

  /// 基础标签
  WARNING,

  /// 基础标签
  ERROR,

  /// 基础标签
  MESSAGE,

  ///
  WIREFRAME,

  /// 浅底色标签
  LIGHT_BACKGROUND,

  /// 前底色标签自定义
  WIREFRAME_LIGHT_BACKGROUND,
}

enum TDTagSize { LARGE, MIDDLE, SMALL, CUSTOM }

/// 标签组件
/// 已完成：展示型方形标签
/// TODO： 点击型标签，带圆角标签
class TDTag extends StatelessWidget {
  /// 标签内容
  final String text;

  /// 标签类型
  final TDTagType? type;

  /// 标签大小
  final TDTagSize size;

  /// 自定义模式下的线框颜色
  final Color? wireFrameColor;

  /// 自定义模式下的字体颜色
  final Color? textColor;

  /// 自定义模式下的字体颜色
  final Font? font;

  /// 自定义模式下的浅底色颜色
  final Color? backgroundColor;

  /// 自定义模式下的字体粗细
  final FontWeight fontWeight;

  /// 自定义模式下的间距
  final EdgeInsets? padding;

  /// 自定义模式下的圆角宽度
  final double borderRadius;

  /// 自定义模式下的线框粗细
  final double border;

  /// 是否强制中文文字居中
  final bool forceVerticalCenter;

  const TDTag(this.text,
      {this.type = TDTagType.NORMAL,
        this.size = TDTagSize.MIDDLE,
        this.textColor,
        this.font,
        this.wireFrameColor,
        this.backgroundColor,
        this.fontWeight = FontWeight.normal,
        this.padding,
        this.borderRadius = 2,
        this.border = 1,
        this.forceVerticalCenter = true,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? _getPadding(),
      decoration: BoxDecoration(
          color: backgroundColor ?? _getBackgroundColor(context),
          border: Border.all(
              width: border,
              color: wireFrameColor ?? _getWireFrameColor(context)),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      child: TDText(
        text,
        forceVerticalCenter: forceVerticalCenter,
        textColor: textColor ?? _getTextColor(context),
        font: font ?? _getFont(context),
        fontWeight: fontWeight,
      ),
    );
  }

  Color _getTextColor(BuildContext context) {
    switch (type) {
      case TDTagType.NORMAL:
      case TDTagType.SUCCESS:
      case TDTagType.WARNING:
      case TDTagType.ERROR:
      case TDTagType.MESSAGE:
        return TDTheme.of(context).fontWhColor1;
      default:
        return TDTheme.of(context).brandNormalColor;
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    switch (type) {
      case TDTagType.NORMAL:
        return TDTheme.of(context).brandNormalColor;
      case TDTagType.SUCCESS:
        return TDTheme.of(context).successNormalColor;
      case TDTagType.WARNING:
        return TDTheme.of(context).warningNormalColor;
      case TDTagType.ERROR:
        return TDTheme.of(context).errorNormalColor;
      case TDTagType.MESSAGE:
        return TDTheme.of(context).grayColor7;
      case TDTagType.LIGHT_BACKGROUND:
      case TDTagType.WIREFRAME_LIGHT_BACKGROUND:
        return TDTheme.of(context).brandColor2;
      default:
        return TDTheme.of(context).whiteColor1;
    }
  }

  Color _getWireFrameColor(BuildContext context) {
    switch (type) {
      case TDTagType.WIREFRAME:
      case TDTagType.WIREFRAME_LIGHT_BACKGROUND:
        return TDTheme.of(context).brandNormalColor;
      default:
        return Colors.transparent;
    }
  }

  Font? _getFont(BuildContext context) {
    switch (size) {
      case TDTagSize.LARGE:
        return TDTheme.of(context).fontS;
      case TDTagSize.SMALL:
        return TDTheme.of(context).fontXXS;
      default:
        return TDTheme.of(context).fontXS;
    }
  }

  EdgeInsets _getPadding() {
    /// 为了文本居中，修改了padding的值
    switch (size) {
      case TDTagSize.LARGE:
        return const EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3);
      case TDTagSize.SMALL:
        return const EdgeInsets.only(left: 7, right: 7, top: 1, bottom: 1);
      default:
        return const EdgeInsets.only(left: 11, right: 11, top: 1, bottom: 1);
    }
  }
}
