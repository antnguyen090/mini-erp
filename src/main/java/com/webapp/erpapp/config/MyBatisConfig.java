package com.webapp.erpapp.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;

@Configuration
//This annotation is used to specify the package where MyBatis mapper interfaces are located. MyBatis mappers are responsible for defining SQL queries and mapping the results to Java objects. In this case, it's configured to scan the "com.example.complainboard.mapper" package for MyBatis mappers.
@MapperScan("com.webapp.erpapp.mapper")
//the MyBatisConfig class is a Spring configuration class that sets up MyBatis by specifying the package where MyBatis mapper interfaces are located and injecting database-related properties (driver name, URL, username, password) from a configuration source. These properties are crucial for configuring the database connection used by MyBatis to interact with the database.
public class MyBatisConfig {
    //    These properties are typically used to configure the database connection, specifying details such as the database driver, URL, username, and password.
    @Value("${db.driver-name}")
    private String dbDriverName;

    @Value("${db.url}")
    private String dbUrl;

    @Value("${db.username}")
    private String dbUsername;

    @Value("${db.password}")
    private String dbPassword;


    //    Configure the connection port to the database using DataSource
    @Bean
    public DataSource dataSource() {
//        This method creates a DriverManagerDataSource object, one of the implementations of the DataSource interface.
        DriverManagerDataSource dataSource = new DriverManagerDataSource();

//        This is the configuration of the JDBC driver used for connecting to the MariaDB database.
        dataSource.setDriverClassName(dbDriverName);

//        This is the connection URL to the MariaDB database. It includes information about the server, port, and database name.
        dataSource.setUrl(dbUrl + "?allowMultiQueries=true");

//        This is the username used to log into the database.
        dataSource.setUsername(dbUsername);

//        This is the user's password to log into the database.
        dataSource.setPassword(dbPassword);
        return dataSource;
    }

    @Bean
//    This method defines a bean named "sqlSessionFactory" of type SqlSessionFactory. It takes a DataSource as an argument, indicating that this bean depends on a DataSource bean.
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
//        Here, an instance of the SqlSessionFactoryBean class is created. This class is part of MyBatis, a Java persistence framework that integrates with databases.
        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();

//        This line sets the DataSource for the SqlSessionFactoryBean. It configures the data source that MyBatis will use to interact with the database.
        sessionFactory.setDataSource(dataSource);

        org.apache.ibatis.session.Configuration configuration = new org.apache.ibatis.session.Configuration();
        configuration.setUseActualParamName(true);
        sessionFactory.setConfiguration(configuration);

// Set the mapper locations using the classpath pattern
        sessionFactory.setMapperLocations(
                new PathMatchingResourcePatternResolver().getResources("classpath:mapper/*.xml"));

//        Finally, the method returns the SqlSessionFactory object created and configured in the previous steps. This SqlSessionFactory will be used to create SQL sessions for interacting with the database.
        return sessionFactory.getObject();
    }

    @Bean
//    This method defines a bean named "transactionManager" of type DataSourceTransactionManager. It takes a DataSource as an argument, indicating that this bean depends on a DataSource bean.
    public DataSourceTransactionManager transactionManager(DataSource dataSource) {

        //This line creates a new instance of DataSourceTransactionManager and initializes it with the provided DataSource. The DataSourceTransactionManager manages database transactions, ensuring that they are properly committed or rolled back.
        return new DataSourceTransactionManager(dataSource);
    }

    @Bean
    //This is the method declaration. It declares a method named sqlSessionTemplate, and it takes a parameter of type SqlSessionFactory. The SqlSessionFactory is typically used to create SQL sessions in MyBatis, a popular Java persistence framework for working with relational databases.
    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {

        //This line of code creates a new instance of SqlSessionTemplate and initializes it with the SqlSessionFactory passed as a parameter. The SqlSessionTemplate is a class provided by MyBatis that simplifies the usage of SQL sessions. It manages the lifecycle of SQL sessions, commits or rolls back transactions, and provides a convenient API for executing SQL queries.
        return new SqlSessionTemplate(sqlSessionFactory);
    }
}