<%@page import="controllers.DisciplinaController"%>
<%@page import="models.Disciplina"%>
<%@page import="java.util.stream.Collectors "%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.List"%>
<%@page import="controllers.ProfessorController"%>
<%@page import="models.Professor"%>
<%@page import="java.util.LinkedHashSet"%>

<%
    ProfessorController professorController = new ProfessorController();
    DisciplinaController disciplinaController = new DisciplinaController();
    LinkedHashSet<Professor> professores = professorController.getAll();
    
    // se existe um parametro 'q' de pesquisa
    if(request.getParameter("q") != null && !request.getParameter("q").isBlank()){
        // limpa a busca que buscou todos
        professores.clear();
        
        // coloca os professores buscados pelo nome
        professores = professorController.getAllByQuery(request.getParameter("q"));
    }

    // verifica se veio dps de clicar no botao do formulario
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String acao = request.getParameter("acao");
        
        // para excluir professor verificamos se a acao é deletar e tentamos deletar
        if("deletar".equals(acao)){
            try{
                int professorId = Integer.parseInt(request.getParameter("professor_id"));
                
                // enviamos para a funcao de deletar no controller
                boolean deletado = professorController.delete(professorId);
                // se nao conseguiu deletar, apenas retorna para a mesma pagina
                if(!deletado){
                    return;
                }
                
                // se conseguiu deletar, manda a mensagem que foi deletado
                session.setAttribute("sucesso", "Professor deletado com sucesso!");
                response.sendRedirect("professores.jsp");
                return;
            } catch (Exception e){
                return;
            }
        }
        
        
        // pega campos para cadastrar ou editar professor
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String telefone = request.getParameter("telefone");
        String dataNascimento = request.getParameter("data_nascimento");
        String[] disciplinasIds = request.getParameterValues("disciplina_id");
        String professorId = request.getParameter("professor_id");

        // validacao simples (se os campos nao estao nulos, e se cpf e telefone possuem 11 caracteres)
        if ((nome == null || nome.isBlank())
                || (cpf == null || cpf.isBlank() || cpf.length() != 11)
                || (telefone == null || telefone.isBlank() || telefone.length() != 11)
                || (dataNascimento == null || dataNascimento.isBlank())
                || (disciplinasIds == null || disciplinasIds.length == 0)) 
        {
            session.setAttribute("erro", "Por favor, preencha os campos corretamente.");
            
            // salvar inputs para mostrar ainda com os valores depois do erro
            session.setAttribute("form_nome", nome);
            session.setAttribute("form_cpf", cpf);
            session.setAttribute("form_telefone", telefone);
            session.setAttribute("form_data_nascimento", dataNascimento);
            session.setAttribute("form_disciplinas", disciplinasIds);
            
            response.sendRedirect("professores.jsp");
            return;
        }
        
        List<Integer> listDisciplinasIds = Arrays.stream(disciplinasIds)
            .map(id -> Integer.parseInt(id))
            .collect(Collectors.toList());

        try{
            // verifica se é edicao ou criacao
            if(professorId != null && !professorId.isBlank()){
                // editar
                professorController.update(
                    Integer.parseInt(professorId),
                    nome,
                    cpf,
                    telefone,
                    dataNascimento,
                    new HashSet<Integer>(listDisciplinasIds)
                );
                
                session.setAttribute("sucesso", "Professor atualizado com sucesso!");
            } else{
                // criar
                professorController.save(
                    nome,
                    cpf,
                    telefone,
                    dataNascimento,
                    new HashSet<Integer>(listDisciplinasIds)
                );
                
                session.setAttribute("sucesso", "Professor cadastrado com sucesso!");
            }
            
        } catch(Exception e){
            session.setAttribute("erro", e.getMessage());
            
            // salvar inputs 
            session.setAttribute("form_nome", nome);
            session.setAttribute("form_cpf", cpf);
            session.setAttribute("form_telefone", telefone);
            session.setAttribute("form_data_nascimento", dataNascimento);
            session.setAttribute("form_disciplinas", disciplinasIds);
            
            response.sendRedirect("professores.jsp");
            return;
        }

        response.sendRedirect("professores.jsp");
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
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&icon_names=add_2,admin_panel_settings,book,border_color,calendar_clock,calendar_month,campaign,close,delete,event_note,group,groups,home,how_to_reg,keyboard_arrow_right,menu_book,school,visibility" rel="stylesheet" />
    </head>
    <body>
        <!-- Menu lateral -->
        <jsp:include page="templates/menu.jsp" >
            <jsp:param name="pagina" value="professores" />
        </jsp:include>

        <!-- main -->
        <main>
            <h1>Professores</h1>
            
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
            
            
            
            <div style="display: flex; align-items: center; justify-content: space-around;">
                <!-- barra de pesquisa -->
                <div class="barra-pesquisa">
                    <form method="GET" action="professores.jsp">
                        <input type="text" name="q" placeholder="Pesquisar por nome" value="<%= request.getParameter("q") != null ? request.getParameter("q") : "" %>">

                        <button type="submit">
                            <span class="material-symbols-outlined">search</span>
                            Pesquisar
                        </button>
                    </form>
                </div>
                
                <!-- botao de adicionar (abrira um modal) -->
                <button class="btn-add" id="openModal">
                    Novo professor
                    <span class="material-symbols-outlined icon-card">add_2</span>
                </button>
            </div>
            
            
            
            <div class="content">
                <!-- dps, fazer a tabela dinamica com jsp:include -->
                <table class="tabela">
                    <thead>
                        <th>ID</th>
                        <th>Nome</th>
                        <th class="col-contato">Contato</th>
                        <th>E-mail</th>
                        <th>Ações</th>
                    </thead>
                    <tbody>
                        <%
                            // para cada professor procurado, cria uma linha na tabela
                            for (Professor professor : professores) {
                        %>
                        <tr>
                            <td><%= professor.getId() %></td>
                            <td><%= professor.getUsuario().getNome()%></td>
                            <td class="col-contato"><%= professor.getUsuario().getTelefone() %></td>
                            <td><%= professor.getUsuario().getEmail() %></td>
                            <td class="botoes-acao">
                                
                                <!-- botao para editar professor, enviando dados do professor atual para a funcao de abrir o modal -->
                                <button style="background: none; border: none; padding: 0;" class="btn-editar" 
                                        onclick="abrirModalEdicao(
                                            <%= professor.getId() %>,
                                            '<%= professor.getUsuario().getNome() %>',
                                            '<%= professor.getUsuario().getCpf() %>',
                                            '<%= professor.getUsuario().getTelefone() %>',
                                            '<%= professor.getUsuario().getDataNascimento() %>',
                                            [
                                                <%= professor.getDisciplinas().stream()
                                                    .map(d -> String.valueOf(d.getId()))
                                                    .collect(Collectors.joining(",")) %>
                                            ]
                                        )"
                                >
                                    <span class="material-symbols-outlined green">border_color</span>
                                </button>
                                                    
                                <!-- botao para ver aluno -->
                                <a href="professor.jsp?id=<%= professor.getId() %>"><span class="material-symbols-outlined blue">visibility</span></a>
                                
                                <!-- form/botao para excluir professor -->
                                <form method="POST" action="professores.jsp" style="margin: 0; display: inline;">
                                    <input type="hidden" name="acao" value="deletar">
                                    <input type="hidden" name="professor_id" value="<%= professor.getId() %>">
                                    
                                    <button type="submit" style="background: none; border: none; padding: 0;">
                                        <span class="material-symbols-outlined red">delete</span>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </main>

                                    
                                    
        <!-- modal de criacao e edicao de professor -->
        <div class="modal" id="modal">
            <div class="modal-container">
                <div class="modal-header">
                    <h2 id="modal-titulo">Novo professor</h2>
                    <span class="material-symbols-outlined modal-close close">close</span>
                </div>

                <form id="modal-form" method="POST" action="professores.jsp">

                    <!-- campo oculto com id do professor (apenas para edicao) -->
                    <input type="hidden" name="professor_id" id="professor_id" value="">
                    
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

                    <div class="linha" style="align-items: start">
                        
                        <div class="campo">
                            <label>Disciplina(s)</label>
                            <div class="checkbox-lista">
                                <%
                                    LinkedHashSet<Disciplina> disciplinas = disciplinaController.getAll();
                                    
                                    String[] disciplinasSelecionadas = (String[]) session.getAttribute("form_disciplinas");
                                    List<String> disciplinasMarcadas = disciplinasSelecionadas != null ? Arrays.asList(disciplinasSelecionadas) : List.of();
                                    
                                    for (Disciplina disciplina : disciplinas) {
                                %>
                                    <label class="checkbox-item">
                                        <input
                                            type="checkbox"
                                            name="disciplina_id"
                                            value="<%= disciplina.getId() %>"
                                            <%= disciplinasMarcadas.contains(String.valueOf(disciplina.getId())) ? "checked" : "" %>>
                                        <%= disciplina.getNome() %>
                                    </label>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        
                        <div class="campo">
                            <label for="data_nascimento">Data de nascimento</label>
                            <input type="date" id="data_nascimento" name="data_nascimento" value="<%= session.getAttribute("form_data_nascimento") != null ? session.getAttribute("form_data_nascimento") : "" %>" required>
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

        
        
        <script src="js/modalProfessor.js"></script>
        
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
                session.removeAttribute("form_disciplinas");
            } 
        %>
    </body>
</html>
