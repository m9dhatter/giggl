part of giggl_server;

class World {
  Grid _surface;
  List<WorldObject> _objects;
  
  int _tileWidth;
  int _worldWidth;
  int _worldHeight;
  Timer _timer = null;
 
  World (int width, int height, int tileWidth) {
    _surface = new Grid(width, height);
    _tileWidth = tileWidth;
    _worldWidth = _surface.width() * _tileWidth;
    _worldHeight = _surface.height() * _tileWidth;  
    _objects = new List();
  }
  
  void start() {
    if (_timer == null){
      _timer = new Timer.periodic(new Duration(milliseconds: 10), this._goRound);
    }
  }
  
  void stop() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }
  
  
  void addObject(WorldObject object) {
    _objects.add(object);
  }
  
  void removeObject(WorldObject object) {
    _objects.remove(object);
  }
  
  void _processInput() {
    // process input
  }
  
  void _update(num elapsed) {
    
    // AI stuff 
    
    // physics stuff (collision etc.)
    
    // individal object updates
    _objects.forEach((object)=>object.update(elapsed));
  }
  
  void _goRound(Timer timer) {
    
    num elapsed = 0.01;
    
    _processInput();
    _update(elapsed);
  }
}