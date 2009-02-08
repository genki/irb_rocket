require 'rubygems'
require 'terminfo'
require 'wirble'

Wirble.init

module IRB
  class CaptureIO
    def initialize
      @sin, @sout = IO.pipe
      @ein, @eout = IO.pipe
      @out, @err = STDOUT.dup, STDERR.dup
    end

    def capture(&block)
      STDOUT.reopen(@sout)
      STDERR.reopen(@eout)
      block.call
    ensure
      play
      STDOUT.reopen(@out)
      STDERR.reopen(@err)
    end

    def print(*args)
      @out.print(*args)
    end

    def play
      play_io(@ein) do |buf|
        @err.print Wirble::Colorize::Color.escape(:red) + buf + "\e[m"
      end
      play_io(@sin) do |buf|
        @out.print buf
      end
    end

  private
    def play_io(io, &block)
      buf = ""
      buf << io.read_nonblock(3) while true
    rescue Errno::EAGAIN
      block[buf]
    rescue Exception => e
      @out.print Wirble::Colorize::Color.escape(:yellow) + e.inspect
    end
  end

  class Irb
    alias :original_signal_status :signal_status
    def signal_status(name, *args, &block)
      if name == :IN_EVAL
        @last_line = eval('line', block.binding)
        @io = CaptureIO.new
        @io.capture do
          original_signal_status(name, *args, &block)
        end
      else
        original_signal_status(name, *args, &block)
      end
    end

    def output_value
      lines = @last_line.respond_to?(:to_a) ?
        @last_line.to_a : @last_line.each_line
      last = lines.map do |line|
        @context.io.prompt + line
      end.join.chomp
      @io.print((cuu1*lines.count) + last + " " +
        Wirble::Colorize::Color.escape(:blue) + "#=>" + sgr0 +
        " " + Wirble::Colorize.colorize(@context.last_value.inspect) + cud1)
    end

  private
    def terminfo; @terminfo ||= TermInfo.new end
    def cuu1; terminfo.tigetstr('cuu1') end
    def cud1; terminfo.tigetstr('cud1') end
    def sgr0; terminfo.tigetstr('sgr0') end
    def sc; terminfo.tigetstr('sc') end
    def rc; terminfo.tigetstr('rc') end
  end
end
