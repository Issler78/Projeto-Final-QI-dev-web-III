<%@page import="java.util.LinkedHashSet"%>
<%@page import="models.Disciplina"%>
<%@page import="models.Professor"%>
<%@page import="controllers.ProfessorController"%>
<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<%
    ProfessorController professorController = new ProfessorController();
    
    Professor professor = professorController.getById(Integer.parseInt(request.getParameter("id")));
%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Detalhes - <%= professor.getUsuario().getNome() %></title>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/menu.css">
        <link rel="stylesheet" href="css/detalhes.css">
    </head>
    <body>
        <!-- Menu lateral -->
        <jsp:include page="templates/menu.jsp" >
            <jsp:param name="pagina" value="professores" />
        </jsp:include>

        <!-- main -->
        <main>
            <div class="submenu-header">
                <a href="professores.jsp" title="Voltar">
                    <span class="material-symbols-outlined">keyboard_arrow_left</span>
                </a>
                <h1>Detalhes do(a) professor(a) <%= professor.getUsuario().getNome() %></h1>
            </div>

            <div class="detalhes">
                <div class="secao">
                    <h3 class="secao-titulo">Informações pessoais</h3>
                    <div class="campos">
                        <div class="campo-item">
                            <label>ID</label>
                            <p class="campo-valor"><%= professor.getId() %></p>
                        </div>

                        <div class="campo-item">
                            <label>Nome</label>
                            <p class="campo-valor"><%= professor.getUsuario().getNome() %></p>
                        </div>

                        <div class="campo-item">
                            <label>E-mail</label>
                            <p class="campo-valor"><%= professor.getUsuario().getEmail() %></p>
                        </div>

                        <div class="campo-item">
                            <label>Telefone</label>
                            <p class="campo-valor">
                                <%= String.format("(%s) %s-%s", 
                                        professor.getUsuario().getTelefone().substring(0, 2),
                                        professor.getUsuario().getTelefone().substring(2, 7),
                                        professor.getUsuario().getTelefone().substring(7, 11)
                                    )
                                %>
                            </p>
                        </div>

                        <div class="campo-item">
                            <label>CPF</label>
                            <p class="campo-valor">
                                <%= String.format("%s.%s.%s-%s", 
                                        professor.getUsuario().getCpf().substring(0, 3),
                                        professor.getUsuario().getCpf().substring(3, 6),
                                        professor.getUsuario().getCpf().substring(6, 9),
                                        professor.getUsuario().getCpf().substring(9, 11)
                                    )
                                %>
                            </p>
                        </div>

                        <div class="campo-item">
                            <label>Data de nascimento</label>
                            <p class="campo-valor"><%= professor.getUsuario().getDataNascimento().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %></p>
                        </div>
                        
                        <div class="campo-item">
                            <label>Idade</label>
                            <p class="campo-valor">
                                <%= Period.between(professor.getUsuario().getDataNascimento(), LocalDate.now()).getYears() %>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="secao">
                    <h3 class="secao-titulo">Disciplinas</h3>
                    
                    <%
                            LinkedHashSet<Disciplina> disciplinas = professorController.getAllDisciplinasByProfessorId(professor.getId());
                            
                            for (Disciplina disciplina : disciplinas) {
                    %>
                    <div class="campos">
                        <div class="campo-item">
                            <p class="campo-valor">
                                <%= disciplina.getNome() %>
                            </p>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </main>
    </body>
</html>
