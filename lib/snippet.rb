require 'open3'
require 'tempfile'

class Snippet
  def initialize(file_name, code)
    @file_name, @code = file_name, code
  end

  def execute
    file_extension = File.extname(@file_name).downcase

    compiler_cmd_line = case file_extension
                        when '.c' then    ['gcc', '-o']
                        when '.rs' then ['rustc', '-o']
                        when '.rb' then []
                        else raise "Unsupported language for file: #{@file_name}"
                        end

    src_tmp_file = Tempfile.new(['source_file', file_extension])
    src_tmp_file.write(@code)
    src_tmp_file.close

    source_file_path = src_tmp_file.path

    # 1. Compile (only for C and Rust)
    if compiler_cmd_line.any?
      out_file_path = source_file_path + '.out'
      compiler_cmd_line << out_file_path << source_file_path
      success, output = run_command(compiler_cmd_line)
      return [success, output] unless success
    else
      out_file_path = source_file_path
    end

    # 2. Execute
    runner_cmd_line = case file_extension
                      when '.c', '.rs' then []
                      when '.rb' then ['ruby']
                      else raise "Unsupported language for file: #{@file_name}"
                      end
    
    runner_cmd_line << out_file_path
    run_command(runner_cmd_line)
  ensure
    src_tmp_file.unlink if src_tmp_file
    File.delete(out_file_path) if File.exist?(out_file_path)
  end

  private

  def run_command(parts)
    Open3.popen2e(*parts) do |stdin, stdout_and_stderr, wait_thr|
      output = stdout_and_stderr.read
      success = wait_thr.value.success?
      [success, output]
    end
  end
end

