REDIS_URL = "redis://redis:6379/0"

config.cache_store = :redis_cache_store, { url: REDIS_URL }
