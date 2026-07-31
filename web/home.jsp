<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if(session.getAttribute("usuario") == null){
        response.sendRedirect("index.jsp");
    }
%>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sistema Escolar</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/menu.css">
    <link rel="stylesheet" href="css/cards.css">
    <link rel="stylesheet" href="css/grafico.css">

    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&icon_names=add_2,admin_panel_settings,book,border_color,calendar_clock,calendar_month,campaign,close,delete,event_note,group,groups,home,how_to_reg,keyboard_arrow_right,menu_book,school,visibility" rel="stylesheet" />
</head>
<body>
    <!-- Menu lateral -->
    <jsp:include page="templates/menu.jsp">
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

                <div class="card-grande card">
                    <div class="header-card-grande">
                        <h3 class="titulo-card">Divisão de alunos por turma</h3>
                        <div class="legenda">
                            <span class="cor-legenda"></span>
                            <h4>Total de alunos</h4>
                        </div>
                    </div>



                    <!-- grafico (tlvz colocar para um template depois) -->
                    <!-- lembrar de (se possivel) colocar valores variaveis -->
                    <div class="grafico">

                        <div class="grafico-eixo-y">
                            <span>20</span>
                            <span>15</span>
                            <span>10</span>
                            <span>5</span>
                            <span>0</span>
                        </div>

                        <!-- foreach para cada turma? -->
                        <div class="grafico-barras">
                            <div class="grafico-grid">
                                <div class="grafico-grid-linha"></div>
                                <div class="grafico-grid-linha"></div>
                                <div class="grafico-grid-linha"></div>
                                <div class="grafico-grid-linha"></div>
                            </div>


                            <div class="grafico-coluna">
                                <div class="grafico-barra" style="height: 100%;"></div>
                                <span class="grafico-label">101</span>
                            </div>

                            <div class="grafico-coluna">
                                <div class="grafico-barra" style="height: 45%;"></div>
                                <span class="grafico-label">201</span>
                            </div>

                            <div class="grafico-coluna">
                                <div class="grafico-barra" style="height: 55%;"></div>
                                <span class="grafico-label">301</span>
                            </div>

                        </div>

                    </div>
                    <div class="label-grafico">Turma</div>

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
                    <!-- adicionar js para abrir modal de criação -->
                    <span class="material-symbols-outlined icon-card add-icon">add_2</span>
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
                    <!-- adicionar js para abrir modal de criação -->
                    <span class="material-symbols-outlined icon-card add-icon">add_2</span>
                </div>
            </div>
        </div>
    </main>
</body>
</html>