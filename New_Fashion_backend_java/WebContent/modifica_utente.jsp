<%@page import="java.sql.ResultSet"%>
<%@page import="sito.new_fashion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Fashion - modifica utente</title>
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
            background: #ff8533);
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
                
                String email = request.getParameter("email");
                String indirizzo = request.getParameter("indirizzo");
                String citta = request.getParameter("citta");
                String nazione = request.getParameter("nazione");
                                                
                if((indirizzo != null) && (indirizzo != "") && (citta != "") && (nazione != "")) {
                    boolean flag = dbConnection.aggiorna_utente(email,indirizzo,citta,nazione);
                    if(flag)
                        response.sendRedirect("utenti.jsp");
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
                <h3><strong>Modifica utente</strong></h3><br>
                <%
                ResultSet utente = dbConnection.getUtente(email);
                for (utente.beforeFirst(); utente.next();) {
                    out.println("<h3>Nome:   "+utente.getString("nome")+"</h3>");
                    out.println("<h3>Cognome:   "+utente.getString("cognome")+"</h3>");
                    out.println("<h3>Data di nascita:   "+utente.getString("data_di_nascita")+"</h3>");
                    out.println("<h3>Indirizzo:</h3>");
                    out.println("<input name=\"indirizzo\" type=\"text\" size=\"40\" maxlength=\"50\" value=\""+utente.getString("indirizzo")+"\" />");
                    out.println("<h3>Città:</h3>");
                    out.println("<input name=\"citta\" type=\"text\" size=\"40\" maxlength=\"50\" value=\""+utente.getString("citta")+"\" />");
                    out.println("<h3>Nazione:</h3>");
                    out.println("<input name=\"nazione\" type=\"text\" size=\"40\" maxlength=\"50\" value=\""+utente.getString("nazione")+"\" />");
                    out.println("<h3>Email:   "+utente.getString("email")+"</h3>");
                    out.println("<input name=\"email\" type=\"hidden\" value=\""+email+"\"/>");
                    out.println("<h3>Carrello:   "+utente.getString("codice_carrello")+"</h3>");
                }
                %>
                <br><br><input type="submit" value="Aggiorna" class="bottone"/>
            </form>
        </div>
    </body>
</html>
