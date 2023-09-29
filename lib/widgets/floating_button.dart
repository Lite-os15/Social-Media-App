import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return
       Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: SizedBox(
          width: 38 * 2.0,
          height: 38 + 62.0,
          child: Container(
            alignment: Alignment.topCenter,
            color: Colors.transparent,
            child: SizedBox(
              width: 38 * 2.0,
              height: 38 * 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // alignment: Alignment.center,s
                  decoration: BoxDecoration(
                    color: CupertinoColors.activeBlue,
                    gradient: LinearGradient(
                        colors: [
                          CupertinoColors.activeBlue,
                          Colors.lightBlueAccent,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: CupertinoColors.activeBlue
                              .withOpacity(0.4),
                          offset: const Offset(8.0, 16.0),
                          blurRadius: 16.0),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.white.withOpacity(0.1),
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: (){},
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  }
}
