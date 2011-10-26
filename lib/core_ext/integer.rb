class Integer

  class << self

    ##
    # Generate a fibonacci sequence, based on provide options.
    #
    # @note Possible options:
    #   size - Generate a sequence containing <size> numbers.
    #   max  - Stop when max is reached, and return the last number below max.
    #   last - Return entire sequence or last number. ALWAYS return last number if max is provided
    #   zero - Include zero in sequence. If last is true, then removing zero is irrelavent
    #
    # @param options [Hash] The options to use when generating sequence
    # @return [Array, Integer] The sequence or the last number in the sequence
    def fibonacci(options={})
      max  = options[:max]               
      size = options[:size]
      last = options[:last] || !max.nil?
      zero = options[:zero] || !max.nil?

      raise ArgumentError, 'Must have size or max' if size.nil? && max.nil?

      sequence = [0, 1]

      return nil if max == 0
      return 0 if max == 1

      unless size.nil? || size > 1
        return size if last
        case size
        when 0 then return zero ? [0] : []
        when 1 then return zero ? sequence : [1]
        end
      end

      update_sequence = Proc.new do
        next_num = sequence[-1] + sequence[-2]
        return sequence.last if max && next_num >= max
        sequence << next_num 
      end

      if size
        size.times &update_sequence
      elsif max
        begin
          update_sequence.call
        end while true
      end

      sequence.shift unless last || zero # if returning last, no need to remove zero

      return last ? sequence.last : sequence.uniq.take(size)
    end
  end # class << self

  ##
  # Get the closest number in the fibonacci sequence lower then this number (self).
  #
  # @example
  #   >> 156.closest_fibonacci 
  #   => 144
  #
  # @return [Integer] The closest fibonacci number under self
  def closest_fibonacci
    self.class.fibonacci(:max => self)
  end
 
end
