<%@page import="controllers.AlunoController"%>
<%@page import="controllers.TurmaController"%>
<%@page import="models.Aluno"%>
<%@page import="models.Turma"%>
<%@page import="java.util.LinkedHashSet"%>

<%
    AlunoController alunoController = new AlunoController();
    TurmaController turmaController = new TurmaController();

    // verifica se veio dps de clicar no botao do formulario
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String acao = request.getParameter("acao");
        
        // para excluir aluno verificamos se a acao é deletar e tentamos deletar
        if("deletar".equals(acao)){
            try{
                int alunoId = Integer.parseInt(request.getParameter("aluno_id"));
                
                // enviamos para a funcao de deletar no controller
                boolean deletado = alunoController.delete(alunoId);
                // se nao conseguiu deletar, apenas retorna para a mesma pagina
                if(!deletado){
                    return;
                }
                
                // se conseguiu deletar, manda a mensagem que foi deletado
                session.setAttribute("sucesso", "Aluno deletado com sucesso!");
                response.sendRedirect("alunos.jsp");
                return;
            } catch (Exception e){
                return;
            }
        }
        
        
        // pega campos para cadastrar ou editar aluno
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String telefone = request.getParameter("telefone");
        String dataNascimento = request.getParameter("data_nascimento");
        String turmaId = request.getParameter("turma_id");
        String alunoId = request.getParameter("aluno_id");

        // validacao simples (se os campos nao estao nulos, e se cpf e telefone possuem 11 caracteres)
        if ((nome == null || nome.isBlank())
                || (cpf == null || cpf.isBlank() || cpf.length() != 11)
                || (telefone == null || telefone.isBlank() || telefone.length() != 11)
                || (dataNascimento == null || dataNascimento.isBlank())
                || (turmaId == null || turmaId.isBlank())) 
        {
            session.setAttribute("erro", "Por favor, preencha os campos corretamente.");
            
            // salvar inputs para mostrar ainda com os valores depois do erro
            session.setAttribute("form_nome", nome);
            session.setAttribute("form_cpf", cpf);
            session.setAttribute("form_telefone", telefone);
            session.setAttribute("form_data_nascimento", dataNascimento);
            session.setAttribute("form_turma", turmaId);
            
            response.sendRedirect("alunos.jsp");
            return;
        }

        try{
            // verifica se é edicao ou criacao
            if(alunoId != null && !alunoId.isBlank()){
                // editar
                alunoController.update(
                    Integer.parseInt(alunoId),
                    nome,
                    cpf,
                    telefone,
                    dataNascimento,
                    Integer.parseInt(turmaId)
                );
                
                session.setAttribute("sucesso", "Aluno atualizado com sucesso!");
            } else{
                // criar
                alunoController.save(
                    nome,
                    cpf,
                    telefone,
                    dataNascimento,
                    Integer.parseInt(turmaId)
                );
                
                session.setAttribute("sucesso", "Aluno cadastrado com sucesso!");
            }
            
        } catch(Exception e){
            session.setAttribute("erro", e.getMessage());
            
            // salvar inputs 
            session.setAttribute("form_nome", nome);
            session.setAttribute("form_cpf", cpf);
            session.setAttribute("form_telefone", telefone);
            session.setAttribute("form_data_nascimento", dataNascimento);
            session.setAttribute("form_turma", turmaId);
            
            response.sendRedirect("alunos.jsp");
            return;
        }

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
            
            <!-- verifica se existe mensagem de sucesso para mostrar na tela -->
            <% if(session.getAttribute("sucesso") != null) { %>
            <div class="sucesso" id="mensagem-sucesso">
                    <p><%= session.getAttribute("sucesso") %></p>
                </div>
                
                <script>
                    setTimeout(function() {
                        var msg = document.getElementById('mensagem-sucesso');
                        if (msg) {
                            msg.style.display = 'none';
                        }
                    }, 4000);
                </script>
                
            <%
                    session.removeAttribute("sucesso");
                }
            %>

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
                                <!-- botao para editar aluno, enviando dados do aluno atual para a funcao de abrir o modal -->
                                <button style="background: none; border: none; padding: 0;" class="btn-editar" onclick="abrirModalEdicao(<%= aluno.getId() %>, '<%= aluno.getUsuario().getNome() %>', '<%= aluno.getUsuario().getCpf() %>', '<%= aluno.getUsuario().getTelefone() %>', '<%= aluno.getUsuario().getDataNascimento() %>', <%= aluno.getTurma().getId() %>)">
                                    <span class="material-symbols-outlined green">border_color</span>
                                </button>
                                
                                <!-- botao para ver aluno -->
                                <a href="aluno.jsp?id=<%= aluno.getId() %>"><span class="material-symbols-outlined blue">visibility</span></a>
                                
                                <!-- form/botao para excluir aluno -->
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



        <!-- modal de criacao e edicao de aluno -->
        <div class="modal" id="modal">
            <div class="modal-container">
                <div class="modal-header">
                    <h2 id="modal-titulo">Novo aluno</h2>
                    <span class="material-symbols-outlined modal-close close">close</span>
                </div>

                <form id="modal-form" method="POST" action="alunos.jsp">

                    <!-- campo oculto com id do aluno (apenas para edicao) -->
                    <input type="hidden" name="aluno_id" id="aluno_id" value="">
                    
                    <div class="campo">
                        <label for="nome">Nome</label>
                        <input type="text" name="nome" id="nome" maxlength="100" value="<%= session.getAttribute("form_nome") != null ? session.getAttribute("form_nome") : "" %>" required>
                    </div>

                    <div class="linha">
                        <div class="campo">
                            <label for="telefone">Telefone</label>
                            <input type="text" name="telefone" id="telefone" maxlength="11" minlength="11" placeholder="Somente números" value="<%= session.getAttribute("form_telefone") != null ? session.getAttribute("form_telefone") : "" %>" required>
                        </div>

                        <div class="campo">
                            <label for="cpf">CPF</label>
                            <input type="text" name="cpf" id="cpf" maxlength="11" minlength="11" placeholder="Somente números" value="<%= session.getAttribute("form_cpf") != null ? session.getAttribute("form_cpf") : "" %>" required>
                        </div>
                    </div>

                    <div class="linha">
                        <div class="campo">
                            <label for="data_nascimento">Data de nascimento</label>
                            <input type="date" id="data_nascimento" name="data_nascimento" value="<%= session.getAttribute("form_data_nascimento") != null ? session.getAttribute("form_data_nascimento") : "" %>" required>
                        </div>

                        <div class="campo">
                            <label for="turma">Turma</label>
                            <select name="turma_id" id="turma" required>
                                <option selected disabled>Selecione</option>
                                <!-- opções de turmas que estao no banco -->
                                <%
                                    String turmaSelecionada = String.valueOf(session.getAttribute("form_turma"));
                                    
                                    LinkedHashSet<Turma> turmas = turmaController.getAll();
                                    for (Turma turma : turmas) {
                                %>

                                <option value="<%= turma.getId() %>" <%= String.valueOf(turma.getId()).equals(turmaSelecionada) ? "selected" : "" %> >
                                    <%= turma.getSala() %>
                                </option>

                                <% } %>

                            </select>
                        </div>
                    </div>

                    <!-- mensagem de erro do formulario -->
                    <span class="error" id="erro-message"></span>

                    <div class="modal-footer">
                        <button type="button" class="btn-cancelar close">Cancelar</button>
                        <button type="submit" class="btn-salvar" id="confirm">Salvar</button>
                    </div>

                </form>
            </div>
        </div>

                    
                    
        <script src="js/modalAluno.js"></script>
        
        <!-- verifica se tem mensagem de erro para abrir o modal ao carregar a pagina -->
        <% if (session.getAttribute("erro") != null) { %>
        <script>
            document.getElementById("erro-message").textContent =
                "<%= session.getAttribute("erro") %>";
            document.getElementById("modal").style.display = "flex";
        </script>
        <%
                session.removeAttribute("erro");
                session.removeAttribute("form_nome");
                session.removeAttribute("form_cpf");
                session.removeAttribute("form_telefone");
                session.removeAttribute("form_data_nascimento");
                session.removeAttribute("form_turma");
            } 
        %>
    </body>
</html>