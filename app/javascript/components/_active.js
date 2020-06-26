const activebtn = () => {
  document.querySelectorAll("label").forEach((label) => {
    label.addEventListener("click", (event) => {
      event.currentTarget.classList.toggle("activebtn");
    });
  });
};

activebtn();
export { activebtn };
