## Package description
## golang : Go language
## erlang : Erlang
## npm : Node.js
## xctool and ios-sim : for xcode-mode
## rtags : for rtags mode
## python3 : python mode
## markdown : live markdown mode
## jupyter : python(ein) mode
## graphviz : ML library
brew cask install java
brew install golang erlang npm xctool ios-sim rtags python3 markdown groovy gradle jupyter graphviz

echo "export GROOVY_HOME=/usr/local/opt/groovy/libexec" >> ~/.profile

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
go get github.com/golang/lint/golint
cd ~/go/src/github.com/golang/lint/golint
go build
go install

brew install go-delve/delve/delve
sudo gem install redcarpet

# Java setting (JDEE)
if [[ `which javac` == "" ]]
then
    echo "JDK may be seen to be installed"
fi

brew install maven
cd refs
git clone https://github.com/jdee-emacs/jdee-server.git
cd jdee-server
mvn -Dmaven.test.skip=true package

# flymake-json mode
npm install jsonlint -g

# rtags
export CLANG=`xcrun -f clang++`
sudo mv $CLANG $CLANG.old
sudo ln -s /usr/local/opt/rtags/bin/gcc-rtags-wrapper.sh $CLANG 

# python
sudo pip3 install rope jedi importmagic autopep8 yapf virtualenv
sudo pip3 install numpy scipy scikit-learn matplotlib pandas pillow graphviz ipykernel
sudo python3 -m ipykernel install --user


#eslint
npm install -g eslint babel-eslint eslint-plugin-react

# run emacs script
cd $emacs_dir
emacs --script init.el
