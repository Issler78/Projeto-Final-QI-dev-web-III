<%@page import="controllers.AlunoController"%>
<%@page import="controllers.TurmaController"%>
<%@page import="models.Aluno"%>
<%@page import="models.Turma"%>
<%@page import="java.util.LinkedHashSet"%>

<%
    AlunoController alunoController = new AlunoController();
    TurmaController turmaController = new TurmaController();

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String acao = request.getParameter("acao");
        
        // para excluir aluno
        if("deletar".equals(acao)){
            try{
                int alunoId = Integer.parseInt(request.getParameter("aluno_id"));
                
                boolean deletado = alunoController.delete(alunoId);
                if(!deletado){
                    return;
                }
                
                session.setAttribute("sucesso", "Aluno deletado com sucesso!");
                response.sendRedirect("alunos.jsp");
                return;
            } catch (Exception e){
                return;
            }
        }
        
        
        
        // para cadastrar aluno
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String telefone = request.getParameter("telefone");
        String dataNascimento = request.getParameter("data_nascimento");
        String turmaId = request.getParameter("turma_id");

        // validacao simples
        if ((nome == null || nome.isBlank())
                || (cpf == null || cpf.isBlank() || cpf.length() != 11)
                || (telefone == null || telefone.isBlank() || telefone.length() != 11)
                || (dataNascimento == null || dataNascimento.isBlank())
                || (turmaId == null || turmaId.isBlank())) {
            session.setAttribute("erro", "Por favor, preencha os campos corretamente.");
            response.sendRedirect("alunos.jsp");
            return;
        }

        try{  
            // salva aluno
            alunoController.save(
                    nome,
                    cpf,
                    telefone,
                    dataNascimento,
                    Integer.parseInt(turmaId)
            );
        } catch(Exception e){
            session.setAttribute("erro", e.getMessage());
            response.sendRedirect("alunos.jsp");
            return;
        }

        session.setAttribute("sucesso", "Aluno cadastrado com sucesso!");
        response.sendRedirect("alunos.jsp");
        return;
    }
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
                            LinkedHashSet<Aluno> alunos = alunoController.getAll();
                            for (Aluno aluno : alunos) {
                        %>

                        <tr>
                            <td><%= aluno.getId()%></td>
                            <td><%= aluno.getUsuario().getNome()%></td>
                            <td><%= aluno.getUsuario().getEmail()%></td>
                            <td><%= aluno.getTurma().getSala()%></td>
                            <td class="col-contato"><%= aluno.getUsuario().getTelefone()%></td>
                            <td class="botoes-acao">
                                <span class="material-symbols-outlined green">border_color</span>
                                <span class="material-symbols-outlined blue">visibility</span>
                                
                                <!-- form para mandar excluir aluno -->
                                <form method="POST" action="alunos.jsp" style="margin: 0; display: inline;">
                                    <input type="hidden" name="acao" value="deletar">
                                    <input type="hidden" name="aluno_id" value="<%= aluno.getId() %>">
                                    
                                    <button type="submit" style="background: none; border: none; padding: 0;">
                                        <span class="material-symbols-outlined red">delete</span>
                                    </button>
                                </form>
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

                <form id="modal-form" method="POST" action="alunos.jsp">

                    <div class="campo">
                        <label for="nome">Nome</label>
                        <input type="text" name="nome" id="nome" maxlength="100" required>
                    </div>

                    <div class="linha">
                        <div class="campo">
                            <label for="telefone">Telefone</label>
                            <input type="text" name="telefone" id="telefone" maxlength="11" minlength="11" placeholder="Somente números" required>
                        </div>

                        <div class="campo">
                            <label for="cpf">CPF</label>
                            <input type="text" name="cpf" id="cpf" maxlength="11" minlength="11" placeholder="Somente números" required>
                        </div>
                    </div>

                    <div class="linha">
                        <div class="campo">
                            <label for="data_nascimento">Data de nascimento</label>
                            <input type="date" id="data_nascimento" name="data_nascimento" required>
                        </div>

                        <div class="campo">
                            <label for="turma">Turma</label>
                            <select name="turma_id" id="turma" required>
                                <option value="" selected disabled>Selecione</option>
                                <!-- opções de turmas que estao no banco -->
                                <%
                                    LinkedHashSet<Turma> turmas = turmaController.getAll();
                                    for (Turma turma : turmas) {
                                %>

                                <option value=<%= turma.getId()%> ><%= turma.getSala()%></option>

                                <% } %>

                            </select>
                        </div>
                    </div>

                    <!-- mensagem de erro do formulario -->
                    <% if (session.getAttribute("erro") != null) {%>
                    <span class="error"><%= session.getAttribute("erro")%></span>
                    <% } %>

                    <div class="modal-footer">
                        <button type="button" class="btn-cancelar close">Cancelar</button>
                        <button type="submit" class="btn-salvar" id="confirm">Salvar</button>
                    </div>

                </form>
            </div>
        </div>

                    
                    
        <script src="js/modal.js"></script>
        
        <!-- verifica se tem mensagem de erro para abrir o modal ao carregar a pagina -->
        <% if (session.getAttribute("erro") != null) {%>
        <script>
            document.getElementById("modal").style.display = "flex";
        </script>
        <%     
                session.removeAttribute("erro");
            } 
        %>
    </body>
</html>