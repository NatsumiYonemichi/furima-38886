window.addEventListener('load', function(){

  const calculatePrice  = document.getElementById("item-price");
  calculatePrice.addEventListener("keyup", () => {
    const commission = calculatePrice.value * 0.1;
    const profit = calculatePrice.value - commission;
    const commissionInput = document.getElementById("add-tax-price");
    const profitInput =document.getElementById("profit");
    commissionInput.innerHTML = `${Math.floor(commission)}`;
    profitInput.innerHTML = `${Math.floor(profit)}`;
  });

})