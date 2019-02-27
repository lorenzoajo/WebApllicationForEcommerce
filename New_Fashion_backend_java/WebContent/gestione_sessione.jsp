<%@page import="sito.new_fashion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    new_fashion dbConnection = new new_fashion();
    
    String id = (String) request.getParameter("id");
    if(id!=null){
        String password = (String) request.getParameter("password");
        String result = dbConnection.login(id, password, session);
        if(result == null) {
            session.setAttribute("username", null);
            out.println("<script type=\"text/javascript\">");
            out.println("alert('ID o password errato');");
            out.println("location='index.jsp';");
            out.println("</script>");
        } else {
            session.setAttribute("username", result);
            response.sendRedirect("index.jsp");	
        }
    } else {
        session.removeAttribute("username");
        response.sendRedirect("index.jsp");
    }
%>
