const menuItems = document.querySelector(".menu-items");
let subMenus = [];

function createMenu(mItems) {
  fadeOutEffect(() => {
    menuItems.innerHTML = "";
    if (subMenus.length > 0) {
      const gobackButton = document.createElement("div");
      gobackButton.className = "go-back-menu";
      gobackButton.innerHTML = `
      <i class="menu-item__goback fas fa-chevron-right"></i>
      <span>Go Back</span>
    `
      gobackButton.setAttribute("onclick", "goBack()")
      menuItems.append(gobackButton)
    }
    for (item of mItems) {
      const element = document.createElement("div");
      element.classList.add("menu-item");
      if (item.sub_menu) {
        element.innerHTML = `
        <span class="menu-item__title">${item.title}</span>
        <span class="menu-item__description">${item.description}</span>
        <i class="menu-item__arrow fas fa-chevron-right"></i>
      `
        element.setAttribute('data-submenu', `${JSON.stringify(item.sub_menu)}`);
        element.setAttribute('onclick', "openSubMenu(this)");
      } else {
        element.innerHTML = `
          <span class="menu-item__title">${item.title}</span>
          <span class="menu-item__description">${item.description}</span>`

        element.setAttribute('onclick', "execute(this)");
        element.setAttribute('data-item', `${JSON.stringify(item)}`);
      }
      menuItems.append(element);
    }
    fadeInEffect();
  });
}

function execute(ele) {
  let element = JSON.parse(ele.getAttribute('data-item'));

  if (element.close == true) {
    fadeOutEffect();
    subMenus = [];
  }
  fetch(`https://xz-menu/closeMenu`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      event: element.event,
      args: element.args,
      close: element.close,
      eventType: element.eventType,
    }),
  });
}

function openSubMenu(ele) {
  subMenus[subMenus.length++] = menuItems.innerHTML;
  let subElement = JSON.parse(ele.getAttribute('data-submenu'));
  createMenu(subElement)
}

function fadeOutEffect(cb) {
  var fadeTarget = menuItems;
  const fadeEffect = setInterval(function () {
    if (!fadeTarget.style.opacity) {
      fadeTarget.style.opacity = 1;
    }
    if (fadeTarget.style.opacity > 0) {
      fadeTarget.style.opacity -= 0.1;
    } else {
      clearInterval(fadeEffect);
      if (typeof cb === 'function') cb();
    }
  }, 20);
}

function fadeInEffect(cb) {
  var fade = menuItems;
  var opacity = 0;
  const intervalID = setInterval(function () {
    if (opacity < 1) {
      opacity = opacity + 0.1
      fade.style.opacity = opacity;
    } else {
      clearInterval(intervalID);
      if (typeof cb === 'function') cb();
    }
  }, 20);
}
window.addEventListener("message", (e) => {
  const {
    action,
    payload
  } = e.data;

  if (action == "createMenu")
    createMenu(payload.items);
  if (action == "hideMenu") {
    fadeOutEffect(() => {
      menuItems.innerHTML = "";
      subMenus = [];
    });
  }
});

function goBack() {
  const newItems = subMenus.pop();
  fadeOutEffect(() => {
    menuItems.innerHTML = newItems;
    fadeInEffect();
  });
}
document.onkeyup = function (e) {
  if (e.key == "Escape") {
    if (subMenus.length > 0) {
      goBack();
    } else {
      fadeOutEffect(function () {
        fetch(`https://xz-menu/closeNui`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({}),
        });
      });
    }
  }
}