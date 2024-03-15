# SSH Backup Script

This script is designed to back up a user's `.ssh` directory. It compresses the entire `.ssh` folder into an archive and stores it in a designated backup directory.

## Prerequisites

- macOS or Linux operating system
- `tar` utility must be installed (present by default on most UNIX systems)
- Write permission in the target backup directory

## Installation

1. Copy the `ssh-backup.sh` script to your preferred script directory, for example, `$HOME/ssh-backup`.
2. Make the script executable with the command:sh
chmod +x ~/ssh-backup/ssh-backup.sh
3. (Optional) Configure a `launchd` job or `cron` job to execute the script regularly.

## Configuration

The script uses environment variables and default paths. Ensure that these paths exist and are correct on your system:

- Backup directory: `/Users/yourUsername/ssh-backup`
- Log directory: `/Users/yourUsername/ssh-backup/logs`

## Usage

To run the script manually, open a terminal and execute the following command:Replitsh
~/ssh-backup/ssh-backup.shThe script will create an archive of the `.ssh` folder in the configured backup directory.

## Automation

To perform the backup automatically, you can set up a `cron` job or `launchd` service. An example `.plist` file for `launchd` might look like this:Codepenxml



<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.yourUsername.ssh-backup</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Users/yourUsername/ssh-backup/ssh-backup.sh</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>14</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>/Users/yourUsername/ssh-backup/logs/error.log</string>
    <key>StandardOutPath</key>
    <string>/Users/yourUsername/ssh-backup/logs/output.log</string>
</dict>
</plist>

## Crobtab
echo "0 14 * * * $HOME/ssh-backup/backup.sh" > /tmp/cron_job  #This entry would execute the backup.sh script every day at 02:00 PM.
crontab -l | cat - /tmp/cron_job | crontab -
crontab -l

Add the `.plist` file to `~/Library/LaunchAgents` and load it with `launchctl` to configure automatic execution.

## License

[MIT](LICENSE)

## Author

Matthias Lüttermann