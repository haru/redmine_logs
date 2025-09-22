# Redmine Logs Plugin Development Guide

## Architecture Overview

This is a **Redmine plugin** that provides log file management functionality through the admin interface. The plugin follows standard Redmine plugin conventions with Rails MVC architecture.

### Key Components

- **Plugin Entry Point**: `init.rb` - Defines plugin metadata, menu integration, and loads hooks
- **Controller**: `app/controllers/logs_controller.rb` - Handles log file CRUD operations with admin authentication
- **Model Logic**: `lib/redmine_logs/log_file.rb` - Encapsulates log file metadata and utilities
- **Admin Menu Integration**: `lib/admin_menu_hooks.rb` - Injects CSS stylesheets into admin pages
- **Routes**: `config/routes.rb` - Maps URLs to controller actions using explicit match declarations

### Security Architecture

The plugin implements path traversal protection in `LogsController#require_correct_path`:
- All file operations are restricted to `#{Rails.root}/log` directory
- Uses `File.expand_path()` and prefix validation to prevent directory traversal attacks
- Admin-only access enforced via `before_action :require_admin`

## Development Patterns

### Plugin Registration Pattern
```ruby
# init.rb follows standard Redmine plugin structure
Redmine::Plugin.register :redmine_logs do
  name 'Plugin Name'
  requires_redmine :version_or_higher => '6.0.0'
  menu :admin_menu, 'route', { controller: 'controller', action: 'action' }
end
```

### File Operation Safety
Always use the established security pattern when adding file operations:
```ruby
def require_correct_path
  path = File.expand_path(params[:path])
  unless path.start_with? LOGDIR
    render_403
    return false
  end
  true
end
```

### View Helpers Integration
- Uses `layout 'admin'` for consistent admin interface styling
- CSS injected through `AdminMenuHooks` view listener pattern
- Icon integration via `icon_source.yml` configuration

## Development Workflow

### Testing
- **Run tests**: `bundle exec rake redmine:plugins:test NAME=redmine_logs`
- **Test location**: `test/functional/logs_controller_test.rb`
- **Fixtures**: Uses standard Redmine fixtures (projects, users, roles, members)
- **Test setup**: Creates temporary log files in Rails.root/log for testing

### Build & CI
- **Build script**: `build-scripts/build.sh` - Runs plugin tests in Redmine context
- **Installation**: `build-scripts/install.sh` - Sets up test environment with multiple Redmine/Ruby versions
- **CI Matrix**: Tests against Ruby 3.1-3.4 × Redmine 6.0/6.1/master × SQLite/MySQL/PostgreSQL

### Plugin Installation
1. Copy plugin to `plugins/redmine_logs` in Redmine root
2. No database migrations or additional setup required
3. Plugin automatically appears in admin menu after restart

## File Structure Conventions

```
redmine_logs/
├── init.rb                    # Plugin registration and configuration
├── app/controllers/           # Standard Rails controllers with admin auth
├── app/views/                # ERB templates following Redmine conventions  
├── lib/redmine_logs/         # Plugin-specific modules and classes
├── lib/admin_menu_hooks.rb   # Redmine hook implementations
├── config/routes.rb          # Explicit route definitions (not resourceful)
├── assets/                   # Plugin-specific CSS/images
└── test/functional/          # Redmine::ControllerTest subclasses
```

## Redmine Integration Points

- **Admin Menu**: Registered via `menu :admin_menu` in plugin definition
- **Authentication**: Uses `before_action :require_admin` from Redmine core
- **Layout**: Inherits from `layout 'admin'` for consistent admin styling  
- **Routes**: Defined in plugin's `config/routes.rb`, integrated into main app
- **Hooks**: Uses `Redmine::Hook::ViewListener` for CSS injection
- **Testing**: Extends `Redmine::ControllerTest` with Redmine fixtures

## Common Tasks

- **Add new log operations**: Extend `LogsController` with appropriate security checks
- **Modify file metadata**: Update `LogFile` class in `lib/redmine_logs/log_file.rb`
- **Change admin UI**: Edit views in `app/views/logs/` and update CSS in `assets/stylesheets/`
- **Add routes**: Update `config/routes.rb` with explicit match declarations