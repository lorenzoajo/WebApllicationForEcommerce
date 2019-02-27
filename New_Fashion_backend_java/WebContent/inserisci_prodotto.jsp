<%@page import="java.sql.ResultSet"%>
<%@page import="sito.new_fashion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Fashion - inserisci prodotto</title>
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
                                                
                if((codice != null) && (codice != "") && (nome != "") && (colore != "") && (prezzo != "") && (immagine != "") && !categoria.equals("Scegli..")) {
                    int c = Integer.parseInt(codice);
                    float p = Float.parseFloat(prezzo);
                    boolean flag = dbConnection.inserisci_prodotto(c,nome,colore,p,immagine,categoria);
                    if(flag)
                        response.sendRedirect("prodotti.jsp");
                    else {
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Errore, codice prodotto già presente nel DB');");
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
                <h3><strong>Inserisci prodotto</strong></h3><br>
                <h3>Codice prodotto:</h3>
                <input name="codice" type="text" size="40" maxlength="30" />
                <h3>Nome:</h3>
                <input name="nome" type="text" size="40" maxlength="50" />
                <h3>Colore:</h3>
                <input name="colore" type="text" size="40" maxlength="50" />
                <h3>Prezzo:</h3>
                <input name="prezzo" type="text" size="40" maxlength="30" />
                <h3>Nome immagine (con .jpg):</h3>
                <input name="img" type="text" size="40" maxlength="30" />
                <h3>Categoria:</h3>
                <select name="categoria">
                <option>Scegli..</option><option>donna</option><option>sport</option><option>uomo</option>
                </select>
                <br><br><input type="submit" value="Inserisci" class="bottone"/>
            </form>
        </div>
    </body>
</html>
