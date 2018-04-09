class Bicycle
  attr_reader :size, :parts   # Bicycleはpartsを持つ

  def initialize(args={})
    @size = args[:size]
    @parts = args[:parts]
  end

  def spares
    parts.spares              # sparesメッセージの送信
  end
end
