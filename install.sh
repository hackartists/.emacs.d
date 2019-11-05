#!/bin/bash
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
## sourcekitten : swift
## aspell : ispell-mode

export emacs_dir=`pwd`
sudo xcodebuild -license accept
sudo gem install redcarpet

## Homebrew
cat .ctags >> ~/.ctags
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install zsh

## ZSH installation and configurations

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions

## oh-my-profile
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hackartists/oh-my-profiles/master/install.sh)"

## Changing .zshrc
rm -rf $HOME/.zshrc
ln -s $HOME/.emacs.d.hackartists/.zshrc $HOME/.zshrc
source $HOME/.zshrc

## Configuring devel paths
mkdir -p $HOME/data/devel/src
cd $HOME/data/devel
addpath GOPATH
cd $GOPATH/src
addpath devel
cd $emacs_dir

addbinpath $GOPATH/bin
addbinpath /usr/local/texlive/2017/bin/x86_64-darwin

brew tap go-delve/delve homebrew/bundle homebrew/cask hombrew/cask-versions homebrew/core kylef/formulae
brew cask install homebrew/cask-versions/adoptopenjdk8
brew install aspell bazel cmake ctags erlang gettext global go gradle graphviz groovy ios-deploy node ios-sim jq jupyter markdown nmap python rtags rust rustup-init sloccount tree xctool yq maven

brew services start rtags

brew cask install docker emacs jandi mactex postman spectacle sublime-text tunnelblick visual-studio-code wireshark xquartz google-chrome

# golang setting
go get golang.org/x/lint/golint
go get -u golang.org/x/tools/...
go get -u github.com/go-delve/delve/cmd/dlv
go get -u github.com/kisielk/errcheck
go get -u github.com/dougm/goflymake
go get -u github.com/nsf/gocode
go get -u github.com/rogpeppe/godef
go get -u github.com/jstemmer/gotags
go get -u github.com/motemen/gore
go get -u github.com/k0kubun/pp
go get -u github.com/mdempsky/unconvert
go get -u github.com/dominikh/go-tools
go get -u honnef.co/go/tools/cmd/megacheck
go get -u github.com/fatih/gomodifytags
go get -u github.com/lukehoban/go-outline

# groovy setting
cd /usr/local/opt/groovy/libexec
addpath GROOVY_HOME

# brew bundle
brew link --overwrite ctags

## eralng setting
ln -s /usr/local/opt/erlang/lib/erlang/lib/tools-* /usr/local/opt/erlang/lib/erlang/lib/tools
ln -s /usr/local/opt/erlang/lib/erlang /usr/local/opt/erl
cd refs/distel
make
cd $emacs_dir

# Java setting (JDEE)
if [[ `which javac` == "" ]]
then
    echo "JDK may be seen to be installed"
fi

cd refs
git clone https://github.com/jdee-emacs/jdee-server.git
cd jdee-server
mvn -Dmaven.test.skip=true package
cp target/jdee-bundle-*.jar ./

# rtags
export CLANG=`xcrun -f clang++`
sudo mv $CLANG $CLANG.old
sudo ln -s /usr/local/opt/rtags/bin/gcc-rtags-wrapper.sh $CLANG 

# python
pip3 install absl-py appnope asn1crypto astor autopep8 certifi cffi chardet cryptography cycler decorator graphviz grpcio hkdf idna importmagic ipykernel ipython ipython-genutils jedi jupyter-client jupyter-core kiwisolver matplotlib numpy pandas parso pexpect pickleshare Pillow prompt-toolkit protobuf ptyprocess pycodestyle pycparser pycryptodomex Pygments pyparsing pysha3 python-dateutil pytz pyzmq requests rope Rx scikit-learn scipy simplegeneric six tornado traitlets urllib3 virtualenv wcwidth yapf 
python3 -m ipykernel install --user

# Rust
rustup-init -y
source $HOME/.cargo/env
rustup toolchain add stable
rustup component add rust-src
cargo install racer
cargo install rustfmt
cargo install cargo-edit
echo "source $HOME/.cargo/env" >> ~/.zshrc
echo "export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src" >> ~/.zshrc

# For swift completion, sourcekittendeamon should be installed on machine.
mkdir -p $devel/github.com/terhechte
cd $devel/github.com/terhechte
git clone https://github.com/terhechte/SourceKittenDaemon.git
cd SourceKittenDaemon
make install

# run emacs script
cd $emacs_dir
emacs --script init.el
