package com.webapp.erpapp.api;

import com.google.zxing.WriterException;
import com.webapp.erpapp.utils.QRUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping("/api/v1/qrcode")
public class QRCodeApi {

    @PostMapping()
    public ResponseEntity<?> generateQRCode(String content) throws IOException, WriterException {
        return ResponseEntity.ok(QRUtils.generateQRCode(content));
    }

}
