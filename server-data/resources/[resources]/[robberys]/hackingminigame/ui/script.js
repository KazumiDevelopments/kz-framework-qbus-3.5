/*
    Made by https://github.com/theRealRunner
*/

'use strict';

const Letters = 
[ 
  ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"],
  ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"],
  ["Φ", "Χ", "Γ", "Δ", "Ε", "Θ", "Λ", "Ξ", "Π", "Σ", "Ψ", "Ω"]
];

const 
  loadingText = document.querySelector('.loadingText'),
  bgLoading = document.querySelector('.bgLoading'),
  bgTablet = document.querySelector('.bgTablet'),
  combination = document.querySelector('.txtCombination'),
  timeLeft = document.querySelector('.timeLeft'),
  allCombinations = document.querySelector('.qCombinations');
  // selectgType = document.getElementById("gType");

let 
  loadingCount,
  timeRemaining,
  rndCombination = [],
  comb = [],
  curField,
  corrCombination,
  gType = 0;

// Timers
let
  refreshTimer,
  cdTimer,
  loadTimer,
  tempTimeout;

const init = () =>
{
    loadingCount = 0;
    timeRemaining = 15.0;
    curField = 0;
    corrCombination = -1;

    rndCombination.length = 0;
    comb.length = 0;

    bgTablet.classList.add('hidden');
    bgLoading.classList.add('hidden');

    loadingText.textContent = 'INITIALIZING...';

    tempTimeout = setTimeout(
    () =>
      { 
        bgLoading.classList.remove('hidden');
        startLoadingTimer();
      }, 
      2000
    );
}
bgTablet.classList.add('hidden');
bgLoading.classList.add('hidden');
$(document).ready(function() {

  window.addEventListener('message' , function(e){
    if(e.data.show === true) {
      init()
    } else if(e.data.show === false) {
      bgTablet.classList.add('hidden');
      bgLoading.classList.add('hidden');
    }
  })
})

bgTablet.classList.add('hidden');
bgLoading.classList.add('hidden');

const startLoadingTimer = () => // Displays the loading texts with a repeating timer
{
  loadTimer = setInterval(
    () =>
    {
      const
        LoadingStrings = 
        [
          "INITIALIZING...",
          "PREPARING INTERFACE...",
          "CONNECTING..."
        ];

      loadingText.textContent = LoadingStrings[loadingCount];

      if(++ loadingCount > 3)
      {
        loadingText.textContent = "CONNECTED!";
        clearInterval(loadTimer);

        tempTimeout = setTimeout(
          function()
          { 
            loadTablet();
          }, 
          2000
        );
      }
    },
    1500
  );
};

const loadTablet = () => // Pretty self explanatory
{
  bgLoading.classList.add('hidden');
  bgTablet.classList.remove('hidden');

  loadCombination();
  startCountDownTimer();
};

const loadCombination = () => // Creates the spans and sorts them by ID using the insertAdjacentHTML
{
  allCombinations.innerHTML = "";

  let 
    calcComb = "",
    rndLet = "";
  
  createCombination();
  
  for(let i = 0; i < 80; ++i)
  {
    rndLet = rndCombination[i];
    calcComb += `<span id="S${i}">${rndLet}</span>`;
  }
  
  allCombinations.insertAdjacentHTML("beforeend", calcComb);
  curField = Math.round(Math.random() * (76 - 0) + 0); // Random starting field

  highlightText();
  refreshLetters();
}

const highlightText = () => // Adds color to the selected field
{
  for(let i = 0; i <= 79; ++i)
    document.getElementById(`S${i}`).style.color = "white";

  for(let x=0; x <= 3; ++x)
    document.getElementById(`S${curField + x}`).style.color = "red";
}

const refreshLetters = () => // Shifts the array and updates the spans
{
  refreshTimer = setInterval(
  () => 
    {
      rndCombination.shift();
      if(--corrCombination < 0)
        endTask('dick');

      for(let i = 0; i < 79; ++i)
      {
        document.getElementById(`S${i}`).textContent = rndCombination[i];
      }
    },
    1250
  );
}

const createCombination = () => // Creates a random combination and inserts the required one that needs to be found
{
  const 
    max = Math.random() * (80 - 78) + 78,
    min = Math.random() * (25 - 16) + 16;
  
  for(let i = 0; i < 160; ++i)
    rndCombination.push(Letters[gType][Math.floor(Math.random() * Letters[gType].length)] + Letters[gType][Math.floor(Math.random() * Letters[gType].length)]);
  
  let
    insertComb = Math.round(Math.random() * (max - min) + min);
  
  for(let i = 0; i < 4; ++i)
    comb.push(Letters[gType][Math.floor(Math.random() * Letters[gType].length)] + Letters[gType][Math.floor(Math.random() * Letters[gType].length)]);

  corrCombination = insertComb;
  
  for(let x=0; x <= 3; ++x)
  {
    rndCombination[insertComb] = comb[x];
    ++insertComb;
  }
  combination.textContent = comb[0] + " " + comb[1] + " " + comb[2] + " " + comb[3];
}


const startCountDownTimer = () => // Just a simple countdown timer for the time left :)
{
  cdTimer = setInterval(
  () =>
    {
      timeRemaining -= 0.0842;
      timeLeft.textContent = Number((timeRemaining).toFixed(2));

      if(timeRemaining <= 0.1)
        endTask(false);
    },
    100
  );
}



const endTask = (state = false) => // Ends the hack (if successful then its true & if failed its false)
{
  bgLoading.classList.remove('hidden');
  bgTablet.classList.add('hidden');

  loadingText.textContent = (state ? "SEQUENCE ACCEPTED!" : "SEQUENCE FAILED!");

  clearInterval(refreshTimer);
  clearInterval(cdTimer);
  if(state !== 'dick') {
    $.post(`https://${GetParentResourceName()}/endTask`, JSON.stringify({
      success: state,
    }));
  }

}

document.body.addEventListener("keydown", function(event)
{
  
  if(timeRemaining != 15.0) // Did the tablet start up? If no ignore the input...
  {
    if(event.code === "ArrowUp" || event.code === "KeyW") 
    {
      if(curField >= 10)
        curField -= 10;
    }
    else if(event.code === "ArrowDown" || event.code === "KeyS")
    {
      if(curField < 67)
        curField += 10;
    }
    else if(event.code === "ArrowLeft" || event.code === "KeyA")
    {
      if(curField != 0)
        curField -= 1;
    }
    else if(event.code === "ArrowRight" || event.code === "KeyD")
    {
      if(curField != 76)
        curField += 1;
    }
    else if(event.code === "Enter" || event.code === "NumpadEnter")
    {
      endTask(curField == corrCombination ? true : false);
      return 1;
    }
    highlightText();
  }
});