package com.canvus.app.controller;

import java.util.HashMap;
import java.util.Map;

import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import com.canvus.app.service.PaymentService;
import com.canvus.app.vo.PaymentCompleteInfo;

import javax.servlet.http.HttpSession;

@Slf4j
@RestController
@RequestMapping(value="/payment")
public class PaymentRestController {
    @Autowired
    PaymentService paymentService;

    /**
     * merchant uid 생성 컨트롤러 메소드
     * 20210228 수정
     * 이한결
     * @param params
     * @param session
     * @return
     */
    @RequestMapping(value="/parseMerchantUid", method=RequestMethod.POST)
    public Map<String, Object> parseMerchantUid(@RequestBody Map<String, Object> params,
                                                HttpSession session) {
        log.info("파싱 과정 진입");

        return paymentService.merchantUidParse(params, session);
    }

    @RequestMapping(value="/paymentSubmit", method=RequestMethod.POST)
    public Map<String, Object> paymentSubmit(@RequestBody Map<String, Object> params) {
        log.info("결제 승인과정");

        String result = "결제실패";
        Map<String, Object> output = new HashMap<>();

        boolean check = paymentService.paymentSubmit(params);

        if (check) {
            result = "결제 성공";
            output.put("result", result);
            log.info(result);
        } else {
            output.put("result", result);
            log.info(result);
        }

        return output;
    }
}