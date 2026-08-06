<%@page import="models.Professor"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="models.Disciplina"%>
<%@page import="controllers.DisciplinaController"%>

<%
    DisciplinaController disciplinaController = new DisciplinaController();

    Disciplina disciplina = disciplinaController.getById(Integer.parseInt(request.getParameter("id")));
%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Detalhes - <%= disciplina.getNome()%></title>

        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/menu.css">
        <link rel="stylesheet" href="css/detalhes.css">
    </head>

    <body>

        <!-- Menu lateral -->
        <jsp:include page="templates/menu.jsp">
            <jsp:param name="pagina" value="admin"/>
            <jsp:param name="subpagina" value="disciplinas"/>
        </jsp:include>

        <!-- main -->
        <main>
            <div class="submenu-header">
                <a href="disciplinas.jsp" title="Voltar">
                    <span class="material-symbols-outlined">keyboard_arrow_left</span>
                </a>
                <h1>Detalhes da disciplina <%= disciplina.getNome()%></h1>
            </div>

            <div class="detalhes">
                <div class="secao">
                    <h3 class="secao-titulo">Informações da disciplina</h3>
                    <div class="campos">
                        
                        <div class="campo-item">
                            <label>ID</label>
                            <p class="campo-valor"><%= disciplina.getId()%></p>
                        </div>

                        <div class="campo-item">
                            <label>Nome</label>
                            <p class="campo-valor"><%= disciplina.getNome()%></p>
                        </div>

                    </div>
                </div>


                <div class="secao">
                    <h3 class="secao-titulo">Professores de <%= disciplina.getNome().toLowerCase() %>:</h3>

                    <!-- fazemos uma verificacao se existe professores para tal disciplina, se sim, listamos eles, se nao, colocamos a mensagem de nenhum professor -->
                    <div class="campos">
                        <%
                            LinkedHashSet<Professor> professores = disciplinaController.getAllProfessoresByDisciplina(Integer.parseInt(request.getParameter("id")));

                            if (professores == null || professores.isEmpty()) {
                        %>

                        <div class="campo-item">
                            <label>Professores</label>
                            <p class="campo-valor">Nenhum professor para essa disciplina.</p>
                        </div>

                        <%
                            } else {
                                for (Professor professor : professores) {
                        %>

                        <div class="campo-item">
                            <label>Professor</label>
                            <p class="campo-valor">
                                <%= professor.getUsuario().getNome()%>
                            </p>
                        </div>

                        <%
                                }
                            }
                        %>
                    </div>
                </div>
                        
            </div>
        </main>
    </body>
</html>