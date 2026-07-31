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
                            <th>Série</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>303</td>
                            <td>3º Ano</td>
                            <td class="botoes-acao">
                                <span class="material-symbols-outlined green">border_color</span>
                                <span class="material-symbols-outlined blue">visibility</span>
                                <span class="material-symbols-outlined red">delete</span>
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>201</td>
                            <td>2º Ano</td>
                            <td class="botoes-acao">
                                <span class="material-symbols-outlined green">border_color</span>
                                <span class="material-symbols-outlined blue">visibility</span>
                                <span class="material-symbols-outlined red">delete</span>
                            </td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>103</td>
                            <td>1º Ano</td>
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



        <!-- modal de criacao de turma -->
        <div class="modal" id="modal">
            <div class="modal-container">
                <div class="modal-header">
                    <h2>Nova turma</h2>
                    <span class="material-symbols-outlined modal-close close">close</span>
                </div>

                <form class="modal-form">
                    <div class="linha">
                        <div class="campo">
                            <label for="sala">Sala</label>
                            <input type="text" id="nome" placeholder="Ex: 301" required>
                        </div>

                        <div class="campo">
                            <label for="serie">Ano/Série</label>
                            <select id="serie" required>
                                <option selected disabled>Selecione</option>
                                <option>1º Ano/Série</option>
                                <option>2º Ano/Série</option>
                                <option>3º Ano/Série</option>
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
            confirmBtn.addEventListener("click", () => {
                alert("Turma cadastrada!");
                modal.style.display = "none";
            });
        </script>
    </body>
</html>