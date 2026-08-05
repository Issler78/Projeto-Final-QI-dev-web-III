const modal = document.getElementById("modal");
const modalTitulo = document.getElementById("modal-titulo");
const openBtn = document.getElementById("openModal");
const erro = document.getElementById("erro-message");



// funcao para abrir o modal
openBtn.addEventListener("click", () => {
    // limpa os campos independente se for para criar ou editar
    document.getElementById("disciplina_id").value = "";
    document.getElementById("modal-form").reset();

    modalTitulo.textContent = "Nova disciplina";

    if (erro) {
        erro.textContent = "";
        erro.style.display = "none";
    }

    modal.style.display = "flex";
});



// funcoes de fechar tambem resetam campos do form
document.querySelectorAll(".close").forEach(btn => {
    btn.addEventListener("click", () => {
        modal.style.display = "none";
        document.getElementById("disciplina_id").value = "";
        document.getElementById("modal-form").reset();
        modalTitulo.textContent = "Nova disciplina";

        if (erro) {
            erro.textContent = "";
            erro.style.display = "none";
        }
    });
});



// fechar ao clicar fora do modal
modal.addEventListener("click", (event) => {
    if (event.target === modal) {
        modal.style.display = "none";
        document.getElementById("disciplina_id").value = "";
        document.getElementById("modal-form").reset();
        modalTitulo.textContent = "Nova disciplina";

        if (erro) {
            erro.textContent = "";
            erro.style.display = "none";
        }
    }
});



// funcao para preencher modal para edicao de dados antes de abrir
function abrirModalEdicao(disciplinaId, nome) {
    document.getElementById("disciplina_id").value = disciplinaId;
    document.getElementById("nome").value = nome;

    modalTitulo.textContent = "Editar disciplina";

    if (erro) {
        erro.textContent = "";
        erro.style.display = "none";
    }

    modal.style.display = "flex";
}