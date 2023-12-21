# a Monte Carlo simulator
module TinyMonte
  class << self
    # returns the result set from running the specified number of Monte Carlo
    # simulations with the specified probability.
    #
    # trials: the number of trials to perform
    # samples_per_trial: the number of samples to generate per trial
    # probability: the probability of success in each trial
    #
    # ex:
    #   TinyMonte.monte(1000, 0.5) # => [51, 48, 52, ...]
    def monte(trials, samples_per_trial, probability)
      (1..trials).map{|i| _trial(samples_per_trial, probability).count(1) }
    end

    # returns the median result from the output of the ::monte method.
    #
    # ex:
    #   TinyMonte.median_result(TinyMonte.monte(1000, 0.5)) # => 50
    def median_result(results)
      sorted = results.sort
      sorted_count = sorted.count
      working_median = sorted_count.odd? ? sorted[((sorted_count + 1) / 2) - 1] : (sorted[(sorted_count - 1) / 2] + sorted[((sorted_count) / 2)] / 2.0)
      working_median == working_median.to_i ? working_median.to_i : working_median
    end

    # returns an array of samples constituting a single trial run
    #
    # ex:
    #   _trial(100, 0.5) # => [0, 1, 1, 0, ...] <100 times long>
    def _trial(samples_per_trial, probability)
      (1..samples_per_trial).map{|i| rand() <= probability ? 1 : 0 }
    end
  end
end
