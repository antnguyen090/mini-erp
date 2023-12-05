package com.webapp.erpapp.config;

import liquibase.integration.spring.SpringLiquibase;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@Configuration
public class LiquibaseConfig {

    @Value("${liquibase.changeLog}")
    private String liquibaseChangeLog;

    @Bean
    public SpringLiquibase liquibase(DataSource dataSource) {
        SpringLiquibase liquibase = new SpringLiquibase();

        liquibase.setChangeLog(liquibaseChangeLog);
        liquibase.setDataSource(dataSource);
        liquibase.setContexts("development, production");
        liquibase.setShouldRun(true);

        return liquibase;
    }
}
