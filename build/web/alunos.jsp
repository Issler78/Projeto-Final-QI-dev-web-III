<%@page import="controllers.AlunoController"%>
<%@page import="controllers.TurmaController"%>
<%@page import="models.Aluno"%>
<%@page import="models.Turma"%>
<%@page import="java.util.Set"%>

<%
    AlunoController alunoController = new AlunoController();
    TurmaController turmaController = new TurmaController();
%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="pt-br">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sistema Escolar</title>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/menu.css">
        <link rel="stylesheet" href="css/tabela.css"/>
        <link rel="stylesheet" href="css/modal.css">
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&icon_names=add_2,admin_panel_settings,book,border_color,calendar_clock,calendar_month,campaign,close,delete,event_note,group,groups,home,how_to_reg,keyboard_arrow_right,menu_book,school,visibility" rel="stylesheet" />
    </head>
    <body>
        <!-- Menu lateral -->
        <jsp:include page="templates/menu.jsp" >
            <jsp:param name="pagina" value="alunos" />
        </jsp:include>

        <!-- main -->
        <main>
            <h1>Alunos</h1>

            <!-- botao de adicionar (abrira um modal) -->
            <button class="btn-add" id="openModal">
                Novo aluno
                <span class="material-symbols-outlined icon-card">add_2</span>
            </button>

            <div class="content">

                <table class="tabela">
                    <thead>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>E-mail</th>
                        <th>Turma</th>
                        <th class="col-contato">Contato</th>
                        <th>Ações</th>
                    </thead>
                    <tbody>
                        <%
                            Set<Aluno> alunos = alunoController.getAll();
                            for(Aluno aluno : alunos){
                        %>
                        
                        <tr>
                            <td><%= aluno.getId() %></td>
                            <td><%= aluno.getUsuario().getNome() %></td>
                            <td><%= aluno.getUsuario().getEmail() %></td>
                            <td><%= aluno.getTurma().getSala() %></td>
                            <td class="col-contato"><%= aluno.getUsuario().getTelefone() %></td>
                            <td class="botoes-acao">
                                <span class="material-symbols-outlined green">border_color</span>
                                <span class="material-symbols-outlined blue">visibility</span>
                                <span class="material-symbols-outlined red">delete</span>
                            </td>
                        </tr>
                        
                        <% } %>
                        
                        
                    </tbody>
                </table>
            </div>
        </main>



        <!-- modal de criacao de aluno -->
        <div class="modal" id="modal">
            <div class="modal-container">
                <div class="modal-header">
                    <h2>Novo aluno</h2>
                    <span class="material-symbols-outlined modal-close close">close</span>
                </div>

                <form class="modal-form">

                    <div class="campo">
                        <label for="nome">Nome</label>
                        <input type="text" id="nome" name="nome" maxlength="100" required>
                    </div>

                    <div class="linha">
                        <div class="campo">
                            <label for="telefone">Telefone</label>
                            <input type="text" id="telefone" name="telefone" maxlength="11" placeholder="Somente números" required>
                        </div>

                        <div class="campo">
                            <label for="cpf">CPF</label>
                            <input type="text" id="cpf" name="cpf" maxlength="11" placeholder="Somente números" required>
                        </div>
                    </div>

                    <div class="linha">
                        <div class="campo">
                            <label for="data_nascimento">Data de nascimento</label>
                            <input type="date" id="data_nascimento" name="data_nascimento" required>
                        </div>

                        <div class="campo">
                            <label for="turma">Turma</label>
                            <select id="turma" name="turma_id" required>
                                <option value="" selected disabled>Selecione</option>
                                <!-- opções de turmas que estao no banco -->
                                <%
                                    Set<Turma> turmas = turmaController.getAll();
                                    for(Turma turma : turmas){
                                %>
                                
                                <option value=<%= turma.getId() %> ><%= turma.getSala() %></option>
                                
                                <% } %>
                                
                            </select>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn-cancelar close">Cancelar</button>
                        <button type="submit" class="btn-salvar" id="confirm">Salvar</button>
                    </div>

                </form>
            </div>
        </div>

        <script src="js/modal.js"></script>
        <script>
            const confirmBtn = document.getElementById("confirm");

            confirmBtn.addEventListener("click", () => {
                alert("Aluno cadastrado!");
                modal.style.display = "none";
            });
        </script>
    </body>
</html>