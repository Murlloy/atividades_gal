<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.ResultSet" %>
<%@ page import="java.util.regex.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        
        <%
    String mensagem = "";
    boolean sucesso = false;

    // Verifica se o formulário foi enviado
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String placa = request.getParameter("placa").toUpperCase().trim();

        // Regex para validar formato da placa (antigo ou Mercosul)
        String regex = "^[A-Z]{3}-?[0-9]{4}$|^[A-Z]{3}[0-9][A-Z][0-9]{2}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(placa);

        if (matcher.matches()) {
            // caso deu certo, entra aqui e copula a tabela.

            sucesso = true;
            mensagem = "✅ Placa cadastrada com sucesso!";
        } else {
            mensagem = "❌ Placa inválida. Tente novamente.";
        }
    }
%>
        
        <%
            try {
                //Fazer a conexão com o banco de dados
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/sistema";
                String user = "root";
                String password = "admin";
                conecta = DriverManager.getConnection(url, user, password);
                //Listar os dados da tabela produto do banco de dados
                String sql = ("SELECT numero FROM vagas WHERE status_vagas = 'disponivel'  ");
                st = conecta.prepareStatement(sql);
                ResultSet rs = st.executeQuery();
                //Enquanto não chegar no final ele vai executar
                //o que estiver dentro do while
                
                


        %>

        <form action="" method="post">
            <input type="text" name="placa">
            <input type="datetime-local" name="data_hora_entrada">
            <input type="datetime-local" name="data_hora_saida">
            <select id="id">
                <option value="first">Vagas</option>
                <%             while (rs.next()) {
                %>
                <option value="value">  <%=rs.getString("numero")%></option>
                <%
                    }
                %>
            </select>

            <button type="submit">Entrar</button>
        </form>
        <!-- Finalizei o codigo java acima agora vou criar o corpo da tabela html para
        mostrar os dados trazidos do Banco de dados-->
    </table>
    <%
        } catch (Exception x) {
            out.print("Mensagem de erro: " + x.getMessage());
        }
    %>
   
    
    
<% if (!mensagem.isEmpty()) { %>
    <p style="color: <%= sucesso ? "green" : "red" %>;">
        <%= mensagem %>
    </p>
<% } %>
</body>
</html>
