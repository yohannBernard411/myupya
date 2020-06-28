const activebtn = () => {
  const all = document.querySelectorAll(".collection_radio_buttons");
  const yes = all[0];
  const no = all[1];
  yes.addEventListener("click", yeschange, false);
  no.addEventListener("click", nochange, false);
  function yeschange(){
    yes.classList.add("activebtn");
    no.classList.remove("activebtn");
  };
  function nochange(){
    no.classList.add("activebtn");
    yes.classList.remove("activebtn");
  };
};

export { activebtn };