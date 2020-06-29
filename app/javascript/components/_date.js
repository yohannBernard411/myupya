function date(){
  if (document.getElementById("my_date")){
    $('input.datepicker').datepicker;
    const my_date = document.getElementById("my_date");
    const valid = document.getElementById("valid");
    const savedate = document.getElementById("savedate");
    valid.addEventListener("click", displayThis, false);
    
    function displayThis(){
      savedate.value = my_date.value;
    }
  }
}
export { date };
