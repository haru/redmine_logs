# To change this template, choose Tools | Templates
# and open the template in the editor.

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
          File.mtime(path)
        end

        def size
          File.size(path)
        end

        def to_s
          path
        end
      end
  end
end
