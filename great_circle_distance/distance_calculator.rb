module DistanceCalculator

  RADIANS_PER_DEGREE = Math::PI / 180.0
  RADIUS_OF_EARTH_KMS = 6371.00

  def self.calculate_distance(geocode_1, geocode_2)
    theta_1 = geocode_1[:latitude] * RADIANS_PER_DEGREE
    theta_2 = geocode_2[:latitude] * RADIANS_PER_DEGREE

    delta_theta = (geocode_1[:latitude] - geocode_2[:latitude]) * RADIANS_PER_DEGREE
    delta_lambda = (geocode_1[:longitude] - geocode_2[:longitude]) * RADIANS_PER_DEGREE

    a = Math.sin(delta_theta / 2) ** 2 + Math.cos(theta_1) * Math.cos(theta_2) * Math.sin(delta_lambda / 2) ** 2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    c * RADIUS_OF_EARTH_KMS
  end


end
