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
ln -s $HOME/.emacs.d/.zshrc $HOME/.zshrc
source $HOME/.zshrc

## Configuring devel paths
mkdir -p $HOME/data/devel/src
cd $HOME/data/devel
addpath GOPATH
cd $GOPATH/src
addpath devel
cd /usr/local/opt/groovy/libexec
addpath GROOVY_HOME
cd $emacs_dir

addbinpath $GOPATH/bin
addbinpath /usr/local/texlive/2017/bin/x86_64-darwin

## brew tab go-delve/delve homebrew/bundle homebrew/cask hombrew/cask-versions homebrew/core kylef/formulae
brew cask install docker emacs jandi mactex postman robo-3t spectacle sublime-text tunnelblick visual-studio-code wireshark adoptopenjdk8 xquartz google-chrome
brew install aspell bazel cmake ctags erlang gettext global go gradle graphviz groovy ios-deploy node ios-sim jq jupyter markdown nmap python rtags rust rustup-init sloccount tree xctool yq maven


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
git dev git@github.com:terhechte/SourceKittenDaemon.git
make install

# run emacs script
cd $emacs_dir
emacs --script init.el
