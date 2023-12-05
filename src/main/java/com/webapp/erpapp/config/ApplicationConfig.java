package com.webapp.erpapp.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

@Configuration
@EnableAsync
@PropertySource("classpath:application.properties")
public class ApplicationConfig {

    @Value("${multipart.defaultEncoding}")
    private String defaultEncoding;

    @Bean
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        multipartResolver.setDefaultEncoding(defaultEncoding);
        multipartResolver.setMaxUploadSize(-1);
        multipartResolver.setMaxUploadSizePerFile(-1);
        return multipartResolver;
    }
}
