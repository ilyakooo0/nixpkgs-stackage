# Generated by stackage2nix 0.7.1 from "/nix/store/1hxnv09r297fzymiwlpyfmvw2gg7slzh-stackage-lts/lts-12.4.yaml"
{ callPackage, buildPackages, pkgs, stdenv, lib
, overrides ? (self: super: {})
, packageSetConfig ? (self: super: {})
}:

let
  inherit (lib) extends makeExtensible;
  haskellLib = pkgs.haskell.lib;
  inherit (haskellLib) makePackageSet;
  
  haskellPackages = pkgs.callPackage makePackageSet {
                      ghc = buildPackages.haskell.compiler.ghc844;
                      buildHaskellPackages = buildPackages.haskell.packages.ghc844;
                      package-set = import ./packages.nix;
                      inherit stdenv haskellLib extensible-self;
                    };
  
  compilerConfig = import  ./configuration-packages.nix { inherit pkgs haskellLib; };
  
  configurationCommon = if builtins.pathExists ./configuration-common.nix then import ./configuration-common.nix { inherit pkgs haskellLib; } else self: super: {};
  configurationNix = import (pkgs.path + "/pkgs/development/haskell-modules/configuration-nix.nix") { inherit pkgs haskellLib; };
  
  extensible-self = makeExtensible (extends overrides (extends configurationCommon (extends packageSetConfig (extends compilerConfig (extends configurationNix haskellPackages)))));

in extensible-self
