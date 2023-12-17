#!/usr/bin/env bash

BUILD_LIB_REPOS=$1

buildLibraryDependencies(){
  echo "Installing SFML package dependencies..."
  sudo ${DOMINANCE_REPO}/deps/scripts/sfml-deps.sh

  echo "Building libraries and linking dependencies to dominance repo..."
  ${DOMINANCE_REPO}/deps/scripts/dependencies.sh

  echo -e "\nConfiguration is complete with library repos built. This file will have executable permissions removed.\nIf you need to update the library dependencies, use the ${DOMINANCE_REPO}/deps/scripts/dependencies.sh script.\nIf you need to re-configure your environment for any reason, reapply executable permissions to this file and rerun it (chmod +x ${DOMINANCE_REPO}/scripts/configure-env.sh). This shouldn't happen very often."

  chmod -x ${DOMINANCE_REPO}/scripts/configure-env.sh
}

cloneSFML(){
  local LIB_REPOS_DIR=$1

  cd $LIB_REPOS_DIR
  git clone git@github.com:SFML/SFML.git
  
  if [ ! -z $SFML_REPO ]; then
    echo "Creating SFML_REPO variable in .bashrc pointing to ${LIBS_REPO_DIR}/SFML"
    local addToBashRc=$(cat << EOI
export SFML_REPO=${LIB_REPOS_DIR}/SFML
EOI
)   
    echo -e "${addToBashRc}" >> ~/.bashrc
  else
    echo "SFML_REPO variable in .bashrc already exists."
  fi
  
}

cloneGoogleTest(){
  local LIB_REPOS_DIR=$1
  
  cd $LIB_REPOS_DIR
  git clone git@github.com:google/googletest.git
  
  if [ ! -z $GOOGLE_TEST_REPO ]; then
     echo "Creating GOOGLE_TEST_REPO variable in .bashrc pointing to ${LIB_REPO_DIR}/googletest"
     local addToBashRc=$(cat << EOI
export GOOGLE_TEST_REPO=${LIB_REPOS_DIR}/googletest
EOI
)
    echo -e "${addToBashRc}" >> ~/.bashrc
  else
    echo "GOOGLE_TEST_REPO variable in .bashrc already exists."
  fi

}

cloneLibRepos(){
  local LIB_REPOS_DIR=$1
  
  if [ ! -d "${LIB_REPOS_DIR}/googletest" ]; then
    echo "Cloning Google Test repo into ${LIB_REPOS_DIR}/googletest"
    cloneGoogleTest $LIB_REPOS_DIR
  else
    echo "Google Test repo already exists at ${LIB_REPOS_DIR}/googletest, moving on..."
  fi
  
  if [ ! -d "${LIB_REPOS_DIR}/SFML" ]; then
    echo "Cloning SFML repo into ${LIB_REPOS_diR}/SFML"
    cloneSFML $LIB_REPOS_DIR
  else
    echo "SFML repo already exists at ${LIB_REPOS_DIR}/SFML, moving on..."
  fi

  source ~/.bashrc
  buildLibraryDependencies
}

makeLibReposDir(){
  cd $DOMINANCE_REPO
  cd ..
  local LIB_REPOS_DIR=$(pwd)/lib-repos

  if [ -d $LIB_REPOS_DIR ]; then
    echo "Moving to ${LIB_REPOS_DIR}"
    cloneLibRepos $LIB_REPOS_DIR
  else
    echo "Creating ${LIB_REPOS_DIR} and moving into it"
    mkdir -p $LIB_REPOS_DIR
    cloneLibRepos $LIB_REPOS_DIR    
  fi
}


setupSSH(){
  if [ ! -z $DOMINANCE_SSH_KEY ]; then
    echo "DOMINANCE_SSH_KEY is set to ${DOMINANCE_SSH_KEY}"
  else
    echo "You must set the DOMINANCE_SSH_KEY variable in your .bashrc file pointing to the private SSH key that was used to clone the Dominance repo."
    exit 1;
  fi
  
  if [ "$BUILD_LIB_REPOS" = "-libs" ]; then
    echo "You've requested for the library repos to be included in your development environment, the configuration will continue." 
    eval `ssh-agent`
    ssh-add $DOMINANCE_SSH_KEY
    makeLibReposDir
  elif [[ ! -z $BUILD_LIB_REPOS  &&  ! "$BUILD_LIB_REPOS" = "-libs" ]]; then
    echo "Invalid flag passed to this script. Acceptable flags are: -libs"
    exit 1;
  else
    echo "You have not requested for the library repos to be included in your development environment, there is nothing to be done. This file will remain executable in case you want to ever add the library repos to you development environment."
    exit 0;
  fi
}

echo "Parameter value: $1"
if [ ! -z $DOMINANCE_REPO ]; then
  echo "DOMINANCE_REPO is set to ${DOMINANCE_REPO}"
  setupSSH
  exit 0;
else
  echo "You must set the DOMINANCE_REPO variable in your .bashrc file pointing to the cloned Dominance repo."
  exit 1;
fi
