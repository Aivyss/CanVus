package com.canvus.app.socket.listener;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.GenericMessage;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.messaging.support.NativeMessageHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.canvus.app.drawing.service.DrawingService;
import com.canvus.app.drawing.vo.DrawingUserVO;

@Component
public class WebSocketEventListener {

    private static final Logger logger = LoggerFactory.getLogger(WebSocketEventListener.class);

    @Autowired
    private DrawingService drawingService;

    @EventListener
    @SuppressWarnings("rawtypes")
    public List<DrawingUserVO> handleWebSocketConnectListener(SessionConnectedEvent event) {
        MessageHeaderAccessor accessor = NativeMessageHeaderAccessor.getAccessor(event.getMessage(), SimpMessageHeaderAccessor.class);
		GenericMessage generic = (GenericMessage) accessor.getHeader("simpConnectMessage");
        Map nativeHeaders = (Map) generic.getHeaders().get("nativeHeaders");
        String room_Id = (String) ((List) nativeHeaders.get("room_Id")).get(0);
        String sessionId = (String) generic.getHeaders().get("simpSessionId");

        /*StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
        System.out.println("## headerAccessor :: " + headerAccessor);
        String chatRoomId = headerAccessor.getNativeHeader("chatRoomId").get(0);
        String sessionId = headerAccessor.getSessionId();*/

        logger.info("[Connected] room id : {} | websocket session id : {}", room_Id, sessionId);

        return drawingService.connectUser(room_Id, sessionId);
    }

    @EventListener
    public List<DrawingUserVO> handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        MessageHeaderAccessor accessor = NativeMessageHeaderAccessor.getAccessor(event.getMessage(), SimpMessageHeaderAccessor.class);
		GenericMessage generic = (GenericMessage) accessor.getHeader("simpConnectMessage");
        Map nativeHeaders = (Map) generic.getHeaders().get("nativeHeaders");
        String room_Id = (String) ((List) nativeHeaders.get("room_Id")).get(0);
        String sessionId = (String) generic.getHeaders().get("simpSessionId");


        logger.info("[Disconnected] websocket session id : {}", sessionId);

        return drawingService.disconnectUser(room_Id, sessionId);
    }
}