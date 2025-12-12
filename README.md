
# Backup and restore dotfiles

This script allows you to back up and restore files.

## Usage
```bash
./manage.sh <backup|restore [-safe]> [-diff]
```
## Arguments
- `<backup|restore>`: Specify the action you want to perform.
  - `backup`: Create a backup of files.
  - `restore`: Restore files from the backup.
- `[-diff]`: Optional flag for the both actions.
  - `-diff`: Compare files and show differences.
- `[-safe]`: Optional flag for the `restore` action.
  - `-safe`: Prompt for confirmation before restoring each file. Automatically shows differences.

## Examples
```bash
sudo ./manage.sh restore -safe
sudo ./manage.sh backup
```
