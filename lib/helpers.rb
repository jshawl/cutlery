module Helpers
  def env(*keys)
    errors = keys.select do |key|
      ENV[key].nil?
    end
    if errors.any?
      raise "Env vars: #{errors.join(', ')} not set"
    end
    out = keys.map do |key|
      ENV[key]
    end
    out.one? ? out.first : out
  end
  def headers
    {
      "Content-Type": "application/json",
      "User-Agent": "autojira"
    }
  end
end