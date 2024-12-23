import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:habits/helpers/loading/loading_screen_controller.dart';

class LoadingScreen {
  //singleton pattern
  factory LoadingScreen() => _shared;
  static final LoadingScreen _shared = LoadingScreen.sharedInstance();
  LoadingScreen.sharedInstance();

  LoadingScreenController? controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (controller?.update(text) ?? false) {
      return;
    } else {
      controller = showOverlay(context: context, text: text);
    }
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final _text = StreamController<String>();
    _text.add(text);
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black,
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                //minWidth: size.height * 0.5, //this is causing an exception
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      StreamBuilder(
                        stream: _text.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data as String,
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    state?.insert(overlay); //diplay overlay
    return LoadingScreenController(
      close: () {
        _text.close();
        overlay.remove();
        return true; //could be void functions, but this is boolean because it could be used for error handling
      },
      update: (texT) {
        _text.add(text);
        return true;
      },
    );
  }
}
