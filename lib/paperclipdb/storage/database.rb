module Paperclip
  module Storage
    module Database

      def self.extended(base)
        base.instance_eval do
          override_default_options base
        end
      end

      def override_default_options(base)
        @options[:path] = @options[:url]
        @options[:url] = "/paperclipdb" + @options[:url]
      end
      private :override_default_options

      def exists?(style = default_style)
        puts("[paperclipdb] exists?  #{style}")
        return getAttachment(path(style)).nil?
      end

      def getAttachment(file_path)
        return Paperclipdb::Attachment.find(:first,
              :conditions => [ "base_name = ? AND dir_name = ?", File.basename(file_path), File.dirname(file_path) ])
      end

      def to_file style = default_style
        puts("[paperclipdb] to_file  #{style}")
        if @queued_for_write[style]
          @queued_for_write[style]
        elsif exists?(style)
          attachment = getAttachment(path(style))
          tempfile = Tempfile.new attachment.base_name
          tempfile.write attachment.file_data
          tempfile
        else
          nil
        end
      end

      def flush_writes
        puts("[paperclipdb] Writing files #{@queued_for_write.count}")
        @queued_for_write.each do |style, file|
          puts("[paperclipdb] Writing files for #{file} #{style}")
          attachment = Paperclipdb::Attachment.new
          attachment.base_name = File.basename(path(style))
          attachment.dir_name = File.dirname(path(style))
          attachment.content_type = file.content_type
          attachment.file_size = file.size
          attachment.file_data = file.read
          attachment.save
        end
        @queued_for_write = {}
      end

      def flush_deletes
        @queued_for_delete.each do |path|
          puts("[paperclipdb] Deleting files for #{path}")
          attachment = getAttachment(path)
          if (!attachment.nil?)
          attachment.destroy
          end
        end
        @queued_for_delete = []
      end

    end
  end
end
