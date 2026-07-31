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

