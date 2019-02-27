<%@page import="sito.new_fashion"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Fashion - amministrazione</title>
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
            margin: 60px 40px 40px 40px;
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
            <%
            new_fashion dbConnection = new new_fashion();
            String username = (String) session.getAttribute("username");
            if (username == null) {
                out.println("<form id=\"form_accedi\" action=\"gestione_sessione.jsp\" method=\"post\">");
                out.println("<h3><strong>Accedi</strong></h3><br>");
                out.println("<h3>Inserisci il tuo ID:</h3>");
                out.println("<input name=\"id\" type=\"text\" size=\"40\" maxlength=\"200\" />");
                out.println("<h3>Inserisci la password:</h3>");
                out.println("<input name=\"password\" type=\"password\" size=\"40\" maxlength=\"200\" />");
                out.println("<br><br><input type=\"submit\" name=\"submit_accedi\" value=\"Avanti\" class=\"bottone\" /></form>");
            } else {
                out.println("<div id=\"azioni\">");
                out.println("<h4>Benvenuto "+username+"<br></h4>");
                out.println("<a href=\"index.jsp\">Home</a><br>");
                out.println("<a href=\"prodotti.jsp\">Prodotti</a><br>");
                out.println("<a href=\"ordini.jsp\">Ordini</a><br>");
                out.println("<a href=\"utenti.jsp\">Utenti</a><br>");
                out.println("<a href=\"sfilate.jsp\">Sfilate</a><br><br>");
                out.println("<a href=\"gestione_sessione.jsp\">Esci</a>");
                out.println("</div>");
                out.println("<div class=\"scritte\">");
                
		int num = dbConnection.getCount("utenti");
                out.println("Totale utenti registrati: " + num + "<br>");
                
                int num2 = dbConnection.getCount("ordini");
                out.println("Totale ordini effettuati: " + num2 + "<br>");
                
                int num3 = dbConnection.getCount("prodotti");
                out.println("Totale prodotti presenti nel DB: " + num3 + "<br>");
                
                int num4 = dbConnection.getCount("totale");
                out.println("Totale prodotti disponibili nel DB: " + num4 + "</div>");
            }
            %>
        </div>
    </body>
</html>