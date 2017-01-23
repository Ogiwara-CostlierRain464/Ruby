require './Stage.rb'
at_exit{ Stage.get_instance.print_stage }
Stage.new.process