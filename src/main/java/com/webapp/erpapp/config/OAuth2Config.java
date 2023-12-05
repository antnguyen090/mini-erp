package com.webapp.erpapp.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.ClientAuthenticationMethod;

@Configuration
public class OAuth2Config {

    @Value("${spring.security.oauth2.client.registration.gitlab.client-id}")
    private String clientId;

    @Value("${spring.security.oauth2.client.registration.gitlab.client-secret}")
    private String clientSecret;

    @Value("${spring.security.oauth2.client.registration.gitlab.scope}")
    private String[] scope;

    @Value("${spring.security.oauth2.client.registration.gitlab.authorization-grant-type}")
    private AuthorizationGrantType authorizationGrantType;

    @Value("${spring.security.oauth2.client.registration.gitlab.redirect-uri}")
    private String redirectUri;

    @Value("${spring.security.oauth2.client.registration.gitlab.client-name}")
    private String clientName;

    @Value("${spring.security.oauth2.client.registration.gitlab.client-authentication-method}")
    private ClientAuthenticationMethod clientAuthenticationMethod;

    @Value("${spring.security.oauth2.client.provider.gitlab.token-uri}")
    private String tokenUri;

    @Value("${spring.security.oauth2.client.provider.gitlab.authorization-uri}")
    private String authorizationUri;

    @Value("${spring.security.oauth2.client.provider.gitlab.user-info-uri}")
    private String userInfoUri;

    @Value("${spring.security.oauth2.client.provider.gitlab.user-name-attribute}")
    private String userNameAttributeName;

    @Bean
    public ClientRegistrationRepository clientRegistrationRepository() {
        return new InMemoryClientRegistrationRepository(gitlabClientRegistration());
    }

    private ClientRegistration gitlabClientRegistration() {
        return ClientRegistration.withRegistrationId("gitlab")
                .clientId(clientId)
                .clientSecret(clientSecret)
                .scope(scope)
                .authorizationGrantType(authorizationGrantType)
                .redirectUriTemplate(redirectUri)
                .clientName(clientName)
                .clientAuthenticationMethod(clientAuthenticationMethod)
                .tokenUri(tokenUri)
                .authorizationUri(authorizationUri)
                .userInfoUri(userInfoUri)
                .userNameAttributeName(userNameAttributeName)
                .build();
    }
}