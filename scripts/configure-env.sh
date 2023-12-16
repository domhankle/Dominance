#!/usr/bin/env bash

DEV_DIR=""
LIB_REPOS_DIR=""

promptForDevDir()
{
  echo "Enter the ABSOLUTE location of the dev directory: "
  read dev_dir_path
  DEV_DIR=dev_dir_path
  echo Adding ${DEV_DIR} to .bashrc...
  local toAppend=$(cat << EOI
\n
export DOMINANCE_DEV_DIR=${DEV_DIR}
EOI
)

  echo -e $toAppend >> ~/.bashrc
}

makeLibReposDir()
{
  echo "Creating lib-repos directory in ${DEV_DIR}..."
  mkdir -p ${DEV_DIR}/lib-repos
}

setupSSH()
{
  eval `ssh-agent`
  ssh-add $DOMINANCE_SSH_KEY
}

cloneDominanceRepo()
{
  echo "Cloning dominance in ${DEV_DIR}..."
  cd ${DEV_DIR}
  git clone git@github.com:domhankle/Dominance.git
  
  echo Adding ${DEV_DIR}/dominance to .bashrc...
  local toAppend=$(cat << EOI
\n
export DOMINANCE_DIR=${DEV_DIR}/dominance
EOI
)
  
  echo -e $toAppend >> ~/.bashrc
}

cloneSFMLRepo()
{
}

cloneGoogleTestRepo()
{
}

buildDeps()
{
}

promptForDevDir
makeLibReposDir
setupSSH
cloneDominanceRepo
buildDeps
