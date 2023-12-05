package com.webapp.erpapp.utils;

import com.webapp.erpapp.constant.CacheConstant;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

@Component
public class CacheUtils {

    @CachePut(value = CacheConstant.CACHE_NAME, key = "#token")
    public String createVerificationToken(String token, String content) {
        return content;
    }

    @Cacheable(value = CacheConstant.CACHE_NAME, key = "#token")
    public String getVerificationToken(String token) {
        return null;
    }

    @CacheEvict(value = CacheConstant.CACHE_NAME, key = "#token")
    public void deleteVerificationToken(String token) {}
}
