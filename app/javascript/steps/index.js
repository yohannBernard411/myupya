function test(){
  console.log("verif stepindex");


  

  if (document.getElementById('data-cs')){

    const myColors = ["#F56871", "#74C1E2", "#FC9962", "#D08AF8", "#6AEEAA", "#AF6944", "#F78BD2"];
    const currentStep = document.getElementById('data-cs');
    const currentStepId = currentStep.dataset.cs;
    const open = [parseInt(currentStepId, 10)];
    const all = [1, 2, 3, 4, 5, 6, 7];

    all.forEach(function(rank){
      const button = document.getElementById("clickopen"+rank);
      if (button){
        button.addEventListener("click", addopenclass, false);
      }
    });

    all.forEach(function(rank){
      const button = document.getElementById("clickopen"+rank);
      if (button){
        button.addEventListener("click", addopenclass, false);
      }
    });

    all.forEach(function(rank){
      const button = document.getElementById("clickclose"+rank);
      if (button){
        button.addEventListener("click", addcloseclass, false);
      }
    });

    function addopenclass(){
      const here = parseInt(this.value, 10);
      if (!open.includes(here)){
        open.push(here);
      }
      closing(all);
      opning(open);
    }

    all.forEach(function(rank){
      const button = document.getElementById("clickclose"+rank);
      if (button){
        button.addEventListener("click", addcloseclass, false);
      }
    });

    function addcloseclass(){
      const here = parseInt(this.value, 10);
      const index = open.indexOf(here);
      open.splice(index, 1);
      closing(all);
      opning(open);
    }

    function closing(all){
      all.forEach(function(rank){
        const offsettop = document.getElementById("offsettop"+rank);
        const openbutton = document.getElementById("openbutton"+rank);
        const closebutton = document.getElementById("closebutton"+rank);
        const article = document.getElementById("article"+rank);
        const video = document.getElementById("video"+rank);
        const coach = document.getElementById("coach"+rank);
        const offsetbottom = document.getElementById("offsetbottom"+rank);
        offsettop.classList.remove("d-block");
        offsettop.classList.add("d-none")
        openbutton.classList.remove("d-none");
        openbutton.classList.add("d-block");
        closebutton.classList.remove("d-block");
        closebutton.classList.add("d-none");
        article.classList.remove("d-block");
        article.classList.add("d-none");
        video.classList.remove("d-block");
        video.classList.add("d-none");
        coach.classList.remove("d-block");
        coach.classList.add("d-none");
        offsetbottom.classList.remove("d-block");
        offsetbottom.classList.add("d-none");
        const allpetitronds = document.querySelectorAll(".petitrond");
        allpetitronds.forEach((element) => {
          if (!all.includes(element.dataset.color))
          element.style.display = "none";
        })

      });
    }

    closing(all);

    function opning(open){
      open.forEach(function(rank){
        const offsettop = document.getElementById("offsettop"+rank);
        const openbutton = document.getElementById("openbutton"+rank);
        const closebutton = document.getElementById("closebutton"+rank);
        const article = document.getElementById("article"+rank);
        const video = document.getElementById("video"+rank);
        const coach = document.getElementById("coach"+rank);
        const offsetbottom = document.getElementById("offsetbottom"+rank);
        if (rank === currentStepId){
          offsettop.classList.remove("d-none");
          offsettop.classList.add("d-block");
          offsetbottom.classList.remove("d-none")
          offsetbottom.classList.add("d-block");
        }
        openbutton.classList.remove("d-block");
        openbutton.classList.add("d-none");
        closebutton.classList.remove("d-none");
        closebutton.classList.add("d-block");
        article.classList.remove("d-none");
        article.classList.add("d-block");
        video.classList.remove("d-none");
        video.classList.add("d-block");
        coach.classList.remove("d-none");
        coach.classList.add("d-block");
        const myrank =  `data-color=${rank-1}`;
        article.insertAdjacentHTML("beforebegin", `<div class='petitrond' ${myrank}></div>`);
        video.insertAdjacentHTML("beforebegin", `<div class="petitrond" ${myrank}></div>`);
        coach.insertAdjacentHTML("beforebegin", `<div class="petitrond" ${myrank}></div>`);
        const allpetitronds = document.querySelectorAll(".petitrond");
        allpetitronds.forEach((element) => {
          element.style.borderColor = myColors[element.dataset.color];
        });
        const allpetitrondfixes = document.querySelectorAll(".petitrondfixe");
        allpetitrondfixes.forEach((element) => {
          element.style.borderColor = myColors[element.dataset.color];
          element.style.backgroundColor = myColors[element.dataset.color];
        })
      },

      function opning(open){
        open.forEach(function(rank){
          const offsettop = document.getElementById("offsettop"+rank);
          const openbutton = document.getElementById("openbutton"+rank);
          const closebutton = document.getElementById("closebutton"+rank);
          const article = document.getElementById("article"+rank);
          const video = document.getElementById("video"+rank);
          const coach = document.getElementById("coach"+rank);
          const offsetbottom = document.getElementById("offsetbottom"+rank);
          if (rank === currentStepId){
            offsettop.classList.remove("d-none");
            offsettop.classList.add("d-block");
            offsetbottom.classList.remove("d-none")
            offsetbottom.classList.add("d-block");
          }
          openbutton.classList.remove("d-block");
          openbutton.classList.add("d-none");
          closebutton.classList.remove("d-none");
          closebutton.classList.add("d-block");
          article.classList.remove("d-none");
          article.classList.add("d-block");
          video.classList.remove("d-none");
          video.classList.add("d-block");
          coach.classList.remove("d-none");
          coach.classList.add("d-block");
        });
      });
    };
    opning(open);

    const numbers = document.querySelectorAll(".my-number-box");
    let count = 0;
    numbers.forEach((element) => {
      element.style.backgroundColor = myColors[count];
      count += 1;
    });

    const petitronds = document.querySelectorAll(".petitrond");
    count = 0;
    petitronds.forEach((element) => {
      element.style.borderColor = myColors[element.dataset.color];
    });

  };
};
export { test }
