<%@page import="java.sql.ResultSet"%>
<%@page import="sito.new_fashion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Fashion - prodotti acquistati</title>
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
        form{
            font-family: Cambria, "Hoefler Text", "Liberation Serif", Times, "Times New Roman", serif;
            margin: 40px 20px 20px 20px;
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
        table {
            border-collapse: collapse;
            position: absolute;
            left: 700px;
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
                %>
                <a href="index.jsp">Home</a><br>
                <a href="prodotti.jsp">Prodotti</a><br>
                <a href="ordini.jsp">Ordini</a><br>
                <a href="utenti.jsp">Utenti</a><br>
                <a href="sfilate.jsp">Sfilate</a><br><br>
                <a href="gestione_sessione.jsp">Esci</a>
            </div>
            <table>
                <tr>
                  <th>ID ordine</th>
                  <th>ID prodotto</th> 
                  <th>Taglia</th> 
                  <th>Quantità</th>
                </tr>
                <%
                new_fashion dbConnection = new new_fashion();
                
                String codice = (String) request.getParameter("codice");
                ResultSet ordini = dbConnection.getP_Ordini(codice);
                for (ordini.beforeFirst(); ordini.next();) {
                    out.println("<tr><td>"+ordini.getString("codice_ordine")+"</td><td>"+ordini.getString("codice_prodotto")+"</td><td>"
                        +ordini.getString("taglia")+"</td><td>"+ordini.getString("quantita")+"</td></tr>");
                }
                %>
            </table>
        </div>
    </body>
</html>
