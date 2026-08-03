<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&icon_names=add_2,admin_panel_settings,book,border_color,calendar_clock,calendar_month,campaign,close,delete,event_note,group,groups,home,how_to_reg,keyboard_arrow_left,keyboard_arrow_right,logout,menu_book,school,visibility" rel="stylesheet" />
<%
    String pagina = request.getParameter("pagina");
    String subpagina = request.getParameter("subpagina");
%>
<aside class="menu-lateral">
    <div class="linha-header-menu-lateral">
        <form action="logout.jsp" method="POST" style="margin: 0">        
            <button type="submit" style="background:none;border:none;">
                <span class="material-symbols-outlined" title="Sair">logout</span>
            </button>
        </form>
        <h1>ERP Escolar</h1>
    </div>
    <div class="navegacao">
        <ul>
            <li>
                <a href="home.jsp" class='botao-menu <%= "home".equals(pagina) ? "ativo" : ""%>'>
                    <span class="material-symbols-outlined icon-menu">home</span>
                    <span class="texto-botao-menu">Home</span>
                </a>
            </li>
        </ul>

        <hr class="divisoria"/>

        <h1>Navegação</h1>

        <ul>
            <li>
                <a href="alunos.jsp" class='botao-menu <%= "alunos".equals(pagina) ? "ativo" : ""%>'>
                    <span class="material-symbols-outlined icon-menu">group</span>
                    <span class="texto-botao-menu">Alunos</span>
                </a>
            </li>
            <li>
                <a href="professores.jsp" class='botao-menu <%= "professores".equals(pagina) ? "ativo" : ""%>'>
                    <span class="material-symbols-outlined icon-menu">school</span>
                    <span class="texto-botao-menu">Professores</span>
                </a>
            </li>
            <li>
                <a href="admin.jsp" class='botao-menu <%= "admin".equals(pagina) ? "ativo" : ""%>'>
                    <span class="material-symbols-outlined icon-menu">admin_panel_settings</span>
                    <span class="texto-botao-menu">Administração</span>
                </a>
                <% if (subpagina != null && !subpagina.isBlank()) {%>
                <div class="submenu-menu">
                    <span class="material-symbols-outlined submenu-icon">
                        keyboard_arrow_right
                    </span>
                    <span><%= subpagina.toUpperCase()%></span>
                </div>
                <% } %>
            </li>
        </ul>
    </div>
</aside>
