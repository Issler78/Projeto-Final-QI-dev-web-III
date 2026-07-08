<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sistema Escolar</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/menu.css">

    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&icon_names=admin_panel_settings,book,campaign,group,home,how_to_reg,school" rel="stylesheet" />
</head>
<body>
    <!-- Menu lateral -->
    <jsp:include page="templates/menu.jsp" >
        <jsp:param name="pagina" value="professores" />
    </jsp:include>

    <!-- main -->
    <h1>Professores</h1>
</body>
</html>