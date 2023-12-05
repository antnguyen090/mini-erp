package com.webapp.erpapp.config;

import org.bouncycastle.jce.provider.BouncyCastleProvider;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.security.Security;


@WebListener
public class AppInitializer implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        Security.addProvider(new BouncyCastleProvider());
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
