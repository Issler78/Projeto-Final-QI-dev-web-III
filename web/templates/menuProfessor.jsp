<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String pagina = request.getParameter("pagina");
%>
<aside class="menu-lateral">
    <div class="navegacao">
        <ul>
            <li>
                <a href="homeProfessor.jsp" class='botao-menu <%= "home".equals(pagina) ? "ativo" : "" %>'>
                    <span class="material-symbols-outlined icon-menu">home</span>
                    <span class="texto-botao-menu">Home</span>
                </a>
            </li>
        </ul>

        <hr class="divisoria"/>

        <h1>Navegação</h1>

        <ul>
            <li>
                <a href="alunosProfessor.jsp" class='botao-menu <%= "alunos".equals(pagina) ? "ativo" : "" %>'>
                    <span class="material-symbols-outlined icon-menu">group</span>
                    <span class="texto-botao-menu">Alunos</span>
                </a>
            </li>
            <li>
                <a href="chamadaProfessor.jsp" class='botao-menu <%= "chamada".equals(pagina) ? "ativo" : "" %>'>
                    <span class="material-symbols-outlined icon-menu">school</span>
                    <span class="texto-botao-menu">Chamada</span>
                </a>
            </li>
        </ul>
    </div>
</aside>
