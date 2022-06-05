//$(window).on("load", function() { $(".skip").fadeIn(); });

var shouldDisable = false
addEventListener("message", function(event){
    let item = event.data;

    if(item.type == "page") {
      TriggerPage(item.page, item.color, item.title, item.desc)
    }
    
    if(item.type == "skip") {
        $(".skip-container").fadeIn(2000);
    }

    if(item.type == "close") {
      $(".skip-container").fadeOut(0);
      $(".presents").fadeOut(0);
      $(".page-one").fadeOut(0);
    }
});


function TriggerPage(pageNumber, color, title, desci) {
    if (pageNumber == 0) {
      $(".presents").fadeIn();
      setTimeout(function() {
        $("#present-logo").fadeIn(4000);
        setTimeout(function() { $("#present-text").fadeIn(1200)} , 3250);

        setTimeout(function() { 
          $("#present-text").fadeOut(1200); 
          $("#present-logo").fadeOut(1200);
          $(".presents").fadeOut();
        } , 6500);
      }, 2000)
    }
    if (pageNumber != 0) {
      shouldDisable = false
        $(".page-one").fadeIn();
        setTimeout(function() {
          $("#page-one-header").fadeIn(1500);
          document.getElementById("page-one-header").style.color = color;
          createTyper("page-one-header", title);
          setTimeout(function() { 
              $("#page-one-sec").fadeIn(1500);
              createTyper("page-one-sec", desci);
          } , 1000);
        }, 2000)
    }
}

class TypeWriter {
  constructor(txtElement, words, wait = 5500) {
    this.txtElement = txtElement;
    this.word = words;
    this.txt = '';
    this.wordIndex = 0;
    this.wait = parseInt(wait, 10);
    this.type();
    this.isDeleting = false;
    this.isSkipped = false;
  }

  type() {
    const fullTxt = this.word;
    
    if (!this.isDone && !shouldDisable) {
       if(this.isDeleting) {
          this.txt = fullTxt.substring(0, this.txt.length - 1);
        } else {
          this.txt = fullTxt.substring(0, this.txt.length + 1);
        }
    
        this.txtElement.innerHTML = `${this.txt}`;
        let typeSpeed = 25;
    
        if(this.isDeleting) {
          typeSpeed /= 2;
        }
    
        if(!this.isDeleting && this.txt === fullTxt) {
            typeSpeed = this.wait;
            this.isDeleting = true;
        } else if(this.isDeleting && this.txt === '') {
            this.isDeleting = false;
            this.wordIndex++;
            this.isDone = true;
            
            setTimeout(function() {
                this.txtElement.innerHTML = `${fullTxt}`;
            }, 2000);
          typeSpeed = 35;
        }
    
        setTimeout(() => this.type(), typeSpeed); 
    } else {
      if (shouldDisable) {
        this.txtElement.innerHTML = '';
      }
    }
  }
}

function createTyper(elemid, text) {
    const txtElement = document.getElementById(elemid);
    const words = text;
    new TypeWriter(txtElement, words);
}

function skipTut() {
  shouldDisable = true;
  $(".skip-container").fadeOut(0);
  $.post('http://bb-jguid/skipTut');
}