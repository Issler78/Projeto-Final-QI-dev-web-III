<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String pagina = request.getParameter("pagina");
%>
<aside class="menu-lateral">
    <h1>ERP Escolar</h1>
    <div class="navegacao">
        <ul>
            <li>
                <a href="index.jsp" class='botao-menu <%= "home".equals(pagina) ? "ativo" : "" %>'>
                    <span class="material-symbols-outlined icon-menu">home</span>
                    <span class="texto-botao-menu">Home</span>
                </a>
            </li>
        </ul>

        <hr class="divisoria"/>

        <h1>Navegação</h1>

        <ul>
            <li>
                <a href="alunos.jsp" class='botao-menu <%= "alunos".equals(pagina) ? "ativo" : "" %>'>
                    <span class="material-symbols-outlined icon-menu">group</span>
                    <span class="texto-botao-menu">Alunos</span>
                </a>
            </li>
            <li>
                <a href="professores.jsp" class='botao-menu <%= "professores".equals(pagina) ? "ativo" : "" %>'>
                    <span class="material-symbols-outlined icon-menu">school</span>
                    <span class="texto-botao-menu">Professores</span>
                </a>
            </li>
            <li>
                <a href="admin.jsp" class='botao-menu <%= "admin".equals(pagina) ? "ativo" : "" %>'>
                    <span class="material-symbols-outlined icon-menu">admin_panel_settings</span>
                    <span class="texto-botao-menu">Administrador</span>
                </a>
            </li>
        </ul>
    </div>
</aside>
