package sito;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Time;
import javax.servlet.http.HttpSession;



public class new_fashion {
    public Connection dbConnection;

    public new_fashion() throws Exception{
        dbConnection = null;
        String dbms="mysql";
        String serverName="localhost";
        String portNumber="3306";
        String userName="root";
        String password="";
        String databaseName="new_fashion";

        //connectioURL = "jdbc:mysql://localhost:3306/new_fashion"
        String connectionURL = "jdbc:"+ dbms +"://"+ serverName +":"
                        + portNumber +"/"+databaseName;
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        dbConnection = DriverManager.getConnection(connectionURL, userName, password);
    }

    public String login(String id, String password, HttpSession session) {
	try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "SELECT * FROM amministratori WHERE id='"+id+"' AND password='"+password+"'";
            ResultSet rs = stmt.executeQuery(query) ;
            if(rs.last())
		return rs.getString("id");
	} catch(Exception e) {
            System.err.println(e.getMessage());
	}
        return null;
    }

    public int getCount(String x){
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query;
            if(x.equals("totale")) {
                query = "SELECT SUM(quantita) FROM dettagli";
                ResultSet rs = stmt.executeQuery(query);
                if(rs.last())
                    return rs.getInt(1);
            } else {
                query = "SELECT * FROM " + x;
                ResultSet rs = stmt.executeQuery(query);
                if(rs.last())
                    return rs.getRow();
            }
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return 0;
    }

    public ResultSet getSfilate() {
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "SELECT * FROM sfilate";
            return stmt.executeQuery(query);
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return null;
    }

    public ResultSet getSfilata(Date data, String luogo) {
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "SELECT * FROM sfilate WHERE data='"+data+"' AND luogo='"+luogo+"'";
            return stmt.executeQuery(query);
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return null;
    }

    public ResultSet getProdotti() {
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "SELECT * FROM prodotti";
            return stmt.executeQuery(query);
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return null;
    }

    public ResultSet getProdotto(String codice) {
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "SELECT * FROM prodotti WHERE codice_prodotto='"+codice+"'";
            return stmt.executeQuery(query);
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return null;
    }

    public ResultSet getDettagli(String codice) {
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "SELECT * FROM dettagli WHERE codice='"+codice+"'";
            return stmt.executeQuery(query);
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return null;
    }

    public ResultSet getDettaglio(String codice, String taglia) {
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "SELECT * FROM dettagli WHERE codice='"+codice+"' AND taglia='"+taglia+"'";
            return stmt.executeQuery(query);
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return null;
    }

    public ResultSet getUtenti() {
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "SELECT * FROM utenti";
            return stmt.executeQuery(query);
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return null;
    }

    public ResultSet getUtente(String email) {
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "SELECT * FROM utenti WHERE email='"+email+"'";
            return stmt.executeQuery(query);
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return null;
    }

    public ResultSet getOrdini() {
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "SELECT * FROM ordini";
            return stmt.executeQuery(query);
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return null;
    }

    public ResultSet getOrdine(String codice) {
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "SELECT * FROM ordini WHERE codice_ordine='"+codice+"'";
            return stmt.executeQuery(query);
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return null;
    }

    public ResultSet getP_Ordini(String codice) {
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "SELECT * FROM ordini_prodotti WHERE codice_ordine='"+codice+"'";
            return stmt.executeQuery(query);
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return null;
    }

    public boolean cancella_sfilata(Date data, String luogo) {
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "DELETE FROM sfilate WHERE data='"+data+"' AND luogo='"+luogo+"'";
            int res = stmt.executeUpdate(query);
            if(res>0)
                return true;
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return false;
    }

    public boolean cancella_prodotto(int codice) {
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "DELETE FROM prodotti WHERE codice_prodotto='"+codice+"'";
            int res = stmt.executeUpdate(query);
            if(res>0)
                return true;
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return false;
    }

    public boolean cancella_dettaglio(String codice, String taglia) {
        try {
            Statement stmt = this.dbConnection.createStatement();
            String query = "DELETE FROM dettagli WHERE codice='"+codice+"' AND taglia='"+taglia+"'";
            int res = stmt.executeUpdate(query);
            if(res>0)
                return true;
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return false;
    }

    public boolean inserisci_sfilata(Date data,Time ora,String luogo,String categoria) {
        try {
            String query = "INSERT INTO sfilate(data,ora,luogo,categoria) VALUES (?,?,?,?)";
            PreparedStatement stmt = this.dbConnection.prepareStatement(query);
            stmt.setDate(1, data);
            stmt.setTime(2, ora);
            stmt.setString(3, luogo);
            stmt.setString(4, categoria);
            int res = stmt.executeUpdate();
            if(res>0)
                return true;
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return false;
    }

    public boolean aggiorna_sfilata(Date data,Time ora,String luogo,String categoria,Date data_n,String luogo_n) {
        try {
            String query = "UPDATE sfilate SET data=?,ora=?,luogo=?,categoria=? WHERE data=? AND luogo=?";
            PreparedStatement stmt = this.dbConnection.prepareStatement(query);
            stmt.setDate(1, data_n);
            stmt.setTime(2, ora);
            stmt.setString(3, luogo_n);
            stmt.setString(4, categoria);
            stmt.setDate(5, data);
            stmt.setString(6, luogo);
            int res = stmt.executeUpdate();
            if(res>0)
                return true;
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return false;
    }

    public boolean inserisci_prodotto(int codice,String nome,String colore,float prezzo,String immagine,String categoria) {
        try {
            String cat = categoria.substring(0,1).toUpperCase() + categoria.substring(1,categoria.length()).toLowerCase();
            String img = "http://127.0.0.1/New_Fashion/img/" + cat + "/" + immagine;
            String query = "INSERT INTO prodotti(codice_prodotto,nome,colore,prezzo,immagine,categoria) VALUES (?,?,?,?,?,?)";
            PreparedStatement stmt = this.dbConnection.prepareStatement(query);
            stmt.setInt(1, codice);
            stmt.setString(2, nome);
            stmt.setString(3, colore);
            stmt.setFloat(4, prezzo);
            stmt.setString(5, img);
            stmt.setString(6, categoria);
            int res = stmt.executeUpdate();
            if(res>0)
                return true;
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return false;
    }

    public boolean aggiorna_prodotto(int codice,String nome,String colore,float prezzo,String immagine,String categoria) {
        try {
            String query = "UPDATE prodotti SET codice_prodotto=?,nome=?,colore=?,prezzo=?,immagine=?,categoria=? WHERE codice_prodotto=?";
            PreparedStatement stmt = this.dbConnection.prepareStatement(query);
            stmt.setInt(1, codice);
            stmt.setString(2, nome);
            stmt.setString(3, colore);
            stmt.setFloat(4, prezzo);
            stmt.setString(5, immagine);
            stmt.setString(6, categoria);
            stmt.setInt(7, codice);
            int res = stmt.executeUpdate();
            if(res>0)
                return true;
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return false;
    }

    public boolean inserisci_dettaglio(int codice,String taglia,int quantita) {
        try {
            String query = "INSERT INTO dettagli(codice,taglia,quantita,codice_prodotto) VALUES (?,?,?,?)";
            PreparedStatement stmt = this.dbConnection.prepareStatement(query);
            stmt.setInt(1, codice);
            stmt.setString(2, taglia);
            stmt.setInt(3, quantita);
            stmt.setInt(4, codice);
            int res = stmt.executeUpdate();
            if(res>0)
                return true;
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return false;
    }

    public boolean aggiorna_dettaglio(int codice,String taglia,int quantita,String taglia_n) {
        try {
            String query = "UPDATE dettagli SET codice=?,taglia=?,quantita=?,codice_prodotto=? WHERE codice=? AND taglia=?";
            PreparedStatement stmt = this.dbConnection.prepareStatement(query);
            stmt.setInt(1, codice);
            stmt.setString(2, taglia_n);
            stmt.setInt(3, quantita);
            stmt.setInt(4, codice);
            stmt.setInt(5, codice);
            stmt.setString(6, taglia);
            int res = stmt.executeUpdate();
            if(res>0)
                return true;
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return false;
    }

    public boolean aggiorna_utente(String email,String indirizzo,String citta,String nazione) {
        try {
            String query = "UPDATE utenti SET indirizzo=?,citta=?,nazione=? WHERE email=?";
            PreparedStatement stmt = this.dbConnection.prepareStatement(query);
            stmt.setString(1,indirizzo);
            stmt.setString(2, citta);
            stmt.setString(3, nazione);
            stmt.setString(4, email);
            int res = stmt.executeUpdate();
            if(res>0)
                return true;
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return false;
    }

    public boolean aggiorna_ordine(String codice,float prezzo,String pagamento,String spedizione) {
        try {
            String query = "UPDATE ordini SET prezzo_totale=?,metodo_di_pagamento=?,codice_spedizione=? WHERE codice_ordine=?";
            PreparedStatement stmt = this.dbConnection.prepareStatement(query);
            stmt.setFloat(1, prezzo);
            stmt.setString(2, pagamento);
            stmt.setString(3, spedizione);
            stmt.setString(4, codice);
            int res = stmt.executeUpdate();
            if(res>0)
                return true;
        } catch(Exception e) {
            System.err.println(e.getMessage());
        }
        return false;
    }

}
