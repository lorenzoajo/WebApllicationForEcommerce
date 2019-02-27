<%@page import="java.sql.ResultSet"%>
<%@page import="sito.new_fashion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Fashion - sfilate</title>
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
            left: 600px;
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
            <div class="scritte"><a href="inserisci_sfilata.jsp">Inserisci sfilata</a></div>
            <table>
                <tr>
                  <th>Data</th>
                  <th>Ora</th> 
                  <th>Luogo</th> 
                  <th>Categoria</th>
                </tr>
                <%
                new_fashion dbConnection = new new_fashion();
                ResultSet sfilate = dbConnection.getSfilate();
                for (sfilate.beforeFirst(); sfilate.next();) {
                    out.println("<td>"+sfilate.getString("data")+"</td><td>"+sfilate.getString("ora")+"</td><td>"
                        +sfilate.getString("luogo")+"</td><td>"+sfilate.getString("categoria")
                        +"</td><td><a href=\"modifica_sfilata.jsp?data="+sfilate.getString("data")+"&luogo="+sfilate.getString("luogo")+"\">modifica</a></td>"
                        +"<td><a href=\"gestione_query.jsp?id=canc_sfilata&data="+sfilate.getString("data")+"&luogo="+sfilate.getString("luogo")+"\">cancella</a></td></tr>");
                }
                %>
            </table>
        </div>
    </body>
</html>
