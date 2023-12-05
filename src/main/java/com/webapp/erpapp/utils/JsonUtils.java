package com.webapp.erpapp.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.webapp.erpapp.exception.ErrorConvertJsonException;

public class JsonUtils {

    private static final ObjectMapper objectMapper = new ObjectMapper();

    public static <T> T jsonToObject(String json, Class<T> valueType) {
        try {
            return objectMapper.readValue(json, valueType);
        } catch (Exception e) {
            throw new ErrorConvertJsonException("Error convert json to object");
        }
    }

    public static String objectToJson(Object object) {
        try {
            return objectMapper.writeValueAsString(object);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
