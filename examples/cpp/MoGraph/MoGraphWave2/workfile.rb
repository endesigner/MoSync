#!/usr/bin/ruby

require File.expand_path(ENV['MOSYNCDIR']+'/rules/mosync_exe.rb')

work = PipeExeWork.new
work.instance_eval do
	@SOURCES = ["."]
	@EXTRA_INCLUDES = ["#{mosyncdir}/include/newlib/stlport", "#{mosyncdir}/include/newlib/glm", "#{mosyncdir}/include/newlib/MoGraph"]
	@EXTRA_CPPFLAGS = ' -Wno-float-equal -Wno-unreachable-code -Wno-shadow -Wno-missing-noreturn'
	@LIBRARIES = ["stlport", "mautil", "mograph"]
	@EXTRA_LINKFLAGS = ' -datasize=2048000 -heapsize=1728000 -stacksize=128000'
	@NAME = "MoGraphWave2"
end

work.invoke
