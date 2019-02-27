<%@page import="java.sql.ResultSet"%>
<%@page import="sito.new_fashion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Fashion - modifica sfilata</title>
        <style type = "text/css">
        html{
            padding: 10px;
            background: #ddd;
        }
        #container{
            min-height: 1000px;
            background: #fff;
            padding: 5px;
        }
        body{
            margin: 0 auto;
            width: 1500px;
        }
        header{
            height: 120px;
            background: #ff8533;
        }
        #logo{
            position: relative;
            top: 10px;
            left: 20px;
        }
        h2{
            margin: 45px;
            float: right;
        }
        strong{
            text-transform: uppercase;
        }
        #azioni{
            min-height: 1000px;
            width: 150px;
            background: #666;
            padding: 35px;
        }
        #azioni a{
            font-family: Cambria, "Hoefler Text", "Liberation Serif", Times, "Times New Roman", serif;
            text-decoration: none;
            font-size: 26px;
            color: #fff;
            text-transform: uppercase;
        }
        #azioni a:hover{
            text-decoration: underline;
        }
        form {
            font-family: Cambria, "Hoefler Text", "Liberation Serif", Times, "Times New Roman", serif;
            position: absolute;
            top: 200px;
            left: 700px;
        }
        h4{
            font-family: Cambria, "Hoefler Text", "Liberation Serif", Times, "Times New Roman", serif;
            font-size: 20px;
            color: #fff;
        }
        .bottone{
            font-family: Cambria, "Hoefler Text", "Liberation Serif", Times, "Times New Roman", serif;
            padding: 7px 7px;
            font-size: 16px;
            margin: 20px 20px 20px 100px;
        }
        </style>
    </head>
    <body>
        <header>
        <a href="http://localhost:8080/New_Fashion/index.jsp"><img src="logo.png" id="logo" height="100px" alt="logo"></a>
        <h2>Area di amministrazione</h2><br>
        </header>
        <div id="container">
            <div id="azioni">
                <%
                new_fashion dbConnection = new new_fashion();
                
                String data = (String) request.getParameter("data");
                java.sql.Date convertedDate = java.sql.Date.valueOf(data);
                String luogo = (String) request.getParameter("luogo");
                String data_nuova = (String) request.getParameter("data_nuova");
                String luogo_nuovo = (String) request.getParameter("luogo_nuovo");
                String ora = request.getParameter("ora");
                String ora_nuova = request.getParameter("ora_nuova");
                String categoria = request.getParameter("categoria");
                                                
                if((luogo_nuovo != null) && (data_nuova != "") && (ora != "") && (luogo_nuovo != "")) {
                    if(!ora.equals(ora_nuova))
                        ora_nuova = ora_nuova + ":00";
                    java.sql.Time convertedTime = java.sql.Time.valueOf(ora_nuova);
                    java.sql.Date convertedDate_n = java.sql.Date.valueOf(data_nuova);
                    boolean flag = dbConnection.aggiorna_sfilata(convertedDate,convertedTime,luogo,categoria,convertedDate_n,luogo_nuovo);
                    if(flag)
                        response.sendRedirect("sfilate.jsp");
                    else {
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Errore, sfilata con la data e luogo già presente nel DB');");
                        out.println("</script>");
                    }
                }
                
                String username = (String) session.getAttribute("username");
                out.println("<h4>Benvenuto "+username+"<br></h4>");
                %>
                <a href="index.jsp">Home</a><br>
                <a href="prodotti.jsp">Prodotti</a><br>
                <a href="ordini.jsp">Ordini</a><br>
                <a href="utenti.jsp">Utenti</a><br>
                <a href="sfilate.jsp">Sfilate</a><br><br>
                <a href="gestione_sessione.jsp">Esci</a><br>
            </div>
            <form method="post" action=""> 
                <h3><strong>Modifica sfilata</strong></h3><br>
                <%                
                ResultSet sfilata = dbConnection.getSfilata(convertedDate,luogo);
                out.println("<input name=\"data\" type=\"hidden\" value=\""+data+"\"/>");
                out.println("<input name=\"luogo\" type=\"hidden\" value=\""+luogo+"\"/>");
                
                for (sfilata.beforeFirst(); sfilata.next();) {
                    java.sql.Date d = java.sql.Date.valueOf(sfilata.getString("data"));
                    ora = sfilata.getString("ora");
                    java.sql.Time t = java.sql.Time.valueOf(ora);
                    out.println("<h3>Data:</h3>");
                    out.println("<input name=\"data_nuova\" type=\"data\" value=\""+d+"\" />");
                    out.println("<h3>Ora:</h3>");
                    out.println("<input name=\"ora_nuova\" type=\"time\" value=\""+t+"\" />");
                    out.println("<input name=\"ora\" type=\"hidden\" value=\""+t+"\"/>");
                    out.println("<h3>Luogo:</h3>");
                    out.println("<input name=\"luogo_nuovo\" type=\"text\" size=\"40\" maxlength=\"50\" value=\""+sfilata.getString("luogo")+"\" />");
                    out.println("<h3>Categoria:</h3>");
                    out.println("<select name=\"categoria\">");
                    out.println("<option>"+sfilata.getString("categoria")+"</option>");
                }
                %>
                
                <option>donna</option><option>sport</option><option>uomo</option>
                </select>
                <br><br><input type="submit" value="Aggiorna" class="bottone"/>
            </form>
        </div>
    </body>
</html>
