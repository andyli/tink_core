package ;

import haxe.unit.*;

#if flash
typedef Sys = flash.system.System;
#end

class RunTests {
  static var tests:Array<TestCase> = [
    new Base.TestBase(),
    new Callbacks(),
    new Futures(),
    new Outcomes(),
    new Signals(),
    new Refs(),
    new Pairs(),
    new Promises(),
    new Options(),
  ];
  static function main() {  
    #if js//works for nodejs and browsers alike
    var buf = [];
    TestRunner.print = function (s:String) {
      var parts = s.split('\n');
      if (parts.length > 1) {
        parts[0] = buf.join('') + parts[0];
        buf = [];
        while (parts.length > 1)
          untyped console.log(parts.shift());
      }
      buf.push(parts[0]);
    }
    #end    
    var r = new TestRunner();
    for (c in tests)
      r.add(c);
    Sys.exit(
      if (r.run()) 0
      else 500
    );
  }
}