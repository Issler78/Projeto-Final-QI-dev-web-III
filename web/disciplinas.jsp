    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="controllers.DisciplinaController"%>
    <%@page import="java.util.LinkedHashSet"%>
    <%@page import="models.Disciplina"%>

    <%
        DisciplinaController disciplinaController = new DisciplinaController();

        // verifica se veio depois de clicar no botão do formulário
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String acao = request.getParameter("acao");

            // para excluir turma verificamos se a acao é deletar e tentamos deletar
            if ("deletar".equals(acao)) {
                try {
                    int disciplinaId = Integer.parseInt(request.getParameter("disciplina_id"));

                    // enviamos para a funcao de deletar no controller
                    disciplinaController.delete(disciplinaId);

                    // se conseguiu deletar, manda a mensagem que foi deletado
                    session.setAttribute("sucesso", "Disciplina deletada com sucesso!");
                    response.sendRedirect("disciplinas.jsp");
                    return;

                } catch (Exception e) {
                    session.setAttribute("erro", e.getMessage());
                    response.sendRedirect("disciplinas.jsp");
                    return;
                }
            }

            // pega campos para cadastrar ou editar disciplina
            String disciplinaId = request.getParameter("disciplina_id");
            String nome = request.getParameter("nome");

            // validacao simples (se os campos nao estao nulos)
            if (nome == null || nome.isBlank()) {
                session.setAttribute("erro", "Por favor, preencha o nome da disciplina.");

                // salvar inputs para mostrar ainda com os valores depois do erro
                session.setAttribute("form_nome", nome);

                response.sendRedirect("disciplinas.jsp");
                return;
            }


            try {
                // verifica se é edicao ou criacao
                if (disciplinaId != null && !disciplinaId.isBlank()) {
                    // editar
                    disciplinaController.update(Integer.parseInt(disciplinaId), nome);

                    session.setAttribute("sucesso", "Disciplina atualizada com sucesso!");
                } else {
                    // criar
                    disciplinaController.save(nome);

                    session.setAttribute("sucesso", "Disciplina cadastrada com sucesso!");
                }


            } catch(Exception e) {
                session.setAttribute("erro", "Essa matéria já existe");

                // salvar inputs para mostrar ainda com os valores depois do erro
                session.setAttribute("form_nome", nome);

                response.sendRedirect("disciplinas.jsp");
                return;
            }

            response.sendRedirect("disciplinas.jsp");
            return;
        }
    %>

    <html lang="pt-br">
        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Sistema Escolar</title>
            <link rel="stylesheet" href="css/style.css">
            <link rel="stylesheet" href="css/menu.css">
            <link rel="stylesheet" href="css/tabela.css"/>
            <link rel="stylesheet" href="css/modal.css">
            <link rel="stylesheet" href="css/admin.css">
            <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&icon_names=add_2,admin_panel_settings,book,border_color,calendar_clock,calendar_month,campaign,close,delete,event_note,group,groups,home,how_to_reg,keyboard_arrow_left,keyboard_arrow_right,menu_book,school,visibility" rel="stylesheet" />
        </head>
        <body>
            <!-- Menu lateral -->
            <jsp:include page="templates/menu.jsp" >
                <jsp:param name="pagina" value="admin" />
                <jsp:param name="subpagina" value="disciplinas" />
            </jsp:include>

            <!-- main -->
            <main>

                <div class="submenu-header">
                    <a href="admin.jsp" title="Voltar">
                        <span class="material-symbols-outlined">keyboard_arrow_left</span>
                    </a>
                    <h1>Disciplinas</h1>
                </div>

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



                <button class="btn-add" id="openModal">
                    Nova disciplina
                    <span class="material-symbols-outlined icon-card">add_2</span>
                </button>

                <div class="content">
                    <table class="tabela">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                LinkedHashSet<Disciplina> disciplinas = disciplinaController.getAll();
                                for (Disciplina disciplina : disciplinas) {
                            %>
                            <tr>
                                <td><%= disciplina.getId() %></td>
                                <td><%= disciplina.getNome() %></td>
                                <td class="botoes-acao">

                                    <!-- botao para editar disciplina, enviando dados da turma atual para a funcao de abrir o modal -->
                                    <button style="background: none; border: none; padding: 0;" onclick="abrirModalEdicao(<%= disciplina.getId() %>, '<%= disciplina.getNome()%>')">
                                        <span class="material-symbols-outlined green">
                                            border_color
                                        </span>
                                    </button>

                                     <!-- botao para ver disciplina -->
                                    <a href="disciplina.jsp?id=<%= disciplina.getId() %>"><span class="material-symbols-outlined blue">visibility</span></a>

                                    <!-- form/botao para excluir disciplina -->
                                    <form method="POST" action="disciplinas.jsp" style="margin:0; display:inline;">
                                        <input type="hidden" name="acao" value="deletar">
                                        <input type="hidden" name="disciplina_id" value="<%= disciplina.getId() %>">

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



            <!-- modal de criacao de disciplina -->
            <div class="modal" id="modal">
                <div class="modal-container">
                    <div class="modal-header">
                        <h2 id="modal-titulo">Nova disciplina</h2>
                        <span class="material-symbols-outlined modal-close close">close</span>
                    </div>

                    <form class="modal-form" id="modal-form" method="POST" action="disciplinas.jsp">
                        <!-- campo oculto com id da disciplina (apenas para edicao) -->
                        <input type="hidden" name="disciplina_id" id="disciplina_id" value="">
                        
                        <div class="campo">
                            <label for="nome">Nome</label>
                            <input type="text" name="nome" id="nome" maxlength="100" value="<%= session.getAttribute("form_nome") != null ? session.getAttribute("form_nome") : "" %>" required>
                        </div>
                        
                        <!-- mensagem de erro -->
                        <span class="error" id="erro-message"></span>

                        <div class="modal-footer">
                            <button type="button" class="btn-cancelar close">Cancelar</button>
                            <button type="submit" class="btn-salvar" id="confirm">Salvar</button>
                        </div>
                    </form>
                </div>
            </div>

            <script src="js/modalDisciplina.js"></script>
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
                } 
            %>
        </body>
    </html>