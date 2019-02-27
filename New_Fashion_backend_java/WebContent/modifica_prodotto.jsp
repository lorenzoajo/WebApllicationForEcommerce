<%@page import="java.sql.ResultSet"%>
<%@page import="sito.new_fashion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Fashion - modifica prodotto</title>
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
                String nome = request.getParameter("nome");
                String colore = request.getParameter("colore");
                String prezzo = request.getParameter("prezzo");
                String immagine = request.getParameter("img");
                String categoria = request.getParameter("categoria");
                                                
                if((nome != null) && (codice != "") && (nome != "") && (colore != "") && (prezzo != "") && (immagine != "")) {
                    int c = Integer.parseInt(codice);
                    float p = Float.parseFloat(prezzo);
                    boolean flag = dbConnection.aggiorna_prodotto(c,nome,colore,p,immagine,categoria);
                    if(flag)
                        response.sendRedirect("prodotti.jsp");
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
                <h3><strong>Modifica prodotto</strong></h3><br>
                <h3>Codice prodotto:  <% out.println(codice); %></h3>
                <% out.println("<input name=\"codice\" type=\"hidden\" value=\""+codice+"\"/>");
                
                ResultSet prodotto = dbConnection.getProdotto(codice);
                for (prodotto.beforeFirst(); prodotto.next();) {
                    out.println("<h3>Nome:</h3>");
                    out.println("<input name=\"nome\" type=\"text\" size=\"40\" maxlength=\"50\" value=\""+prodotto.getString("nome")+"\" />");
                    out.println("<h3>Colore:</h3>");
                    out.println("<input name=\"colore\" type=\"text\" size=\"40\" maxlength=\"50\" value=\""+prodotto.getString("colore")+"\" />");
                    out.println("<h3>Prezzo:</h3>");
                    out.println("<input name=\"prezzo\" type=\"text\" size=\"40\" maxlength=\"30\" value=\""+prodotto.getString("prezzo")+"\" />");
                    out.println("<h3>Path immagine:</h3>");
                    out.println("<input name=\"img\" type=\"text\" size=\"60\" maxlength=\"80\" value=\""+prodotto.getString("immagine")+"\" />");
                    out.println("<h3>Categoria:</h3>");
                    out.println("<select name=\"categoria\">");
                    out.println("<option>"+prodotto.getString("categoria")+"</option>");
                }
                %>
                
                <option>donna</option><option>sport</option><option>uomo</option>
                </select>
                <br><br><input type="submit" value="Aggiorna" class="bottone"/>
            </form>
        </div>
    </body>
</html>
