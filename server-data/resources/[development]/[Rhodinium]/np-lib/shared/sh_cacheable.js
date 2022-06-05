function Cacheable(getValueCb, options) {
  const ttl = options.timeToLive || 60000;
  let cachedValue = null;
  let lastUpdated = 0;

  const ensureCachedValue = function(...args) {
    const now = Date.now();
    if (now - lastUpdated > ttl) {
      lastUpdated = now;
      cachedValue = getValueCb(...args);
    }
  }

  const getCachedValue = function(...args) {
    ensureCachedValue(...args);
    return cachedValue;
  }

  getCachedValue.reset = function () {
    lastUpdated = 0;
  }

  return getCachedValue;
}
