package com.webapp.erpapp.security;

import com.webapp.erpapp.entity.User;
import com.webapp.erpapp.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class UpdateProfileInterceptorFilter extends OncePerRequestFilter {

    @Autowired
    private UserMapper userMapper;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
       if(!urlsAllow(request.getRequestURI())){
           Authentication auth = SecurityContextHolder.getContext().getAuthentication();
           if (auth != null) {
               User userSet = userMapper.findById(((User) auth.getPrincipal()).getId());

               UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(userSet, auth.getCredentials(), userSet.getAuthorities());

               SecurityContextHolder.getContext().setAuthentication(newAuth);
           }

           if (auth != null && auth.isAuthenticated()) {
               try {
                   User currentUser = Principal.getUserCurrent();
                   if(currentUser == null) {
                       response.sendRedirect("/login");
                   }
                   User user = userMapper.findById(currentUser.getId());
                   if(!user.checkAcceptUpdateBasicInfo()) {
                       response.sendRedirect("/users/" + currentUser.getId());
                   }
               } catch (Exception e) {
                   e.printStackTrace();
               }
           }
       }
        filterChain.doFilter(request, response);
    }

    private boolean urlsAllow(String u){
        String[] urls = new String[]{
                "/assets/",
                "/upload/",
                "/users/",
                "/api/",
                "/service-worker.js"
        };

        for(String url: urls){
            if(u.startsWith(url)) return true;
        }
        return false;
    }
}