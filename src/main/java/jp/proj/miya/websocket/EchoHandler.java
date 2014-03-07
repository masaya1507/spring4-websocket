package jp.proj.miya.websocket;

import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class EchoHandler extends TextWebSocketHandler {
	private Map<String, WebSocketSession> mapSession;

	public EchoHandler() {
		this.mapSession = new ConcurrentHashMap<>();
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		this.mapSession.put(session.getId(), session);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		this.mapSession.remove(session.getId());
	}

	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		for (Entry<String, WebSocketSession> entry : this.mapSession.entrySet()) {
			//TextMessage msg = new TextMessage(session.getRemoteAddress().getAddress() + ":" + message.getPayload());
			entry.getValue().sendMessage(message);
		}
	}

}
