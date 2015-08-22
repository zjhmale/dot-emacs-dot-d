brew install Caskroom/cask/xquartz
brew install ocaml --with-x11
brew install opam

echo "finish brew stuff"

opam init
eval `opam config env`
opam update
opam install ocp-indent

opam install core utop
opam install async yojson core_extended core_bench cohttp async_graphics cryptokit menhir

echo "finish opam stuff"
echo "then config ~/.ocamlinit reference to https://github.com/realworldocaml/book/wiki/Installation-Instructions and https://github.com/janestreet/core/issues/60"
