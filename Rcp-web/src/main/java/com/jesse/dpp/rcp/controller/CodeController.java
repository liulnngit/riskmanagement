package com.jesse.dpp.rcp.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 生成验证码
 * 
 * @author dyq-t176
 *
 */
@Controller
public class CodeController {
    
    private static Log log = LogFactory.getLog(CodeController.class);
    
    private char[] codeSequence = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

    @RequestMapping("/code")
    public void getCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            log.info("create code......");
            // 设置页面不缓存
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);

            // 在内存中创建图象
            int width = 100, height = 32;
            BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

            // 获取图形上下文
            Graphics g = image.getGraphics();

            // 生成随机类
            Random random = new Random();

            // 设定背景色
            g.setColor(getRandColor(200, 250));
            g.fillRect(0, 0, width, height);

            // 设定字体
            g.setFont(new Font("Times New Roman", Font.PLAIN, 22));

            // 画边框
            // g.setColor(new Color());
            // g.drawRect(0,0,width-1,height-1);

            // 随机产生155条干扰线，使图象中的认证码不易被其它程序探测到
            g.setColor(getRandColor(160, 200));
            for (int i = 0; i < 155; i++) {
                int x = random.nextInt(width);
                int y = random.nextInt(height);
                int xl = random.nextInt(12);
                int yl = random.nextInt(12);
                g.drawLine(x, y, x + xl, y + yl);
            }

            // 取随机产生的认证码(4位数字)
            String sRand = "";
            for (int i = 0; i < 4; i++) {
                String rand = String.valueOf(codeSequence[random.nextInt(36)]);
                sRand += rand;
                // 将认证码显示到图象中
                g.setColor(new Color(20 + random.nextInt(110), 20 + random.nextInt(110), 20 + random.nextInt(110)));// 调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成
                g.drawString(rand, 25 * i + 6, 23);// 13 16 调整图片数字的位置
            }

            // 将认证码存入SESSION
            HttpSession session = request.getSession();
            session.setAttribute("code", sRand);

            // 将生成的验证码根据sessionid存入到redis的缓存中，避免由于nginx轮询造成验证码不匹配的问题
            /*
             * ServletContext context = config.getServletContext();
             * ApplicationContext ctx =
             * WebApplicationContextUtils.getWebApplicationContext(context);
             * RedisService redisService = (RedisService)
             * ctx.getBean("redisService"); if (redisService.exists("key_rand_" +
             * session.getId())) { redisService.del("key_rand_" + session.getId());
             * } redisService.set("key_rand_" + session.getId(),
             * session.getAttribute("rand").toString(), 300);
             */

            // 图象生效
            g.dispose();

            // 将图像输出到Servlet输出流中。
            ServletOutputStream sos = response.getOutputStream();
            ImageIO.write(image, "jpeg", sos);
            sos.close();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    private Color getRandColor(int fc, int bc) {// 给定范围获得随机颜色
        Random random = new Random();
        if (fc > 255) {
            fc = 255;
        }    
        if (bc > 255) {
            bc = 255;
        }    
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r, g, b);
    }

}
