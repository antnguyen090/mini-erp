package com.webapp.erpapp.config;

import com.webapp.erpapp.security.CustomAuthenticationFailureHandler;
import com.webapp.erpapp.security.CustomSuccessHandler;
import com.webapp.erpapp.security.UpdateProfileInterceptorFilter;
import com.webapp.erpapp.security.UserDetailsServiceImpl;
import com.webapp.erpapp.security.oauth2.CustomFailureOauth2Handler;
import com.webapp.erpapp.security.oauth2.CustomOAuth2UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UpdateProfileInterceptorFilter updateProfileInterceptorFilter;

    @Autowired
    private CustomSuccessHandler customSuccessHandler;

    @Autowired
    private CustomAuthenticationFailureHandler customAuthenticationFailureHandler;

    @Autowired
    private CustomOAuth2UserService customOAuth2UserService;

    @Autowired
    private CustomFailureOauth2Handler customFailureOauth2Handler;

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http
                .exceptionHandling()
                .accessDeniedPage("/forbidden") // 403 no access
                .and()
                .authorizeRequests()
                .antMatchers("/upload/**").permitAll() // resource
                .antMatchers("/assets/**").permitAll() // css, js
                // api
                .antMatchers("/api/v1/subscribe").permitAll()
                // auth
                .antMatchers("/api/v1/auth/**").permitAll()
                // accounting
                .antMatchers("/api/v1/accounts/**").access("hasAnyRole('OWNER', 'MANAGER')")
                // timesheets
                .antMatchers("/api/v1/timesheets/**").access("hasAnyRole('OWNER', 'MANAGER')")
                // book
                .antMatchers(HttpMethod.POST, "/api/v1/books/**").access("hasAnyRole('OWNER', 'MANAGER')")
                .antMatchers(HttpMethod.PUT, "/api/v1/books/**").access("hasAnyRole('OWNER', 'MANAGER')")
                .antMatchers(HttpMethod.DELETE, "/api/v1/books/**").access("hasAnyRole('OWNER', 'MANAGER')")
                // contract
                .antMatchers("/api/v1/contracts/**").access("hasAnyRole('OWNER', 'MANAGER')")
                // notification
                .antMatchers(HttpMethod.POST, "/api/v1/notifications/**").access("hasAnyRole('OWNER', 'MANAGER')")
                .antMatchers(HttpMethod.PUT, "/api/v1/notifications/**").access("hasAnyRole('OWNER', 'MANAGER')")
                .antMatchers(HttpMethod.DELETE, "/api/v1/notifications/**").access("hasAnyRole('OWNER', 'MANAGER')")
                //event
                .antMatchers(HttpMethod.POST, "/api/v1/events/**").access("hasAnyRole('OWNER', 'MANAGER')")
                .antMatchers(HttpMethod.PUT, "/api/v1/events/**").access("hasAnyRole('OWNER', 'MANAGER')")
                .antMatchers(HttpMethod.DELETE, "/api/v1/events/**").access("hasAnyRole('OWNER', 'MANAGER')")
                // setting
                .antMatchers(HttpMethod.PUT, "/api/v1/settings/**").access("hasAnyRole('OWNER', 'MANAGER')")
                // user
                .antMatchers(HttpMethod.GET, "/api/v1/users/usernames").access("hasAnyRole('OWNER', 'MANAGER')")
                .antMatchers(HttpMethod.GET, "/api/v1/users").access("hasAnyRole('OWNER', 'MANAGER')")
                .antMatchers(HttpMethod.DELETE, "/api/v1/users/**").access("hasAnyRole('OWNER', 'MANAGER')")
                .antMatchers(HttpMethod.PUT, "/api/v1/users/register/approval").access("hasAnyRole('OWNER', 'MANAGER')")
                // controller
                // auth
                .antMatchers("/login", "/register/**").permitAll()
                // user
                .antMatchers(HttpMethod.GET, "/users").access("hasAnyRole('OWNER', 'MANAGER')")
                // schedule
                .antMatchers(HttpMethod.GET, "/schedules", "/schedules/").access("hasAnyRole('OWNER', 'MANAGER')")
                // accounting
                .antMatchers("/accounting/**").access("hasAnyRole('OWNER', 'MANAGER')")
                // timesheets
                .antMatchers("/timesheets/**").access("hasAnyRole('OWNER', 'MANAGER')")
                // setting
                .antMatchers("/settings/**").access("hasAnyRole('OWNER', 'MANAGER')")
                // management-time
                .antMatchers("/management-time").access("hasAnyRole('OWNER', 'MANAGER')")

                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/login")
                .usernameParameter("username")
                .passwordParameter("password")
                .loginProcessingUrl("/j_spring_security_check").permitAll()
                .successHandler(customSuccessHandler)
                .failureHandler(customAuthenticationFailureHandler)
                .and()
                .oauth2Login()
                .loginPage("/login")
                .userInfoEndpoint().userService(customOAuth2UserService)
                .and()
                .successHandler(customSuccessHandler)
                .failureHandler(customFailureOauth2Handler)
                .and()
                .logout()
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout")
                .permitAll()
                .and()
                .addFilterBefore(updateProfileInterceptorFilter, UsernamePasswordAuthenticationFilter.class)
                .csrf().disable();
    }

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
    }
}
