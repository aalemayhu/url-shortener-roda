require 'redis'

CACHE = Redis.new host: ENV['REDIS_URL'] || 'localhost'
