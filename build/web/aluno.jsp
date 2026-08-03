<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="models.Aluno"%>
<%@page import="controllers.AlunoController"%>
<%
    AlunoController alunoController = new AlunoController();
    
    Aluno aluno = alunoController.getById(Integer.parseInt(request.getParameter("id")));
%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Detalhes - <%= aluno.getUsuario().getNome() %></title>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/menu.css">
        <link rel="stylesheet" href="css/detalhes.css">
    </head>
    <body>
        <!-- Menu lateral -->
        <jsp:include page="templates/menu.jsp" >
            <jsp:param name="pagina" value="alunos" />
        </jsp:include>

        <!-- main -->
        <main>
            <div class="submenu-header">
                <a href="alunos.jsp" title="Voltar">
                    <span class="material-symbols-outlined">keyboard_arrow_left</span>
                </a>
                <h1>Detalhes do(a) aluno(a) <%= aluno.getUsuario().getNome() %></h1>
            </div>

            <div class="detalhes">
                <div class="secao">
                    <h3 class="secao-titulo">Informações pessoais</h3>
                    <div class="campos">
                        <div class="campo-item">
                            <label>ID</label>
                            <p class="campo-valor"><%= aluno.getId() %></p>
                        </div>

                        <div class="campo-item">
                            <label>Nome</label>
                            <p class="campo-valor"><%= aluno.getUsuario().getNome() %></p>
                        </div>

                        <div class="campo-item">
                            <label>E-mail</label>
                            <p class="campo-valor"><%= aluno.getUsuario().getEmail() %></p>
                        </div>

                        <div class="campo-item">
                            <label>Telefone</label>
                            <p class="campo-valor">
                                <%= String.format("(%s) %s-%s", 
                                        aluno.getUsuario().getTelefone().substring(0, 2),
                                        aluno.getUsuario().getTelefone().substring(2, 7),
                                        aluno.getUsuario().getTelefone().substring(7, 11)
                                    )
                                %>
                            </p>
                        </div>

                        <div class="campo-item">
                            <label>CPF</label>
                            <p class="campo-valor">
                                <%= String.format("%s.%s.%s-%s", 
                                        aluno.getUsuario().getCpf().substring(0, 3),
                                        aluno.getUsuario().getCpf().substring(3, 6),
                                        aluno.getUsuario().getCpf().substring(6, 9),
                                        aluno.getUsuario().getCpf().substring(9, 11)
                                    )
                                %>
                            </p>
                        </div>

                        <div class="campo-item">
                            <label>Data de nascimento</label>
                            <p class="campo-valor"><%= aluno.getUsuario().getDataNascimento().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %></p>
                        </div>
                        
                        <div class="campo-item">
                            <label>Idade</label>
                            <p class="campo-valor">
                                <%= Period.between(aluno.getUsuario().getDataNascimento(), LocalDate.now()).getYears() %>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="secao">
                    <h3 class="secao-titulo">Outras Informações</h3>
                    <div class="campos">
                        <div class="campo-item">
                            <label>Turma</label>
                            <p class="campo-valor"><%= aluno.getTurma().getSala() %></p>
                        </div>

                        <div class="campo-item">
                            <label>Série</label>
                            <p class="campo-valor"><%= aluno.getTurma().getSerie().getvalor() %></p>
                        </div>

                        <div class="campo-item">
                            <label>Nível:</label>
                            <p class="campo-valor"><%= aluno.getTurma().getNivel().getvalor() %></p>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </body>
</html>
