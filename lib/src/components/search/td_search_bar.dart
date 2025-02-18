import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign_flutter/td_export.dart';

typedef TDSearchBarEvent = void Function(String value);
typedef TDSearchBarCallBack = void Function();

class TDSearchBar extends StatefulWidget {
  final String? placeHolder;
  final Color? backgroundColor;
  final TDSearchBarEvent? onTextChanged;
  final TDSearchBarEvent? onSubmitted;
  final TDSearchBarCallBack? onEditComplete;

  const TDSearchBar({
    Key? key,
    this.placeHolder,
    this.onTextChanged,
    this.onSubmitted,
    this.onEditComplete,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TDSearchBarState();
}

class _TDSearchBarState extends State<TDSearchBar> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  bool clearBtnHide = true;
  bool cancelBtnHide = true;

  void initState() {
    super.initState();
    controller.addListener(() {
      bool clearVisible = controller.text.isNotEmpty;
      _updateClearBtnVisible(clearVisible);
    });
    focusNode.addListener(() {
      _updateCancelBtnVisible(focusNode.hasFocus);
    });
  }

  void _updateClearBtnVisible(bool visible) {
    setState(() {
      clearBtnHide = !visible;
    });
  }

  void _updateCancelBtnVisible(bool visible) {
    setState(() {
      cancelBtnHide = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      height: 56,
      color: widget.backgroundColor,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              color: TDTheme.of(context).grayColor1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 6)),
                  Icon(
                    TDIcons.search,
                    size: 24,
                    color: TDTheme.of(context).fontGyColor3,
                  ),
                  const Padding(padding: EdgeInsets.only(left: 3)),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: controller,
                      autofocus: true,
                      focusNode: focusNode,
                      style: TextStyle(
                          fontSize: TDTheme.of(context).fontM?.size,
                          color: TDTheme.of(context).fontGyColor3),
                      decoration: InputDecoration(
                        hintText: widget.placeHolder,
                        hintStyle: TextStyle(
                            fontSize: TDTheme.of(context).fontM?.size,
                            color: TDTheme.of(context).fontGyColor3),
                        border: InputBorder.none,
                        isCollapsed: true,
                        filled: true,
                        fillColor: TDTheme.of(context).grayColor1,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 8)),
                  Offstage(
                    offstage: clearBtnHide,
                    child: GestureDetector(
                        onTap: () => {controller.clear()},
                        child: Icon(
                          TDIcons.close_circle_filled,
                          size: 24,
                          color: TDTheme.of(context).fontGyColor3,
                        )),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 8)),
                ],
              ),
            ),
          ),
          Offstage(
            offstage: cancelBtnHide,
            child: GestureDetector(
              onTap: () {
                focusNode.unfocus();
              },
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                child: Text('取消',
                    style: TextStyle(
                        fontSize: TDTheme.of(context).fontM?.size,
                        color: TDTheme.of(context).brandColor8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
