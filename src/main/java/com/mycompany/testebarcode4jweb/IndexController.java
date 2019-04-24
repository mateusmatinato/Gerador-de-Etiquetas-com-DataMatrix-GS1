/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.testebarcode4jweb;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import uk.org.okapibarcode.backend.DataMatrix;
import uk.org.okapibarcode.backend.Symbol;
import uk.org.okapibarcode.output.Java2DRenderer;

@Controller
public class IndexController {

    @RequestMapping(value = {"index"})
    public String index(Model model) {

        return "index";
    }

    @RequestMapping(value = "gerarDataMatrix/")
    public @ResponseBody
    String gerarDataMatrix(@RequestParam(value = "codigo") String codigo, @RequestParam(value = "data") String data, @RequestParam(value = "lote") String lote, @RequestParam(value = "tamanho") Double tamanho, HttpServletResponse response) throws IOException {
        response.setContentType("image/png");

        DataMatrix datamatrix = new DataMatrix();
        datamatrix.setDataType(Symbol.DataType.GS1);
        datamatrix.setPreferredSize(0);

        int magnification = 10;
        int BORDER_SIZE = 0 * magnification;

        ServletOutputStream out = response.getOutputStream();
        ByteArrayOutputStream bits = new ByteArrayOutputStream();
        try {
            //Set up the canvas provider for monochrome PNG output 

            //Generate the barcode
            String[] AnoMesDia;
            AnoMesDia = data.split("-");
            String text = "[01]" + codigo + "[17]" + (Integer.parseInt(AnoMesDia[0]) - 2000) + "" + AnoMesDia[1] + "" + AnoMesDia[2] + "[10]" + lote;

            datamatrix.setContent(text);
            BufferedImage image = getMagnifiedBarcode(datamatrix, magnification, BORDER_SIZE);

            
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(image, "png", baos);
            
            out.write(baos.toByteArray());
            out.flush();

        } catch (IOException e) {
            return e.getMessage();

        } finally {
            out.close();
        }

        return "index";
    }
    
    private static BufferedImage getMagnifiedBarcode(Symbol symbol, int magnification, int BORDER_SIZE){
        // Make DataMatrix object into bitmap
        BufferedImage image = new BufferedImage((symbol.getWidth() * magnification) + (2 * BORDER_SIZE),
                                                (symbol.getHeight() * magnification) + (2 * BORDER_SIZE), 
                                                BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = image.createGraphics();
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g2d.setColor(Color.WHITE);
        g2d.fillRect(0, 0, (symbol.getWidth() * magnification) + (2 * BORDER_SIZE),
                    (symbol.getHeight() * magnification) + (2 * BORDER_SIZE));
        Java2DRenderer renderer = new Java2DRenderer(g2d, magnification, Color.WHITE, Color.BLACK);
        renderer.render(symbol);
        
        return image;
    }

}
