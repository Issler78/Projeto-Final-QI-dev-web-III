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
                <h1>Agendas</h1>
            </div>

            <button class="btn-add" id="openModal">
                Novo horário
                <span class="material-symbols-outlined icon-card">add_2</span>
            </button>

            <div class="content">
                <table class="tabela">
                    <thead>
                        <tr>
                            <th>Turma</th>
                            <th>Dia</th>
                            <th>Período</th>
                            <th>Professor</th>
                            <th>Disciplina</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>303</td>
                            <td>Segunda</td>
                            <td>1º Período</td>
                            <td>Matheus Issler</td>
                            <td>Matemática</td>
                            <td class="botoes-acao">
                                <span class="material-symbols-outlined green">border_color</span>
                                <span class="material-symbols-outlined red">delete</span>
                            </td>
                        </tr>
                        <tr>
                            <td>303</td>
                            <td>Segunda</td>
                            <td>2º Período</td>
                            <td>Matheus Issler</td>
                            <td>Matemática</td>
                            <td class="botoes-acao">
                                <span class="material-symbols-outlined green">border_color</span>
                                <span class="material-symbols-outlined red">delete</span>
                            </td>
                        </tr>
                        <tr>
                            <td>303</td>
                            <td>Segunda</td>
                            <td>3º Período</td>
                            <td>João Bastos</td>
                            <td>Física</td>
                            <td class="botoes-acao">
                                <span class="material-symbols-outlined green">border_color</span>
                                <span class="material-symbols-outlined red">delete</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </main>



        <!-- modal de criacao de agenda -->
        <div class="modal" id="modal">
            <div class="modal-container">

                <div class="modal-header">
                    <h2>Novo horário</h2>

                    <span class="material-symbols-outlined modal-close close">close</span>
                </div>

                <form class="modal-form">
                    <div class="campo">
                        <label for="turma">Turma</label>
                        <select id="turma" required>
                            <!-- turmas virao do banco-->
                            <option selected disabled>Selecione</option>
                            <option value="">303</option>
                            <option value="">201</option>
                            <option value="">102</option>
                        </select>
                    </div>

                    <div class="linha">
                        <div class="campo">
                            <label for="dia">Dia da semana</label>
                            <select id="dia" required>
                                <option selected disabled>Selecione</option>
                                <option>Segunda</option>
                                <option>Terça</option>
                                <option>Quarta</option>
                                <option>Quinta</option>
                                <option>Sexta</option>
                            </select>
                        </div>

                        <div class="campo">
                            <label for="periodo">Período</label>
                            <select id="periodo" required>
                                <!-- periodos virao do banco -->
                                <option selected disabled>Selecione</option>
                                <option value="">1º Período</option>
                                <option value="">2º Período</option>
                                <option value="">3º Período</option>
                            </select>
                        </div>

                    </div>

                    <div class="linha">

                        <div class="campo">
                            <label for="professor">Professor</label>

                            <select id="professor" required>
                                <!-- professores virao do banco -->
                                <option selected disabled>Selecione</option>
                                <option value="">Matheus Issler</option>
                                <option value="">João Bastos</option>
                                <option value="">Fulano</option>
                            </select>
                        </div>
                        
                        <div class="campo">
                            <label for="disciplina">Disciplina</label>
                            <select id="disciplina" required>
                                <!-- disciplinas virao do banco (LEMBRAR DE VIR APENAS AS QUE O PROFESSOR SELECIONADO POSSUI) -->
                                <option selected disabled>Selecione</option>
                                <option value="">Matemática</option>
                                <option value="">Geografia</option>
                                <option value="">Física</option>
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
                alert("Horário cadastrado!");
                modal.style.display = "none";
            });
        </script>
    </body>
</html>