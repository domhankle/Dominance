#!/usr/bin/env bash

SFML_BRANCH=2.6.x
GOOGLE_TEST_BRANCH=main

setupSSH()
{
  eval `ssh-agent`
  ssh-add $DOMINANCE_SSH_KEY
}
updateSFML()
{
  #Get latest of SFML repo on branch 2.6.x
  cd $SFML_REPO
  git checkout $SFML_BRANCH
  git pull
  
  #Build SFML
  rm -r $SFML_REPO/build
  mkdir $SFML_REPO/build
  cd $SFML_REPO/build
  cmake -S $SFML_REPO -B $SFML_REPO/build
  make
  
  #Copy libs/headers to dominance
  rm -r $DOMINANCE_DIR/deps/SFML/libs/* 
  cp -r $SFML_REPO/build/lib/* $DOMINANCE_DIR/deps/SFML/libs

  rm -r $DOMINANCE_DIR/deps/SFML/SFML/*
  cp -r $SFML_REPO/include/SFML/* $DOMINANCE_DIR/deps/SFML/SFML 
}
updateGoogleTest()
{  
  #Get latest of googletest on main branch
  cd $GOOGLE_TEST_REPO
  git checkout $GOOGLE_TEST_BRANCH
  git pull
  
  #Build googletest
  rm -r $GOOGLE_TEST_REPO/build
  mkdir $GOOGLE_TEST_REPO/build
  cd $GOOGLE_TEST_REPO/build
  cmake -S $GOOGLE_TEST_REPO -B $GOOGLE_TEST_REPO/build
  make
  
  #Copy libs/headers to dominance
  rm -r $DOMINANCE_DIR/deps/googletest/libs/* 
  cp -r $GOOGLE_TEST_REPO/build/lib/* $DOMINANCE_DIR/deps/googletest/libs

  rm -r $DOMINANCE_DIR/deps/googletest/gtest
  cp -r $GOOGLE_TEST_REPO/googletest/include/gtest $DOMINANCE_DIR/deps/googletest
  
  rm -r $DOMINANCE_DIR/deps/googletest/gmock
  cp -r $GOOGLE_TEST_REPO/googlemock/include/gmock $DOMINANCE_DIR/deps/googletest
}

setupSSH
updateSFML  
updateGoogleTest   
