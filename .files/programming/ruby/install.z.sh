# =========================================================================== [Installation] ===== #

# Install Ruby
if [[ "$OS_TYPE" == "stm" ]]; then
  nix-env -iA nixpkgs.ruby nixpkgs.rbenv
fi

# Source rbenv
export PATH="$HOME/.rbenv/bin:$PATH" && eval "$(rbenv init -)"

# Initialize rbenv and set global ruby version (https://github.com/rbenv/rbenv)
RUBY_VERSION=3.3.3
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
rbenv shell $RUBY_VERSION

# Install packages using Gem (https://rubygems.org/)
gems=(
  bundler
  rails
  lolcat
)

# Install gems using Gem
for gem in "${gems[@]}"; do
  gem install "$gem"
done

# Rehash Gems
rbenv rehash
