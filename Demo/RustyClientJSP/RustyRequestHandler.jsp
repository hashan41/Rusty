<%-- 
    Document   : RustyRequestHandler
    Created on : Apr 9, 2014, 5:48:58 PM
    Author     : hmj
--%>

<%@ page isThreadSafe="true" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="sun.misc.BASE64Decoder"%>
<%@ page import="javax.crypto.Cipher"%>
<%@ page import="javax.crypto.spec.SecretKeySpec"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="java.net.*"%>
<%@ page import="javax.servlet.http.*"%>
<%
    /* ---------------------- Rusty Params Begins ---------------------------  */
    
    //Public Key must match with rusty-config.xml key must have 16 characters
    String encryptionKey = "rustykey12345678";
    String rustyUname = "admin";
    String rustypassword = "admin";
    String wsPath = "http://192.0.0.31/rustyDemo/rest/rustyDemo/";
    
    /* ---------------------- Rusty Params Ends ---------------------------  */
    

    //--------------------Prevent Replay Attack ----------------------
    session.setMaxInactiveInterval(600);
    ArrayList<String> rustyReqHolder = null;
    if (session.getAttribute("Rusty-Request-Mapper") == null) {
        rustyReqHolder = new ArrayList<String>();
        session.setAttribute("Rusty-Request-Mapper", rustyReqHolder);
    } else {
        rustyReqHolder = (ArrayList<String>) session.getAttribute("Rusty-Request-Mapper");
    }
    String reqUUID = request.getParameter("ruid");
    String reqPath = request.getParameter("path");



    //--------------------Prevent Replay Attack ----------------------
    HttpURLConnection conn = null;
    if ((!reqUUID.equals(null) || !reqUUID.equals("")) || (!reqPath.equals(null) || !reqPath.equals(""))) {
        if (rustyReqHolder.indexOf(reqUUID) == -1) {
            //ok for send request
            rustyReqHolder.add(reqUUID);
            String wsReqMethod = request.getMethod();

            try {
                URL url = new URL(wsPath + reqPath);
                conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod(wsReqMethod);
                conn.setRequestProperty("Rusty-Uname", rustyUname);
                conn.setRequestProperty("Rusty-Password", rustypassword);

                Enumeration<String> headerNames = request.getHeaderNames();
                while (headerNames.hasMoreElements()) {
                    String headerName = headerNames.nextElement();
                    Enumeration<String> headers = request.getHeaders(headerName);
                    while (headers.hasMoreElements()) {
                        String headerValue = headers.nextElement();
                        conn.setRequestProperty(headerName, headerValue);
                    }
                }

                if (!wsReqMethod.equals("GET")) {
                    BufferedReader reqPayloadBf = request.getReader();
                    String payloadBuffer;
                    StringBuffer reqsb = new StringBuffer();
                    while ((payloadBuffer = reqPayloadBf.readLine()) != null) {
                        reqsb.append(payloadBuffer);
                    }
                    String reqPayload = reqsb.toString();
                    //System.out.println(" REQUEST PAYLOAD ---------------------- " + reqPayload + " -----------------------");
                    conn.setDoOutput(true);
                    DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
                    wr.writeBytes(reqPayload);
                    wr.flush();
                    wr.close();
                }

                if (conn.getResponseCode() != 200) {
                    response.sendError(conn.getResponseCode(), conn.getResponseMessage());
                }
                BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
                String output;
                StringBuffer sb = new StringBuffer();

                while ((output = br.readLine()) != null) {
                    sb.append(output);
                }
                br.close();
                String data = sb.toString();

                //System.out.println("~~~~~~~~~~~Output from Server No Decryption.... " + data);

                response.setStatus(conn.getResponseCode());
                //System.out.println(conn.getHeaderField("Secured") + "---------------------is secured response");
                if (conn.getHeaderField("Secured").equals("true")) {
                    /* ------------------------------- Decryption Begins------------------------------ */
                    SecretKeySpec keySpec = new SecretKeySpec(encryptionKey.getBytes("UTF-8"), "AES");
                    Cipher cipher = Cipher.getInstance("AES");
                    cipher.init(Cipher.DECRYPT_MODE, keySpec);
                    byte[] encryptedTextBytes = new BASE64Decoder().decodeBuffer(data);
                    byte[] decryptedTextBytes = cipher.doFinal(encryptedTextBytes);
                    data = new String(decryptedTextBytes);
                    /* ------------------------------- Decryption Ends ------------------------------ */
                }
                out.print(data);
                //System.out.println("Print Done........................... flushed.......");
                conn.disconnect();
            } catch (MalformedURLException e) {
                e.printStackTrace();
                //System.out.print("Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr 111111111111111111111111");
                conn.disconnect();
            } catch (IOException e) {
                e.printStackTrace();
                //System.out.print("Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
                conn.disconnect();
            }
        } else {
            response.sendError(304, "Request duplicated");
        }
    } else {
        response.sendError(400, "You FOOL! Please send valid request");
    }

%>