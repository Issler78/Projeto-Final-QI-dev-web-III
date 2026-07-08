<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sistema Escolar</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/menu.css">
    <<link rel="stylesheet" href="css/tabela.css"/>

    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&icon_names=add_2,admin_panel_settings,book,border_color,calendar_clock,campaign,delete,group,home,how_to_reg,school,visibility" rel="stylesheet" />
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
        <button class="add-btn">
            Novo aluno
            <span class="material-symbols-outlined icon-card">add_2</span>
        </button>
        
        <div class="content">
             
            <!-- dps, fazer a tabela dinamica com jsp:include -->
            <table class="tabela">
                <thead>
                    <th>ID</th>
                    <th>Nome</th>
                    <th class="col-cpf">CPF</th>
                    <th>Turma</th>
                    <th>Contato</th>
                    <th>Ações</th>
                </thead>
                <tbody>
                    <tr>
                        <td>001</td>
                        <td>Matheus Issler</td>
                        <td class="col-cpf">99999999999</td>
                        <td>301</td>
                        <td>54999999999</td>
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
                        <td>201</td>
                        <td>54999999991</td>
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
                        <td>101</td>
                        <td>54999999992</td>
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
</body>
</html>