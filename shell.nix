let 
  pkgs = import <nixpkgs> { };
in pkgs.mkShell rec {
  name = "blog";
  buildInputs = with pkgs; [
    hugo
    git-lfs
    python311
  ];
}
