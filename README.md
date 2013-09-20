# Release Cadet
Release Cadet is a set of git magic to help us on our release management.
Allows you to overwrite the base config using the [.rcrc](.rcrc) file.

## Install
* Clone it 
* Build it
* Install the gem

## Configuration
Using the [.rcrc](.rcrc) file in the root of your project you can override the default configs.
```yml
branches: 
  production: master
  staging: staging
prefixes:
  release: releases/
  feature: features/
```

## Commands
Commands are defined as class methods on the Cadet gem.

### Changes
Shows the revision list for all the commits that gone into the release number
and not yet merged into master.

`$ cadet changes 13.36`

With supplying a second param it will compare the release with another target branch

`$ cadet changes 13.36 staging`

### Features
Shows the revision list for all the merge commits that gone into the 
release number and not yet merged into master.

`$ cadet features 13.36`

### Push
Pushes up the changes from one branch to the target. Exits in error when git
 merge result failed.

`$ cadet push staging master`

If the second param is not specified it will ask you to type in the one you want to use

### Clean
Looks up all the branches that have been merged into master and are ready to be deleted.
Loops through all those and asks for each whether they can be deleted

`$ cadet clean`

## Hooks
Write your own hooks using .rcrc file

## Examples
