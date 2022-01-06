#!/bin/bash
# Cleans up files/directories that may be left over from previous runs for a clean slate before starting a new build

PWD=$(pwd)

rm -rf ../venv || true
rm -rf venv || true
rm -rf mint_blockchain.egg-info || true
rm -rf build_scripts/final_installer || true
rm -rf build_scripts/dist || true
rm -rf build_scripts/pyinstaller || true
rm -rf mint-blockchain-gui/build || true
rm -rf mint-blockchain-gui/daemon || true
rm -rf mint-blockchain-gui/node_modules || true
rm mint-blockchain-gui/temp.json || true
( cd "$PWD/mint-blockchain-gui" && git checkout HEAD -- package-lock.json ) || true
cd "$PWD" || true

# Do our best to get rid of any globally installed notarize-cli versions so the version in the current build script is
# installed without conflicting with the other version that might be installed
PATH=$(brew --prefix node@14)/bin:$PATH || true
export PATH
npm uninstall -g notarize-cli || true
npm uninstall -g @mint-network/notarize-cli || true
npm uninstall -g electron-installer-dmg || true
npm uninstall -g electron-packager || true
npm uninstall -g electron/electron-osx-sign || true