<%@page import="java.sql.ResultSet"%>
<%@page import="sito.new_fashion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Fashion - inserisci dettaglio</title>
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
                
                String codice = request.getParameter("codice");
                String taglia = request.getParameter("taglia");
                String quantita = request.getParameter("quantita");
                
                if((taglia != null) && (codice != "") && (taglia != "") && (quantita != "")) {
                    int c = Integer.parseInt(codice);
                    int q = Integer.parseInt(quantita);
                    boolean flag = dbConnection.inserisci_dettaglio(c,taglia,q);
                    if(flag)
                        response.sendRedirect("dettagli.jsp?codice="+codice+"");
                    else {
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Errore, taglia di questo prodotto già presente nel DB');");
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
                <h3><strong>Inserisci dettaglio prodotto</strong></h3><br>
                <h3>Codice prodotto:  <% out.println(codice); %></h3>
                <% out.println("<input name=\"codice\" type=\"hidden\" value=\""+codice+"\"/>"); %>
                <h3>Taglia:</h3>
                <input name="taglia" type="text" size="40" maxlength="50" />
                <h3>Quantita:</h3>
                <input name="quantita" type="text" size="40" maxlength="50" />
                <br><br><input type="submit" value="Inserisci" class="bottone"/>
            </form>
        </div>
    </body>
</html>
