if [ -z "$HOME" ]
then
  echo HOME not in environment, guessing...
  export HOME=$(awk -F: -v v="$USER" '{if ($1==v) print $6}' /etc/passwd)
fi

if [ ! -d jenkins ]
then
  git clone git://github.com/yanniks/jenkins.git
fi

cd jenkins
## Get rid of possible local changes
git reset --hard
git pull -s resolve
chmod +x build.sh

exec ./build.sh
