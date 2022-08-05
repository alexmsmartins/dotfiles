function nvm
  if test ! -e ~/.nvm/nvm.sh
    echo "Installing nvm from github"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  end
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end
