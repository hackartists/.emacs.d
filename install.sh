## Package description
## golang : Go language
## erlang : Erlang
## npm : Node.js
## xctool and ios-sim : for xcode-mode
## rtags : for rtags mode
## python3 : python mode
brew install golang erlang npm xctool ios-sim rtags python3

## eralng setting
ln -s /usr/local/opt/erlang/lib/erlang/lib/tools-* /usr/local/opt/erlang/lib/erlang/lib/tools
ln -s /usr/local/opt/erlang/lib/erlang/lib/erlang /usr/local/opt/erl
export emacs_dir=`pwd`
cd refs/distel
make
cd $emacs_dir

#golang setting
go get github.com/dougm/goflymake
go get github.com/nsf/gocode
go get github.com/rogpeppe/godef
go get github.com/jstemmer/gotags
go get golang.org/x/tools/cmd/goimports
go get golang.org/x/tools/cmd/guru
brew install go-delve/delve/delve
sudo gem install redcarpet

# flymake-json mode
npm install jsonlint -g

# rtags
export CLANG=`xcrun -f clang++`
sudo mv $CLANG $CLANG.old
sudo ln -s /usr/local/opt/rtags/bin/gcc-rtags-wrapper.sh $CLANG 

# python
sudo pip3 install rope jedi importmagic autopep8 yapf virtualenv

#eslint
npm install -g eslint babel-eslint eslint-plugin-react

# run emacs script
emacs --script init.el
