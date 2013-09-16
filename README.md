# Release Cadet
Release Cadet is a set of git magic to help us on our release management.
Allows you to overwrite the base config using the [.rcrc](.rcrc) file.

## Install
* Clone it 
* Build it
* Install the gem

## Commands
Commands are defined as class methods on the Cadet gem.

### Changes
Shows the revision list for all the commits that gone into the release number
and not yet merged into master.

`$ cadet changes 13.36`

### Feature list
Shows the revision list for all the merge commits that gone into the 
release number and not yet merged into master.

`$ cadet feature_list 13.36`

### Push up
Pushes up the changes from one branch to the target. Exits in error when git
 merge result failed.

`$ cadet push_up staging master`

## Hooks
Write your own hooks using .rcrc file

## Examples
