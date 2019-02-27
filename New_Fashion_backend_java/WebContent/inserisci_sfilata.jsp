<%@page import="java.sql.ResultSet"%>
<%@page import="sito.new_fashion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Fashion - inserisci sfilata</title>
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
                
                String data = request.getParameter("data");
                String ora = request.getParameter("ora");
                ora = ora + ":00";
                String luogo = request.getParameter("luogo");
                String categoria = request.getParameter("categoria");
                                                
                if((data != null) && (data != "") && (ora != "") && (luogo != "") && !categoria.equals("Scegli..")) {
                    java.sql.Date convertedDate = java.sql.Date.valueOf(data);
                    java.sql.Time convertedTime = java.sql.Time.valueOf(ora);
                    boolean flag = dbConnection.inserisci_sfilata(convertedDate,convertedTime,luogo,categoria);
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
                <h3><strong>Inserisci sfilata</strong></h3><br>
                <h3>Data:</h3>
                <input name="data" type="date" />
                <h3>Ora:</h3>
                <input name="ora" type="time" />
                <h3>Luogo:</h3>
                <input name="luogo" type="text" size="40" maxlength="50" />
                <h3>Categoria:</h3>
                <select name="categoria">
                <option>Scegli..</option><option>donna</option><option>sport</option><option>uomo</option>
                </select>
                <br><br><input type="submit" value="Inserisci" class="bottone"/>
            </form>
        </div>
    </body>
</html>
