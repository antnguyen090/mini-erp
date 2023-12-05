package com.webapp.erpapp.entity;

import com.webapp.erpapp.enums.user.*;
import com.webapp.erpapp.enums.user.*;
import com.webapp.erpapp.utils.StringUtils;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.*;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User implements UserDetails, OAuth2User {

    private String id;
    private String fullname;
    private Date dateOfBirth;
    private String phone;
    private String emergencyPhone;
    private String avatar;
    private TypeUserEnum type;
    private DepartmentEnum department;
    private String atm;
    private String email; // user_id
    private String password;
    private RoleEnum role;
    private StatusUserEnum status;
    private PositionEnum position;
    private String resume;
    private String address;
    private String timesheetsCode;
    private List<Contract> contracts;
    private Date createdDate;
    private GenderEnum gender;

    public boolean checkAcceptUpdateBasicInfo(){
        return !StringUtils.isBlank(fullname)
                && dateOfBirth != null
                && !StringUtils.isBlank(phone)
                && !StringUtils.isBlank(emergencyPhone)
                && !StringUtils.isBlank(address)
                && gender != null;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority("ROLE_" + role));
        return authorities;
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    private OAuth2User user;

    @Override
    public String getName() {
        if(user!=null){
            return user.getName();
        }
        return null;
    }

    @Override
    public Map<String, Object> getAttributes() {
        if(user!=null){
            return user.getAttributes();
        }
        return null;
    }
}