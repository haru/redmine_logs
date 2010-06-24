# Logs plugin for Redmine
# Copyright (C) 2010  Haruyuki Iida
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

module RedmineLogs
  module LogFile
      class LogFile
        
        def initialize(path)
          @path = path
        end

        def path
          @path
        end

        def timestamp
          @timestamp ||= File.mtime(path)
        end

        def size
          @size ||= File.size(path)
        end

        def size_str
          return "#{size} B" if size < 1024
          return "#{size / 1024} KB" if size < 1024 * 1024
          return "#{size / (1024 * 1024)} MB" if size < 1024 * 1024 * 1024
          return "#{size / (1024 * 1024 * 1024)} GB"
        end

        def text?
          false
        end

        def to_s
          path
        end
      end
  end
end
