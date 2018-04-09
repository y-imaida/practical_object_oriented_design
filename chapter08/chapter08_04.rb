module PartsFactory
  def self.build(config,
                 part_class = Part,
                 parts_class = Parts)
    parts_class.new(
      config.collect { |part_config|
        part_class.new(
          name: part_config[0],
          description: part_config[1],
          needs_spare: part_config.fetch(2, true)
        )
      }
    )
  end
end

require 'forwardable'

class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select { |part| part.needs_spare }
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @needs_spare = args.fetch(:needs_spare, true)
  end
end

road_config = [
  ['chain', '10-speed'],
  ['tire_size', '23'],
  ['tape_color', 'red']
]
road_parts = PartsFactory.build(road_config)
p road_parts
