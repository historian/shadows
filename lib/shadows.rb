module Shadows
  
  def require_with_shadow(filename, *args, &block)
    if filename == :shadow
      
      # find the path of the caller
      caller_list = caller
      caller_path = caller_list.first.split(':', 2).first
      relative_caller_path = nil
      
      # we don't support eval
      if caller_path == '(eval)'
        e = LoadError.new("#require(:shadow) cannot be called from an eval unless you specify what file it represents!")
        e.set_backtrace caller_list
        raise e
      end
      
      # find a file with the same relative path a caller
      $:.uniq.each do |load_path|
        
        # find load path of caller
        if caller_path[0,load_path.size] == load_path
          relative_caller_path = caller_path[(load_path.size + 1)..-1]
        
        # check for shadowed file
        elsif relative_caller_path
          full_path = File.join(load_path, relative_caller_path)
          
          # faster than require, rescue
          if Dir.glob("#{full_path}{.rb,}").empty?
            next
          end
          
          # try loading the shadowed file
          begin
            return require(full_path)
          rescue LoadError
            next
          end
        end
      end
      
      # raise LoadError when no shadowed file was found
      e = LoadError.new("no such file to load - #{relative_caller_path} [:shadow]")
      e.set_backtrace caller_list
      raise e
      
    else
      require_without_shadow(filename, *args, &block)
    end
  end
  
  def self.included(base)
    base.class_eval do
      alias_method :require_without_shadow, :require
      alias_method :require, :require_with_shadow
    end
  end
  
  Kernel.send :include, self
  
end