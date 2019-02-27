<%@page import="java.sql.ResultSet"%>
<%@page import="sito.new_fashion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Fashion - dettagli prodotti</title>
        <style type = "text/css">
        html{
            padding: 10px;
            background: #ddd;
        }
        #container{
            min-height: 2000px;
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
        .scritte{
            font-family: Cambria, "Hoefler Text", "Liberation Serif", Times, "Times New Roman", serif;
            font-size: 24px;
            margin: 20px;
            position: absolute;
            top: 180px;
            left: 800px;
        }
        strong{
            text-transform: uppercase;
        }
        form{
            font-family: Cambria, "Hoefler Text", "Liberation Serif", Times, "Times New Roman", serif;
            margin: 40px 20px 20px 20px;
        }
        #azioni{
            min-height: 2000px;
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
        table {
            border-collapse: collapse;
            position: absolute;
            left: 750px;
            top: 230px;
        }
        table, th, td {
            border: 1px solid black;
            font-family: Cambria, "Hoefler Text", "Liberation Serif", Times, "Times New Roman", serif;
            font-size: 20px;
            padding: 12px;
            margin: 40px;
        }
        td a{
            color: rgba(215,9,9,1.00);
            text-decoration: none;
        }
        td a:hover{
            text-decoration: underline;
        }
        #red a{
             color: rgba(215,9,9,1.00);
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
                String username = (String) session.getAttribute("username");
                out.println("<h4>Benvenuto "+username+"<br></h4>");

                String codice = (String) request.getParameter("codice");
                %>
                <a href="index.jsp">Home</a><br>
                <a href="prodotti.jsp">Prodotti</a><br>
                <a href="ordini.jsp">Ordini</a><br>
                <a href="utenti.jsp">Utenti</a><br>
                <a href="sfilate.jsp">Sfilate</a><br><br>
                <a href="gestione_sessione.jsp">Esci</a>
            </div>
            <div class="scritte"><% out.println("<a href=\"inserisci_dettaglio.jsp?codice="+codice+"\">Inserisci dettaglio prodotto</a>"); %></div>
            <table>
                <tr>
                  <th>Codice</th>
                  <th>Taglia</th> 
                  <th>Quantità</th> 
                </tr>
                <%
                new_fashion dbConnection = new new_fashion();
                
                ResultSet dettagli = dbConnection.getDettagli(codice);
                for (dettagli.beforeFirst(); dettagli.next();) {
                    out.println("<td>"+dettagli.getString("codice")+"</td><td>"+dettagli.getString("taglia")+"</td><td>"+dettagli.getString("quantita")+"</td>"
                        +"<td id=\"red\"><a href=\"modifica_dettaglio.jsp?codice="+dettagli.getString("codice")+"&taglia="+dettagli.getString("taglia")+"\">modifica</a></td>"
                        +"<td id=\"red\"><a href=\"gestione_query.jsp?id=canc_dettaglio&codice="+dettagli.getString("codice")+"&taglia="+dettagli.getString("taglia")+"\">cancella</a></td></tr>");
                }
                %>
            </table>
        </div>
    </body>
</html>
