
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
brew install npm
npm install jsonlint -g

# xcode-mode
brew install xctool
brew install ios-sim

# rtags
brew install rtags
export CLANG = `xcrun -f clang++`
sudo mv $CLANG $CLANG.old
sudo ln -s /usr/local/opt/rtags/bin/gcc-rtags-wrapper.sh $CLANG 

# python
brew install python3
sudo pip3 install rope jedi importmagic autopep8 yapf virtualenv
# run emacs script
emacs --script init.el
