package com.webapp.erpapp.mapper;


import com.webapp.erpapp.entity.Setting;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SettingMapper {

    List<Setting> findAll();
    int updateSetting(Setting setting);
    Setting findById(String id);
    Setting findByCode(String code);
}