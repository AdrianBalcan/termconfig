##install brew
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#
##instal iterm2
#brew cask install iterm2
#
##install zsh and oh-my-zsh
#brew install zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#
##install awscli
#brew install awscli
#curl -o /usr/local/bin/aws_zsh_completer.sh https://raw.githubusercontent.com/aws/aws-cli/develop/bin/aws_zsh_completer.sh
#
##install kubectl
#curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.15.0/bin/darwin/amd64/kubectl
#chmod +x ./kubectl
#sudo mv ./kubectl /usr/local/bin/kubectl
#
##fzf
#brew install fzf
#/usr/local/opt/fzf/install --all
#
##current files
#cp .tmux.conf ~/
#cp -R .vim ~/
#cp -R .vimrc ~/
#cp .zshrc ~/
cp ./com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
