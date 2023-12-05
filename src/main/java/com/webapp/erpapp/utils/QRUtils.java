package com.webapp.erpapp.utils;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

public class QRUtils {
    public static byte[] generateQRCode(String content) throws WriterException, IOException {
        BitMatrix matrix = new MultiFormatWriter().encode(content, BarcodeFormat.QR_CODE, 300, 300);
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        MatrixToImageWriter.writeToStream(matrix, "png", outputStream);
        return outputStream.toByteArray();
    }
}
