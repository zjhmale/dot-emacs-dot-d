brew install ghc cabal-install

echo "finish download ghc and cabal"

echo 'export PATH=$HOME/.cabal/bin:$PATH' >> ~/.zshrc
source ~/.zshrc

cabal update
cabal install happy
cabal install ghc-mod

echo "happy hacking with haskell and play with haskell start with C-c C-l"
