echo "› brew cask install java"
brew cask install java

echo "› brew cask install java8"
brew cask install java8

echo "› brew install jenv"
brew install jenv

pwd
source java/jenv.zsh

# find the java versions and add them
JAVA_ROOT=/Library/Java/JavaVirtualMachines/
ls $JAVA_ROOT | while read installer ; do echo "> jenv add \"${JAVA_ROOT}${installer}/Contents/Home/\"" && jenv add "${JAVA_ROOT}${installer}/Contents/Home/" ; done
