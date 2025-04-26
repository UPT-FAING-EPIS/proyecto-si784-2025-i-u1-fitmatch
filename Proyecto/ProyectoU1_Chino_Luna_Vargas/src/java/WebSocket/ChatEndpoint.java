/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package WebSocket;

/**
 *
 * @author Sio
 */
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.server.PathParam;

@ServerEndpoint("/chat/{chatId}/{userId}")
public class ChatEndpoint {
    private static final Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session, @PathParam("chatId") String chatId, @PathParam("userId") String userId) {
        session.getUserProperties().put("chatId", chatId);
        session.getUserProperties().put("userId", userId);
        sessions.add(session);
    }

    @OnMessage
    public void onMessage(String message, Session senderSession) throws IOException {
        String chatId = (String) senderSession.getUserProperties().get("chatId");
        String userId = (String) senderSession.getUserProperties().get("userId");
        String formattedMessage = userId + ": " + message;
        
        synchronized (sessions) {
            for (Session session : sessions) {
                if (session.isOpen() && chatId.equals(session.getUserProperties().get("chatId"))) {
                    session.getBasicRemote().sendText(formattedMessage);
                }
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
    }
}