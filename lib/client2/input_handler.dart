part of gglclient2;

class InputHandler {
  Map<num, bool> key = new Map<num, bool>();
  List<Function> cbList = [];
  TextField dbg;

  bool mouseL = false;
  Cmd cmd = new Cmd();

  InputHandler() {
    for (num i = 0; i < 255; i++) key[i] = false;

    stage.onEnterFrame.listen(_updater);
    dbg = new TextField()
        ..defaultTextFormat = diagnostics.font11
        ..x = 300
        ..y = 30
        ..width = 200
        ..height = 200
        ..wordWrap = true;

    stage.focus = stage;
    stage.onKeyDown.listen(_process);
    stage.onKeyUp.listen(_process);
    stage.onMouseDown.listen((e) { mouseL = true; makeCmd(); });
    stage.onMouseUp.listen((e) { mouseL = false; makeCmd(); });
    stage.onMouseRightClick.listen((e) { cmd.swap = true; });
    print("loading input handler");
  }

  void _process(KeyboardEvent e) {
    key[e.keyCode] = e.type == KeyboardEvent.KEY_DOWN ? true : false;
    makeCmd();
  }

  num trival(num neg, num pos) {
    if (key[pos] && key[neg]) return 0;
    else if (key[pos]) return 1;
    else if (key[neg]) return -1;
    return 0;
  }

  void makeCmd() {
    cmd.moveY = trival(87, 83);   // down, up
    cmd.moveX = trival(65, 68);   // left, right
    cmd.rotate = trival(37, 39);  // turn left, right
    cmd.fire = key[38] || mouseL; // fire
    cmd.swap = key[40];           // swap weapon
    dbg.text = "${cmd}\n" + "pressed:${pressed()}";
  }

  String pressed() {
    String s = "";
    for (num k in key.keys) {
      if (key[k]) s += "$k ";
    }
    return s;
  }

  void _updater(EnterFrameEvent e) {
    diagnostics.addChild(dbg);
    for (Function f in cbList) {
      f(cmd);
    }
    cmd.swap = false;
  }
}
