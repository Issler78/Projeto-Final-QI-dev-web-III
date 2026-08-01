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
                        <tr>
                            <td>1</td>
                            <td>Matemática</td>
                            <td class="botoes-acao">
                                <span class="material-symbols-outlined green">border_color</span>
                                <span class="material-symbols-outlined blue">visibility</span>
                                <span class="material-symbols-outlined red">delete</span>
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Português</td>
                            <td class="botoes-acao">
                                <span class="material-symbols-outlined green">border_color</span>
                                <span class="material-symbols-outlined blue">visibility</span>
                                <span class="material-symbols-outlined red">delete</span>
                            </td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>História</td>
                            <td class="botoes-acao">
                                <span class="material-symbols-outlined green">border_color</span>
                                <span class="material-symbols-outlined blue">visibility</span>
                                <span class="material-symbols-outlined red">delete</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </main>



        <!-- modal de criacao de disciplina -->
        <div class="modal" id="modal">

            <div class="modal-container">

                <div class="modal-header">
                    <h2>Nova disciplina</h2>

                    <span class="material-symbols-outlined modal-close close">close</span>
                </div>

                <form class="modal-form">

                    <div class="campo">
                        <label for="nome">Nome</label>
                        <input type="text" id="nome" maxlength="100" required>
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
                alert("Disciplina cadastrada!");
                modal.style.display = "none";
            });
        </script>
    </body>
</html>