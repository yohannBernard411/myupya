const activeclass = () => {
  const accueil = document.getElementById("accueil");
  const bilan = document.getElementById("bilan");
  const parcours = document.getElementById("parcours");
  const contact = document.getElementById("contact");

  const currentdir = window.location.pathname.split("/")[1]
  if (currentdir == ""){
    accueil.classList.add("active");
  }
  if (currentdir == "questions"){
    bilan.classList.add("active");
  }
  if (currentdir == "steps"){
    parcours.classList.add("active");
  }
  if (currentdir == "coachs"){
    parcours.classList.add("active");
  }
  if (currentdir == "videos"){
    parcours.classList.add("active");
  }
  if (currentdir == "articles"){
    parcours.classList.add("active");
  }
  if (currentdir == "orders"){
    parcours.classList.add("active");
  }
  
}
  
export { activeclass }
