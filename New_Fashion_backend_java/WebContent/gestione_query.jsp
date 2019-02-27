<%@page import="sito.new_fashion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    //qui sono presenti tutte le operazioni di cancella
    new_fashion dbConnection = new new_fashion();

    String id = (String) request.getParameter("id");
    if(id.equals("canc_sfilata")) {
        String data = (String) request.getParameter("data");
        java.sql.Date convertedDate = java.sql.Date.valueOf(data);
        String luogo = (String) request.getParameter("luogo");

        boolean result = dbConnection.cancella_sfilata(convertedDate, luogo);
        if(result)
            response.sendRedirect("sfilate.jsp");	
    } else if (id.equals("canc_prodotto")) {
        String codice = (String) request.getParameter("codice");
        int c = Integer.parseInt(codice);
        
        boolean result = dbConnection.cancella_prodotto(c);
        if(result)
            response.sendRedirect("prodotti.jsp");
        else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Assicurati che non ci siamo dipendenze con la tabella dettagli!');");
            out.println("location='dettagli.jsp';");
            out.println("</script>");
        }
    } else if (id.equals("canc_dettaglio")) {
        String codice = (String) request.getParameter("codice");
        String taglia = (String) request.getParameter("taglia");
        
        boolean result = dbConnection.cancella_dettaglio(codice,taglia);
        if(result)
            response.sendRedirect("dettagli.jsp?codice="+codice+"");
    }
%>
