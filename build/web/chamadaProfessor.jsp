<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Marcar Presença</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/menu.css">
    <link rel="stylesheet" href="css/tabela.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&icon_names=add_2,admin_panel_settings,book,calendar_clock,campaign,done_all,group,home,how_to_reg,school" rel="stylesheet" />
</head>
<body>
    <!-- Menu lateral -->
    <jsp:include page="templates/menuProfessor.jsp">
        <jsp:param name="pagina" value="chamada" />
    </jsp:include>

    <!-- conteudo da pagina -->
    <main>
        <h1>Marcar Presença</h1>

        <div class="content">
            <div class="card card-tabela">
                <div class="header-card">
                    <h3 class="titulo-card">Registrar presença da turma</h3>
                    <span class="material-symbols-outlined icon-card blue">done_all</span>
                </div>

                <div class="filtros">
                    <div class="filtro">
                        <label>Turma</label>
                        <select>
                            <option value="101">101</option>
                            <option value="201">201</option>
                            <option value="301">301</option>
                        </select>
                    </div>

                    <div class="filtro">
                        <label>Data</label>
                        <input type="date">
                    </div>
                    
                    <div class="filtro">
                        <label>Período</label>
                        <select>
                            <option value="1">1º</option>
                            <option value="2">2º</option>
                            <option value="3">3º</option>
                            <option value="4">4º</option>
                            <option value="5">5º</option>
                            <option value="6">6º</option>
                        </select>
                    </div>
                </div>

                <form action="#" method="POST" class="formulario-tabela">
                    <table class="tabela">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Presente</th>
                                <th>Falta</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>001</td>
                                <td>Matheus Issler</td>
                                <td><input type="radio" value="presente"></td>
                                <td><input type="radio" value="falta"></td>
                            </tr>
                            <tr>
                                <td>002</td>
                                <td>Pedro Gabriel</td>
                                <td><input type="radio" value="presente"></td>
                                <td><input type="radio" value="falta"></td>
                            </tr>
                            <tr>
                                <td>003</td>
                                <td>João Bastos</td>
                                <td><input type="radio" value="presente"></td>
                                <td><input type="radio" value="falta"></td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="botoes">
                        <button type="submit" class="botao botao-confirmar">Salvar</button>
                        <button type="reset" class="botao botao-cancelar">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>
    </main>
</body>
</html>
