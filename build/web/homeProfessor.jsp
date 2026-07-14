<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sistema Escolar</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/menu.css">
    <link rel="stylesheet" href="css/cards.css">

    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&icon_names=add_2,admin_panel_settings,book,calendar_clock,campaign,done_all,group,home,how_to_reg,school" rel="stylesheet" />
</head>
<body>
    <!-- Menu lateral -->
    <jsp:include page="templates/menuProfessor.jsp">
        <jsp:param name="pagina" value="home" />
    </jsp:include>



    <!-- conteudo da pagina -->
    <main>
        <h1>Visão Geral</h1>

        <div class="content">
            <div class="principal">
                <div class="cards-pequenos">
                    <div class="card-pequeno card">
                        <h3 class="titulo-card">Alunos ativos</h3>
                        <div>
                            <span class="material-symbols-outlined icon-card green">how_to_reg</span>
                            <span class="texto-card-pequeno green">42</span>
                        </div>
                    </div>
                    <div class="card-pequeno card">
                        <h3 class="titulo-card">Turmas ativas</h3>
                        <div>
                            <span class="material-symbols-outlined icon-card green">book</span>
                            <span class="texto-card-pequeno green">3</span>
                        </div>
                    </div>
                    <div class="card-pequeno card">
                        <h3 class="titulo-card">Professores</h3>
                        <div>
                            <span class="material-symbols-outlined icon-card blue">school</span>
                            <span class="texto-card-pequeno blue">6</span>
                        </div>
                    </div>
                </div>

            </div>



            <!-- outros cards coluna mais a direita -->
            <div class="outros-cards">
                <div class="card-medio card">
                    <div>
                        <div class="header-card-medio">
                            <h3 class="titulo-card">Avisos gerais</h3>
                            <span class="material-symbols-outlined icon-card red">campaign</span>
                        </div>
                        <hr class="divisoria">
                        <ul class="lista-card-medio">
                            <!-- Pegar do back-end e fazer um for para cada aviso presente no banco -->
                            <li>Reunião 28/08 será online</li>
                            <li>Entrega de notas até 02/09</li>
                            <li>Mandar relatório de frequência dos alunos na semana</li>
                        </ul>
                    </div>
                </div>

                <div class="card-medio card">
                    <div>
                        <div class="header-card-medio">
                            <h3 class="titulo-card">Agenda</h3>
                            <span class="material-symbols-outlined icon-card green">calendar_clock</span>
                        </div>
                        <hr class="divisoria">
                        <ul class="lista-card-medio">
                            <!-- Pegar do back-end e fazer um for para cada aviso presente no banco -->
                            <li>Reunião 28/08</li>
                            <li>Intervalo estendido dia 26/08</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
</html>