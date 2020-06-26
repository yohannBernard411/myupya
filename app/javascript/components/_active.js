const activebtn = () => {
  const labels = document.querySelectorAll("label");
  labels.forEach((label) => {
    label.addEventListener("click", (event) => {
      label.classList.toggle("activebtn");
    });
  });
};
export { activebtn };
