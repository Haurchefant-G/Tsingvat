package com.mobilecourse.backend;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.mobilecourse.backend.dao.AccountDao;
import com.mobilecourse.backend.dao.MsgDao;
import com.mobilecourse.backend.entity.Account;
import com.mobilecourse.backend.entity.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import java.util.UUID;

// websocket用于在线聊天
@ServerEndpoint(value = "/websocket/{username}")
@Component
public class WebSocketServer {

    public static int RECV_SUCCESS = 10;
    public static int SEND_SUCCESS = 11;
    public static int SEND_FAILURE = 11;

    @Autowired
    public void setMsgDao(MsgDao msgDao){
        WebSocketServer.msgDao = msgDao;
    }

    private static MsgDao msgDao;

    @Autowired
    public void setAccountDao(AccountDao accountDao){
        WebSocketServer.accountDao = accountDao;
    }

    private static AccountDao accountDao;

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
        // TODO 检查是否注册？
        if(!checkExist(accountDao.getUser(username))){
            sendMessage(wrapperMessage(SEND_FAILURE, "未注册", null));
            return;
        }
        webSocketTable.put(username, this);
        // 将还未收到的信息全部返回，同时设置为sent
        List<Msg> msgs = msgDao.getUnsendMsg(username);
        setMsgSent(msgs);
        System.out.println(username + "成功连接websocket");
        sendMessage(wrapperMessage(SEND_SUCCESS,username + "成功连接websocket", msgs));

    }

    // 在关闭连接时移除对应连接
    @OnClose
    public void onClose() {
        System.out.printf(this.username+" close");
        webSocketTable.remove(this.username);
    }

    // 收到消息时候的处理x
    @OnMessage
    public void onMessage(String request, Session session)  {
        System.out.println("onMessage:"+request);
        //将message进行json化，然后获取发送方等
        JSONObject json = JSON.parseObject(request);
        String sender = json.getString("sender");
//        String sender = this.username;
        String receiver = json.getString("receiver");


        String content = json.getString("content");
        if(content == null || content.length() == 0) {
            sendMessage(wrapperMessage(SEND_FAILURE, "content不能为空", null));
        }
        int type = json.getInteger("type");

        Msg msg = new Msg(UUID.randomUUID().toString(), sender,  receiver, content, new Timestamp(new Date().getTime()), type, true);

        WebSocketServer server =  webSocketTable.get(receiver);
        if(server == null) {
            System.out.println(receiver + " 未登录");
            // 发送给自己，显示为登录
            sendMessage(wrapperMessage(SEND_SUCCESS,receiver + "未登录", null));
            msg.setSent(false);
        }
        else {
            String messgae = wrapperMessage(RECV_SUCCESS, "发送成功",msg);
            server.sendMessage(messgae);
        }
        msgDao.addMsg(msg);
        System.out.printf("message:"+msg);
    }

    @OnError
    public void onError(Session session, Throwable error) {
        error.printStackTrace();
        webSocketTable.remove(this.username);
    }

    public void sendMessage(String msg){
        System.out.println(this.username +" [send]: "+ msg);
        try {
            this.session.getBasicRemote().sendText(msg);
        }catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Async
    public void setMsgSent(List<Msg> msgs){
        for(Msg msg : msgs){
            msgDao.sendMsg(msg.getUuid());
        }
    }

    public String wrapperMessage(int code, String msg, Object data){
        JSONObject wrapperMsg = new JSONObject();
        wrapperMsg.put("code", code);
        wrapperMsg.put("data", data);
        wrapperMsg.put("msg", msg);
        return wrapperMsg.toJSONString();
    }

    public static boolean checkExist(List<Account> accounts){
        if(accounts == null || accounts.size() == 0)return false;
        return true;
    }
}
