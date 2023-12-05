package com.webapp.erpapp.config;


import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/service-worker.js")
                .addResourceLocations("/service-worker.js");
        registry
                .addResourceHandler("/upload/**")
                .addResourceLocations("/upload/");
        registry
                .addResourceHandler("/assets/**")
                .addResourceLocations("/assets/");
    }
}
