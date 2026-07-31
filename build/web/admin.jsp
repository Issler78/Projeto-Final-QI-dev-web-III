<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sistema Escolar</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/menu.css">
    <link rel="stylesheet" href="css/admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&icon_names=add_2,admin_panel_settings,book,border_color,calendar_clock,calendar_month,campaign,close,delete,event_note,group,groups,home,how_to_reg,keyboard_arrow_right,menu_book,school,visibility" rel="stylesheet" />
</head>
<body>
    <!-- Menu lateral -->
    <jsp:include page="templates/menu.jsp" >
        <jsp:param name="pagina" value="admin" />
    </jsp:include>
    <!-- main -->
    <main>
        <h1>Administração</h1>

        <div class="admin-grid">

            <a href="disciplinas.jsp" class="admin-card">
                <span class="material-symbols-outlined admin-icon">menu_book</span>
                <h3>Disciplinas</h3>
                <p>Cadastrar e gerenciar disciplinas</p>
            </a>

            <a href="periodos.jsp" class="admin-card">
                <span class="material-symbols-outlined admin-icon">event_note</span>
                <h3>Períodos</h3>
                <p>Cadastrar e gerenciar períodos de aula</p>
            </a>

            <a href="turmas.jsp" class="admin-card">
                <span class="material-symbols-outlined admin-icon">groups</span>
                <h3>Turmas</h3>
                <p>Cadastrar e gerenciar turmas</p>
            </a>

            <a href="agendas.jsp" class="admin-card">
                <span class="material-symbols-outlined admin-icon">calendar_month</span>
                <h3>Agendas</h3>
                <p>Relacionar professores, turmas e períodos</p>
            </a>

        </div>
    </main>
</body>
</html>
