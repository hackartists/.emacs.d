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

brew cask install homebrew/cask-versions/java8
brew cask install xquartz
brew bundle
brew link --overwrite ctags


## eralng setting
ln -s /usr/local/opt/erlang/lib/erlang/lib/tools-* /usr/local/opt/erlang/lib/erlang/lib/tools
ln -s /usr/local/opt/erlang/lib/erlang /usr/local/opt/erl
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
go get github.com/derekparker/delve/cmd/dlv
go get github.com/nsf/gocode
go install github.com/nsf/gocode
go get github.com/motemen/gore
go install github.com/motemen/gore
go get github.com/k0kubun/pp
go install github.com/k0kubun/pp


sudo gem install redcarpet

# Java setting (JDEE)
if [[ `which javac` == "" ]]
then
    echo "JDK may be seen to be installed"
fi

cd refs
git clone https://github.com/jdee-emacs/jdee-server.git
cd jdee-server
mvn -Dmaven.test.skip=true package

# flymake-json mode
npm install -g jsonlint indium tern eslint babel-eslint eslint-plugin-react eslint-plugin-node tslint tslint-eslint-rules tslint-config-prettier tide typescript

# rtags
export CLANG=`xcrun -f clang++`
sudo mv $CLANG $CLANG.old
sudo ln -s /usr/local/opt/rtags/bin/gcc-rtags-wrapper.sh $CLANG 

# python
pip3 install -r requirements.txt
python3 -m ipykernel install --user

#eslint
npm install -g eslint babel-eslint eslint-plugin-react

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
