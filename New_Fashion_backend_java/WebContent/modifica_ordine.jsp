<%@page import="java.sql.ResultSet"%>
<%@page import="sito.new_fashion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Fashion - modifica ordine</title>
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
                String prezzo_tot = request.getParameter("prezzo");
                String met_pagamento = request.getParameter("pagamento");
                String spedizione = request.getParameter("spedizione");
                                                
                if((spedizione != null) && (prezzo_tot != "") && (met_pagamento != "") && (spedizione != "")) {
                    float p = Float.parseFloat(prezzo_tot);
                    boolean flag = dbConnection.aggiorna_ordine(codice,p,met_pagamento,spedizione);
                    if(flag)
                        response.sendRedirect("ordini.jsp");
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
                <h3><strong>Modifica ordine</strong></h3><br>
                <h3>Codice ordine:   <% out.println(codice); %></h3>
                <%
                ResultSet ordine = dbConnection.getOrdine(codice);
                for (ordine.beforeFirst(); ordine.next();) {
                    out.println("<h3>Prezzo totale:</h3>");
                    out.println("<input name=\"prezzo\" type=\"text\" size=\"40\" maxlength=\"30\" value=\""+ordine.getString("prezzo_totale")+"\" />");
                    out.println("<h3>Metodo di pagamento:</h3>");
                    out.println("<select name=\"pagamento\">");
                    out.println("<option>"+ordine.getString("metodo_di_pagamento")+"</option><option>Carta di credito</option><option>Contrassegno</option><option>Paypal</option></select>");
                    out.println("<h3>Codice spedizione:</h3>");
                    out.println("<input name=\"spedizione\" type=\"text\" size=\"40\" maxlength=\"30\" value=\""+ordine.getString("codice_spedizione")+"\" />");
                    out.println("<h3>Email acquirente:   "+ordine.getString("email")+"</h3>");
                }
                %>
                <br><br><input type="submit" value="Aggiorna" class="bottone"/>
            </form>
        </div>
    </body>
</html>
