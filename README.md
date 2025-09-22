[![build](https://github.com/haru/redmine_logs/actions/workflows/build.yml/badge.svg)](https://github.com/haru/redmine_logs/actions/workflows/build.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/3fb10c5b2245dd4647e5/maintainability)](https://codeclimate.com/github/haru/redmine_logs/maintainability)
[![codecov](https://codecov.io/gh/haru/redmine_logs/branch/develop/graph/badge.svg?token=SKAL5GLHIX)](https://codecov.io/gh/haru/redmine_logs)
![Redmine](https://img.shields.io/badge/redmine->=6.0-blue?logo=redmine&logoColor=%23B32024&labelColor=f0f0f0&link=https%3A%2F%2Fwww.redmine.org)

# Redmine Logs Plugin

This is a Redmine plugin that provides log file management functionality directly from the administration interface. It allows administrators to browse, view, download, and delete log files from Redmine's log directory.

## Features

- **Browse log files**: View a list of all log files in the Redmine log directory
- **View log content**: Display the last 20,000 lines of any log file
- **Download logs**: Download log files directly to your local machine
- **Delete logs**: Remove log files when they're no longer needed
- **Security**: Restricted to administrators only with path traversal protection

## Requirements

- **Redmine**: 6.0.0 or higher
- **Ruby**: Compatible with Ruby 3.1+

## Installation

1. Copy the plugin directory into the `plugins` directory of your Redmine installation:
   ```bash
   cd /path/to/redmine
   git clone https://github.com/haru/redmine_logs.git plugins/redmine_logs
   ```

2. Restart your Redmine application.

That's all! No database migrations or additional configuration required.

## Usage

1. Log in as a Redmine administrator
2. Navigate to **Administration** → **Logs**
3. From the logs page, you can:
   - View a list of all available log files
   - Click on a log file name to view its contents
   - Use the download link to save log files locally
   - Delete log files using the delete button

## Security

The plugin implements several security measures:
- Only administrators can access log management functionality
- All file operations are restricted to the Redmine log directory (`Rails.root/log`)
- Path traversal attacks are prevented through path validation

## Development

### Running Tests

```bash
bundle exec rake redmine:plugins:test NAME=redmine_logs
```


## License

This plugin is released under the GNU General Public License v2 (GPLv2).
See the [GPL.txt](GPL.txt) file for details.

## Author

- **Haruyuki Iida** ([@haru_iida](https://github.com/haru))

## Contributing

1. Fork the repository
2. Create your feature branch from `develop` (`git checkout -b feature/my-new-feature develop`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create a new Pull Request **against the `develop` branch**

