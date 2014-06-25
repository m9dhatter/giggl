part of giggl;

class InputHandler {
  Map<num, bool> keyState = new Map<num, bool>();
  TextField dbg;
  bool propagate = true;

  InputHandler() {
    stage.focus = stage;
    stage.onKeyDown.listen(_keyHandler);
    stage.onKeyUp.listen(_keyHandler);

    for(num i = 0; i < 255; i++) keyState[i] = false;

    stage.onEnterFrame.listen((EnterFrameEvent e) {
      String keyPressed = "keypressed: ";
      for (num i = 0; i < 255; i++)
        if (keyState[i]) keyPressed += "$i ";

      var fps = null;
      fps = fps == null
          ? 1.00 / e.passedTime
          : 0.05 / e.passedTime + 0.95 * fps;

      dbg.text = "fps: ${fps.round()}\n" +
          keyPressed;
    });

    TextFormat tf = new TextFormat('Helvetica', 10, Color.Red);
    dbg = new TextField()
      ..defaultTextFormat = tf
      ..x = 30
      ..y = 30
      ..width = 200
      ..height = 200
      ..wordWrap = true
      ..addTo(stage);
  }

  void _keyHandler(KeyboardEvent e) {
    keyState[e.keyCode] = e.type == KeyboardEvent.KEY_DOWN? true: false;
    if (!propagate) e.stopImmediatePropagation();
  }
}
