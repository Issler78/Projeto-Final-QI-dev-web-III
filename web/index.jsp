<%@page import="controllers.UsuarioController"%>
<%@page import="models.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // verifica se veio do formulario enviado
    if(request.getMethod().equalsIgnoreCase("POST")){
        UsuarioController controller = new UsuarioController();
        
        Usuario usuario = controller.login(request.getParameter("email"), request.getParameter("senha"));
        if(usuario != null){
            // adicionar na sessao o usuario
            session.setAttribute("usuario", usuario);
            
            response.sendRedirect("home.jsp");
            return;
        } else {
            // definir mensagem de erro para mostrar na tela
            session.setAttribute("mensagem", "E-mail ou senha inválidos.");
            
            response.sendRedirect("index.jsp");
            return;
        }
    }
%>



<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sistema Escolar</title>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/login.css">

        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&icon_names=add_2,admin_panel_settings,book,border_color,calendar_clock,calendar_month,campaign,close,delete,event_note,group,groups,home,how_to_reg,keyboard_arrow_right,menu_book,school,visibility" rel="stylesheet" />
    </head>
    <body>
        <div class="login-container">
            <div class="login-header">
                <span class="material-symbols-outlined">school</span>
                <h1>ERP Escolar</h1>
            </div>

            <form class="login-form" action="index.jsp" method="POST">

                <!-- campos do formulario / tela de login -->
                <div class="campo">
                    <label for="email">E-mail</label>
                    <input type="email" name="email" required>
                </div>

                <div class="campo">
                    <label for="senha">Senha</label>
                    <input type="password" name="senha" required>
                </div>
                
                
                <!-- verifica se existe uma mensagem de erro na sessao, e mostra se houver -->
                <% if(session.getAttribute("mensagem") != null) { %>
                    <span class="error"><%= session.getAttribute("mensagem").toString() %></span>
                <%
                    session.removeAttribute("mensagem");
                    }
                %>

                <button type="submit" class="btn-entrar">Entrar</button>
            </form>
        </div>
    </body>
</html>
