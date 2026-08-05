<%@page import="enums.SerieTurmaEnum"%>
<%@page import="enums.NivelTurmaEnum"%>
<%@page import="controllers.TurmaController"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="models.Turma"%>

<%
    TurmaController turmaController = new TurmaController(); 

    // verifica se veio dps de clicar no botao do formulario
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String acao = request.getParameter("acao");

        // para excluir turma verificamos se a acao é deletar e tentamos deletar
        if ("deletar".equals(acao)) {
            try {
                int turmaId = Integer.parseInt(request.getParameter("turma_id"));

                // enviamos para a funcao de deletar no controller
                boolean deletado = turmaController.delete(turmaId);

                // se nao conseguiu deletar, apenas retorna para a mesma pagina
                if (!deletado) {
                    session.setAttribute("sucesso", "Não é possível deletar a turma, pois existem alunos nela!");
                    response.sendRedirect("turmas.jsp");
                    return;
                }

                // se conseguiu deletar, manda a mensagem que foi deletado
                session.setAttribute("sucesso", "Turma deletada com sucesso!");
                response.sendRedirect("turmas.jsp");
                return;

            } catch (Exception e) {
                return;
            }
        }

        // pega campos para cadastrar ou editar turma
        String turmaId = request.getParameter("turma_id");
        String sala = request.getParameter("sala");
        String nivel = request.getParameter("nivel");
        String serie = request.getParameter("serie");

        // validacao simples (se os campos nao estao nulos)
        if (sala == null || sala.isBlank()
                || nivel == null || nivel.isBlank()
                || serie == null || serie.isBlank()) {

            session.setAttribute("erro", "Por favor, preencha os campos corretamente.");

            // salvar inputs para mostrar ainda com os valores depois do erro
            session.setAttribute("form_sala", sala);
            session.setAttribute("form_nivel", nivel);
            session.setAttribute("form_serie", serie);

            response.sendRedirect("turmas.jsp");
            return;
        }

        try {
            // verifica se é edicao ou criacao
            if (turmaId != null && !turmaId.isBlank()) {
                // editar
                turmaController.update(
                        Integer.parseInt(turmaId),
                        sala,
                        NivelTurmaEnum.valueOf(nivel),
                        SerieTurmaEnum.valueOf(serie)
                );

                session.setAttribute("sucesso", "Turma atualizada com sucesso!");

            } else {

                // criação
                turmaController.save(
                        sala,
                        NivelTurmaEnum.valueOf(nivel),
                        SerieTurmaEnum.valueOf(serie)
                );

                session.setAttribute("sucesso", "Turma cadastrada com sucesso!");
            }

        } catch (Exception e) {

            session.setAttribute("erro", e.getMessage());

            session.setAttribute("form_sala", sala);
            session.setAttribute("form_nivel", nivel);
            session.setAttribute("form_serie", serie);

            response.sendRedirect("turmas.jsp");
            return;
        }

        response.sendRedirect("turmas.jsp");
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
        <link rel="stylesheet" href="css/tabela.css">
        <link rel="stylesheet" href="css/modal.css">
        <link rel="stylesheet" href="css/admin.css">
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&icon_names=add_2,admin_panel_settings,book,border_color,calendar_clock,calendar_month,campaign,close,delete,event_note,group,groups,home,how_to_reg,keyboard_arrow_left,keyboard_arrow_right,menu_book,school,visibility" rel="stylesheet" />
    </head>
    <body>
        <!-- Menu lateral -->
        <jsp:include page="templates/menu.jsp" >
            <jsp:param name="pagina" value="admin" />
            <jsp:param name="subpagina" value="turmas" />
        </jsp:include>

        <!-- main -->
        <main>

            <div class="submenu-header">
                <a href="admin.jsp" title="Voltar">
                    <span class="material-symbols-outlined">keyboard_arrow_left</span>
                </a>
                <h1>Turmas</h1>
            </div>
            
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

            <button class="btn-add" id="openModal">
                Nova turma
                <span class="material-symbols-outlined icon-card">add_2</span>
            </button>

            <div class="content">
                <table class="tabela">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Sala</th>
                            <th>Nível</th>
                            <th>Série</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            LinkedHashSet<Turma> turmas = turmaController.getAll();
                            for (Turma turma : turmas) {
                        %>

                        <tr>
                            <td><%= turma.getId() %></td>
                            <td><%= turma.getSala() %></td>
                            <td><%= turma.getNivel().getvalor() %></td>
                            <td><%= turma.getSerie().getvalor() %></td>

                            <td class="botoes-acao">
                                <!-- botao para editar aluno, enviando dados da turma atual para a funcao de abrir o modal -->
                                <button style="background: none; border: none; padding: 0;" onclick="abrirModalEdicao(<%= turma.getId() %>, '<%= turma.getSala() %>', '<%= turma.getNivel().name() %>','<%= turma.getSerie().name() %>')">
                                    <span class="material-symbols-outlined green">
                                        border_color
                                    </span>
                                </button>

                                <!-- botao para ver turma -->
                                <a href="turma.jsp?id=<%= turma.getId() %>"><span class="material-symbols-outlined blue">visibility</span></a>

                                <!-- form/botao para excluir turma -->
                                <form method="POST" action="turmas.jsp" style="margin:0; display:inline;">
                                    <input type="hidden" name="acao" value="deletar">
                                    <input type="hidden" name="turma_id" value="<%= turma.getId() %>">

                                    <button type="submit" style="background:none; border:none; padding:0;">
                                        <span class="material-symbols-outlined red">
                                            delete
                                        </span>
                                    </button>
                                </form>
                            </td>
                        </tr>

                        <% } %>
                    </tbody>
                </table>
            </div>
        </main>



        <!-- modal de criação e edição de turma -->
        <div class="modal" id="modal">
            <div class="modal-container">
                <div class="modal-header">
                    <h2 id="modal-titulo">Nova turma</h2>
                    <span class="material-symbols-outlined modal-close close">close</span>
                </div>

                <form id="modal-form" method="POST" action="turmas.jsp">

                    <!-- campo oculto com id da turma (apenas para edicao) -->
                    <input type="hidden" name="turma_id" id="turma_id" value="">

                    <div class="linha">
                        <div class="campo">
                            <label for="sala">Sala</label>
                            <input type="text" name="sala" id="sala" placeholder="Ex: 301A" maxlength="5" value="<%= session.getAttribute("form_sala") != null ? session.getAttribute("form_sala") : "" %>" required>
                        </div>

                        <div class="campo">
                            <label for="nivel">Nível</label>
                            <select name="nivel" id="nivel" required>
                                <option value="" disabled <%= session.getAttribute("form_nivel") == null ? "selected" : "" %> >Selecione</option>
                                <!-- opções de niveis que estao no nivel turma enum -->
                                <% for (NivelTurmaEnum nivel : NivelTurmaEnum.values()) { %>
                                    <option value="<%= nivel.name() %>" <%= nivel.name().equals(String.valueOf(session.getAttribute("form_nivel"))) ? "selected" : "" %> >
                                        <%= nivel.getvalor()%>
                                    </option>
                                <% } %>
                            </select>
                        </div>
                    </div>

                    <div class="campo">
                        <label for="serie">Série</label>
                        <select name="serie" id="serie" required>
                            <option value="" disabled <%= session.getAttribute("form_serie") == null ? "selected" : "" %> >Selecione</option>
                            <!-- opções de turmas que estao no banco -->
                            <% for (SerieTurmaEnum serie : SerieTurmaEnum.values()) { %>
                                <option value="<%= serie.name() %>" <%= serie.name().equals(String.valueOf(session.getAttribute("form_serie"))) ? "selected" : "" %>>
                                    <%= serie.getvalor()%>
                                </option>
                            <% } %>

                        </select>
                    </div>

                    <!-- mensagem de erro -->
                    <span class="error" id="erro-message"></span>

                    <div class="modal-footer">
                        <button type="button" class="btn-cancelar close">
                            Cancelar
                        </button>

                        <button type="submit" class="btn-salvar">
                            Salvar
                        </button>
                    </div>

                </form>
            </div>
        </div>
                    
                    

        <script src="js/modalTurma.js"></script>
        <!-- verifica se tem mensagem de erro para abrir o modal ao carregar a pagina -->
        <% if (session.getAttribute("erro") != null) { %>
        <script>
            document.getElementById("erro-message").textContent =
                "<%= session.getAttribute("erro") %>";
            document.getElementById("modal").style.display = "flex";
        </script>
        <%
                session.removeAttribute("erro");
                session.removeAttribute("form_sala");
                session.removeAttribute("form_nivel");
                session.removeAttribute("form_serie");
            } 
        %>
    </body>
</html>