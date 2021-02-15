package com.canvus.app.socket.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketTransportRegistration;
import org.springframework.web.socket.server.standard.ServletServerContainerFactoryBean;

import com.canvus.app.socket.interceptor.HandshakeInterceptor;


@Configuration
@EnableWebSocketMessageBroker
public class StompConfig extends AbstractWebSocketMessageBrokerConfigurer {

	@Autowired
	private HandshakeInterceptor handshakeInterceptor;
	
	@Override
	public void configureWebSocketTransport(WebSocketTransportRegistration registration) {
		registration.setSendTimeLimit(20*10000);
		registration.setSendBufferSizeLimit(3* 512 * 1024);
		registration.setMessageSizeLimit(160 * 64 * 1024);
		
		super.configureWebSocketTransport(registration);
	}

	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		registry.enableSimpleBroker("/subscribe");			// subscribe prefix 설정
		registry.setApplicationDestinationPrefixes("/");		// send prefix 설정
	}

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		registry.addEndpoint("/endpoint").withSockJS().setInterceptors(handshakeInterceptor);
	}
	
	/**
	 * 아 왠지 모르겠지만 이부분 추가하면 웹소켓 용량제한없이 보낼 수 있네.. 왜지 ㅠ
	 * @return
	 */
	@Bean
	public ServletServerContainerFactoryBean createServletServerContainerFactoryBean() {
	    ServletServerContainerFactoryBean container = new ServletServerContainerFactoryBean();
	    container.setMaxTextMessageBufferSize(2048 * 2048);
	    container.setMaxSessionIdleTimeout(2048L * 2048L);
	    container.setAsyncSendTimeout(2048L * 2048L);
	    container.setMaxBinaryMessageBufferSize(2048 * 2048);
	    return container;
	}

}