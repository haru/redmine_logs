[![build](https://github.com/Arean82/redmine_logs/actions/workflows/build.yml/badge.svg)](https://github.com/Arean82/redmine_logs/actions/workflows/build.yml)
[![Redmine](https://img.shields.io/badge/redmine->=5.0-blue?logo=redmine&logoColor=%23B32024&labelColor=f0f0f0&link=https%3A%2F%2Fwww.redmine.org)](https://www.redmine.org)
[![Ruby](https://img.shields.io/badge/ruby->=3.0-red?logo=ruby&logoColor=white)](https://www.ruby-lang.org)
[![License: GPL-2.0](https://img.shields.io/badge/License-GPLv2-green.svg)](GPL.txt)

# Redmine Logs Plugin

This is a Redmine plugin that provides log file management functionality directly from the administration interface. It allows administrators to browse, view, download, and delete log files from Redmine's log directory.

## Features

- **Categorized log management**: Logs are automatically organized into sections: **Production**, **Puma**, **Development**, **Test**, **Error**, **Setup**, and **Others**
- **Configurable view modes**: Choose between **Grouped Headings with Tables (default)**, **Redmine Standard Tabs**, or **Flat / Ungrouped (traditional)** via plugin settings
- **Browse log files**: View a list of all log files in the Redmine log directory with file size and modification timestamps
- **View log content**: Display the last 20,000 lines of any log file
- **Download logs**: Download log files directly to your local machine
- **Delete logs**: Remove log files when they're no longer needed
- **Admin integration**: Clean administration menu item with SVG icon integration
- **Security**: Restricted to administrators only with path traversal protection

## Requirements

- **Redmine**: 5.0.0 or higher (including Redmine 6.x and 7.x)
- **Ruby**: Compatible with Ruby 3.0+

## Installation

1. Copy or clone the plugin directory into your Redmine `plugins` directory:
   ```bash
   cd /path/to/redmine/plugins
   git clone https://github.com/haru/redmine_logs.git
   ```

2. Install dependencies (if needed):
   ```bash
   bundle config set --local without 'development test'
   bundle install
   bundle exec rake redmine:plugins:migrate RAILS_ENV=production
   ```

3. Restart your Redmine application server (e.g. Puma, Unicorn, Passenger):
   ```bash
   touch tmp/restart.txt
   ```

No database migrations are required by this plugin.

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
- Path traversal attacks are prevented through strict path validation

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
- **Maintainer / Compatibility:** Arean Narrayan
