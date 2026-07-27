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

        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&icon_names=add_2,admin_panel_settings,book,border_color,calendar_clock,campaign,close,delete,group,home,how_to_reg,school,visibility" rel="stylesheet" />
    </head>
    <body>
        <!-- Menu lateral -->
        <jsp:include page="templates/menu.jsp" >
            <jsp:param name="pagina" value="professores" />
        </jsp:include>

        <!-- main -->
        <main>
            <h1>Professores</h1>
            <!-- botao de adicionar (abrira um modal) -->
            <button class="btn-add" id="openModal">
                Novo professor
                <span class="material-symbols-outlined icon-card">add_2</span>
            </button>
            <div class="content">
                <!-- dps, fazer a tabela dinamica com jsp:include -->
                <table class="tabela">
                    <thead>
                        <th>ID</th>
                        <th>Nome</th>
                        <th class="col-cpf">CPF</th>
                        <th>Disciplina</th>
                        <th>E-mail</th>
                        <th>Ações</th>
                    </thead>
                    <tbody>
                        <tr>
                            <td>001</td>
                            <td>Matheus Issler</td>
                            <td class="col-cpf">99999999999</td>
                            <td>Matemática</td>
                            <td>issler@email.com</td>
                            <td class="botoes-acao">
                                <span class="material-symbols-outlined green">border_color</span>
                                <span class="material-symbols-outlined blue">visibility</span>
                                <span class="material-symbols-outlined red">delete</span>
                            </td>
                        </tr>
                        <tr>
                            <td>002</td>
                            <td>Pedro Gabriel</td>
                            <td class="col-cpf">99999999991</td>
                            <td>História</td>
                            <td>pedro@email.com</td>
                            <td class="botoes-acao">
                                <span class="material-symbols-outlined green">border_color</span>
                                <span class="material-symbols-outlined blue">visibility</span>
                                <span class="material-symbols-outlined red">delete</span>
                            </td>
                        </tr>
                        <tr>
                            <td>003</td>
                            <td>João Bastos</td>
                            <td class="col-cpf">99999999992</td>
                            <td>Física</td>
                            <td>joao@email.com</td>
                            <td>
                                <div class="botoes-acao">
                                    <span class="material-symbols-outlined green">border_color</span>
                                    <span class="material-symbols-outlined blue">visibility</span>
                                    <span class="material-symbols-outlined red">delete</span>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </main>

        <!-- modal de criacao de professor -->
        <div class="modal" id="modal">
            <div class="modal-container">
                <div class="modal-header">
                    <h2>Novo professor</h2>
                    <span class="material-symbols-outlined modal-close close">close</span>
                </div>

                <form class="modal-form">

                    <div class="campo">
                        <label for="nome">Nome</label>
                        <input type="text" id="nome" name="nome" maxlength="100" required>
                    </div>

                    <div class="campo">
                        <label for="email">E-mail</label>
                        <input type="email" id="email" name="email" maxlength="150" required>
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
                            <label>Disciplina(s)</label>
                            <div class="checkbox-lista">
                                <!-- opções de disciplina irao vir do back-end -->
                                <label class="checkbox-item">
                                    <input type="checkbox" name="disciplina_id" value="1">
                                    Matemática
                                </label>
                                <label class="checkbox-item">
                                    <input type="checkbox" name="disciplina_id" value="2">
                                    História
                                </label>
                                <label class="checkbox-item">
                                    <input type="checkbox" name="disciplina_id" value="3">
                                    Física
                                </label>
                                <label class="checkbox-item">
                                    <input type="checkbox" name="disciplina_id" value="4">
                                    Geografia
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn-cancelar close">Cancelar</button>
                        <button type="submit" class="btn-salvar" id="confirm">Salvar</button>
                    </div>

                </form>
            </div>
        </div>

        <script>
            const modal = document.getElementById("modal");
            const openBtn = document.getElementById("openModal");
            const confirmBtn = document.getElementById("confirm");

            openBtn.addEventListener("click", () => {
                modal.style.display = "flex";
            });

            document.querySelectorAll(".close").forEach(btn => {
                btn.addEventListener("click", () => {
                    modal.style.display = "none";
                });
            });

            confirmBtn.addEventListener("click", () => {
                alert("Professor cadastrado!");
                modal.style.display = "none";
            });

            // fechar ao clicar fora do modal
            modal.addEventListener("click", (event) => {
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            });

            function apenasNumeros(campo, tamanhoMax) {
                campo.addEventListener("input", () => {
                    campo.value = campo.value.replace(/\D/g, "").slice(0, tamanhoMax);
                });
            }

            apenasNumeros(document.getElementById("telefone"), 11);
            apenasNumeros(document.getElementById("cpf"), 11);
        </script>
    </body>
</html>
