_inputs: {
  default = final: _prev: import (../pkgs) { pkgs = final.pkgs; prev = _prev; };
}
