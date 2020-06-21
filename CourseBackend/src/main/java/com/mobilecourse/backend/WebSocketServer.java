package com.mobilecourse.backend;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Hashtable;

// websocket用于在线聊天
@ServerEndpoint(value = "/websocket/{username}")
@Component
public class WebSocketServer {

    public static Hashtable<String, WebSocketServer> getWebSocketTable() {
        return webSocketTable;
    }

    private static Hashtable<String, WebSocketServer> webSocketTable = new Hashtable<>();

    //与某个客户端的连接会话，需要通过它来给客户端发送数据
    private Session session;

    //用于标识客户端的sid
    private String username = "";

    //推荐在连接的时候进行检查，防止有人冒名连接
    @OnOpen
    public void onOpen(Session session, @PathParam("username")String username) {
        this.session = session;
        this.username = username;
        webSocketTable.put(username, this);
        try {
            System.out.println(username + "成功连接websocket");
            sendMessage("连接成功！");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 在关闭连接时移除对应连接
    @OnClose
    public void onClose() {
        System.out.printf(this.username+" close");
        webSocketTable.remove(this.username);
    }

    // 收到消息时候的处理
    @OnMessage
    public void onMessage(String request, Session session) {
        //将message进行json化，然后获取发送方等
        JSONObject json = JSON.parseObject(request);
        String sender = json.getString("sender");
        String receiver = json.getString("receiver");
        String msg = json.getString("msg");
        WebSocketServer server =  webSocketTable.get(receiver);
        if(server == null) {
            try {
                sendMessage(receiver + " 未登录");
            }catch (Exception e){
                e.printStackTrace();
            } finally {
                return;
            }
        }
        try {
            server.sendMessage(request);
        }catch (Exception e){
            e.printStackTrace();
        }
        System.out.printf("message:"+msg);
    }

    @OnError
    public void onError(Session session, Throwable error) {
        error.printStackTrace();
        webSocketTable.remove(this.username);
    }

    public void sendMessage(String message) throws IOException {
        this.session.getBasicRemote().sendText(message);
    }
}
