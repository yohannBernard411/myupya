function timelineSwiper() {
  if (document.getElementById("data-cs")){
    const mySwiper = new Swiper(".swiper-container", {    //.timelineSwiper 
      initialSlide: (document.getElementById("data-cs").dataset.cs),
      direction: "vertical",
      loop: false,
      speed: 1600,
      pagination: {
        el: ".swiper-pagination",
        type: "bullets",
        clickable: true,
        renderBullet: function (index, className) {
          var year = document
            .querySelectorAll(".swiper-slide")
            [index].getAttribute("data-year");
          return '<span class="' + className + '">' + year + "</span>";
        },
      },
      paginationClickable: false,
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
    });
    if (document.getElementById("data-cs")) {
      const currentStep = document.getElementById("data-cs");
      const currentStepId = currentStep.dataset.cs;
      const currentStepValue = [parseInt(currentStepId, 10)];
      mySwiper.slideTo(currentStepValue - 1, 1600, true);
    }
  }
}

export { timelineSwiper };
