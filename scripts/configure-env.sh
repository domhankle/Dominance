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

configureDominanceRepo()
{
  cd ../..
  mv ./dominance ${DEV_DIR}
  echo "moving dominance into ${DEV_DIR}..."
  cd ${DEV_DIR}
    

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
  setupSSH
  echo Cloning SFML Repo in ${DEV_DIR}...
  cd ${DEV_DIR}
  git clone git@github.com:SFML/SFML.git
  
  echo Adding ${DEV_DIR}/SFML to .bashrc...
  local toAppend=$(cat << EOI
\n
export SFML_REPO=${DEV_DIR}/SFML
EOI
)
}

cloneGoogleTestRepo()
{
  echo Cloning GoogleTest Repo in ${DEV_DIR}...
  cd ${DEV_DIR}
  git clone git@github.com:google/googletest.git

  echo Adding ${DEV_DIR}/googletest to .bashrc...
  local toAppend=$(cat << EOI
\n
export GOOGLE_TEST_REPO=${DEV_DIR}/googletest
EOI
) 

}

buildDeps()
{
  cloneSFMLRepo
  cloneGoogleTestRepo
  ../deps/scripts/sfml-deps.sh
  ../deps/scripts/dependencies.sh
}

promptForDevDir
makeLibReposDir
configureDominanceRepo
buildDeps
