let settings = {messages: 0, timer: null, inchat: false, scrolldown: true, render: false, hide: false, hidechat: 0, start: 0, suggests: [], mymessages: [], onmessage: -1, commands: []}
addEventListener("message", function(e)
{
	let item = e.data
	if(item.meta)
	{
		if(item.meta == "show")
			settings.hide = false;
		if(item.meta == "hide")
		{
			document.getElementById("chat").style.opacity = 0.0;
			settings.hide = true;
		}
		if(item.meta == "addsuggest")
		{
			let found = false;
			let i = 0;
			while(i < settings.suggests.length && !found)
			{
				if(settings.suggests[i].name == item.suggest.name)
					found = true;
				i++;
			}
			if(!found)
				settings.suggests[settings.suggests.length] = item.suggest;
		}
		if(item.meta == "addsuggests")
		{
			for(let i = 0; i < item.suggests.length; i++)
			{
				let found = false;
				let j = 0;
				while(j < settings.suggests.length && !found)
				{
					if(settings.suggests[j].name == item.suggests[i].name)
						found = true;
					j++;
				}
				if(!found)
					settings.suggests[settings.suggests.length] = item.suggests[i];
			}
		}
		if(item.meta == "removesuggest")
		{
			for(let i = 0; i < settings.suggests.length; i++)
			{
				if(settings.suggests[i].name == item.name)
				{
					delete settings.suggests[i];
					for(let j = i; j < settings.suggests.length-1; j++)
						settings.suggests[j] = settings.suggests[j+1];
					settings.suggests.length--;
					i--;
				}
			}
		}
		if(item.meta == "clear")
			document.getElementById("chat").innerHTML = "";
		if(item.meta == "input")
		{
			document.getElementById("displayinput").style.display = "block";
			settings.timer = setInterval(setfocus, 100);
			settings.inchat = true;
			settings.hidechat = -1;
			ShowChat();
		}
		if(item.meta == "message")
		{
			let dspan = "<span style=\"color: "+item.color+";"+(item.style ? (item.style):(""))+"\">";
			item.text = item.text.replace(/\^\*(.*?)(?=$|\^r)\^r/g, function(a, b)
			{
				return "<b>"+b+"</b>";
			});
			item.text = dspan+"<span>"+item.text.replace(/\^([0-9])/g, function(a, b)
			{
				return "</span><span class=\"color-"+b+"\">";
			})+"</span></span>";
			if(settings.hidechat != -1)
			{
				settings.hidechat = Date.now()+12000-settings.start;
				ShowChat();
			}
			settings.messages++;
			let elem = document.getElementById("chat");
			let str = elem.innerHTML;
			if(settings.messages > 100)
			{
				elem.innerHTML = ClearUp(elem.innerHTML, settings.messages, 100);
				settings.messages = 100;
			}
			let maxscroll = elem.scrollHeight-Math.round(0.18*$(window).height());
			let nowtop = elem.scrollTop;
			elem.innerHTML += item.text+"<br>";
			if(document.getElementById("display").style.display == "block")
				settings.scrolldown = maxscroll <= nowtop+1;
			if(settings.scrolldown)
				elem.scrollTop = elem.scrollHeight-Math.round(0.18*$(window).height());
		}
	}
})

addEventListener("keydown", function(e)
{
	if(settings.inchat)
	{
		if(e.which == 13)
		{
			if(settings.timer)
				clearInterval(settings.timer);
			let input = document.getElementById("input")
			document.getElementById("displayinput").style.display = "none";
			input.blur();
			settings.inchat = false;
			settings.hidechat = Date.now()+12000-settings.start;
			settings.timer = null;
			document.getElementById("tiptext").innerHTML = "";
			settings.commands = [];
			settings.onmessage = -1;
			$.post("http://chat/chat", JSON.stringify({text: input.value}));
			if(input.value.length > 0)
			{
				let i = 0;
				let found = false;
				while(i < settings.mymessages.length && !found)
				{
					if(settings.mymessages[i] === input.value)
					{
						found = true;
						for(let j = i; j > 0; j--)
							settings.mymessages[j] = settings.mymessages[j-1];
						settings.mymessages[0] = input.value;
					}
					i++;
				}
				if(!found)
				{
					for(i = settings.mymessages.length; i > 0; i--)
						settings.mymessages[i] = settings.mymessages[i-1];
					settings.mymessages[0] = input.value;
				}
			}
			/*if(input.value.length > 0)
			{
				let found = false;
				for(let i = 0; i < settings.lastmessages.length && !found; i++)
					if(settings.lastmessages == input.value)
					{
						if(found)
						{
							for(let j = i; j < setting.lastmessages.length-1; j++)
								settings.lastmessages[j] = settings.lastmessages[j+1];
							settings.lastmessages.unshift();
						}
						if(!found)
						{
							for(let j = i; j > 0; j--)
								settings.lastmessages[j] = settings.lastmessages[j-1];
							found = i;
						}
					}
				if(!found)
				{
					for(let i = 0; i < settings.lastmessages.length; i++)
						settings.lastmessages[i-1] = settings.lastmessages[i];
					settings.lastmessages[0] = input.value;
				}
			}*/
			input.value = "";
		}
		if(e.which == 38 || e.which == 40)
		{
			let input = document.getElementById("input");
			if(e.which == 38)
				settings.onmessage++;
			if(e.which == 40)
				settings.onmessage--;
			if(settings.onmessage > settings.mymessages.length-1)
				settings.onmessage = settings.mymessages.length-1;
			let str = "";
			if(settings.onmessage > -1)
				str = settings.mymessages[settings.onmessage] || "";
			if(settings.onmessage < -1)
			{
				if(settings.onmessage < -settings.commands.length-1)
					settings.onmessage = -settings.commands.length-1;
				str = settings.commands[-settings.onmessage-2] || "";
			}
			input.value = str;
			if(!str.startsWith("/") && settings.commands.length > 0)
			{
				document.getElementById("tiptext").innerHTML = "";
				settings.commands.length = 0;
			}
		}
		if(e.which == 33 || e.which == 34)
		{
			let elem = document.getElementById("chat");
			let maxscroll = elem.scrollHeight-Math.round(0.18*$(window).height());
			let tscroll = elem.scrollTop;
			if(e.which == 33)
				tscroll -= 100;
			if(e.which == 34)
				tscroll += 100;
			if(tscroll < 0)
				tscroll = 0;
			if(tscroll > maxscroll)
				tscroll = maxscroll;
			settings.scrolldown = maxscroll <= tscroll+1;
			elem.scrollTop = tscroll;
		}
		if(e.which == 27)
		{
			document.getElementById("displayinput").style.display = "none";
			$.post("http://chat/chat", JSON.stringify({text: ""}));
		}
	}
});

function OnFrame(gtime)
{
	if(settings.render && settings.hidechat != -1)
	{
		if(settings.hidechat < gtime+2000)
		{
			let htime = (settings.hidechat-gtime)/2000;
			if(htime < 0)
				htime = 0;
			document.getElementById("chat").style.opacity = htime;
		}
		if(settings.hidechat < gtime)
			settings.render = false;
	}
	requestAnimationFrame(OnFrame);
}

function ShowChat()
{
	//document.getElementById("display").style.display = "block";
	if(!settings.hide)
	{
		settings.render = true;
		let elem = document.getElementById("chat");
		if(settings.scrolldown)
		{
			let maxscroll = elem.scrollHeight-Math.round(0.18*$(window).height());
			let nowtop = elem.scrollTop;
			elem.scrollTop = elem.scrollHeight-Math.round(0.18*$(window).height());
		}
		elem.style.opacity = 1.0;
	}
}

function setfocus()
{
	let elem = document.getElementById("input")
	if(!IsElementInFocus(elem))
		elem.focus()
}

function ClearUp(chat, num1, num2)
{
	for(let i = 0; i < (num1-num2); i++)
	{
		let find = chat.includes("<br>");
		if(find)
		{
			let g = chat.indexOf("<br>");
			chat = chat.substring(g+4, chat.length);
		}
	}
	return chat;
}

function IsElementInFocus(elem)
{
	return elem == document.activeElement
}

window.onload = function()
{
	settings.start = Date.now();
	requestAnimationFrame(OnFrame);
	let showed = "";
	document.getElementById("input").oninput = function(event)
	{
		let str = ""
		let value = event.srcElement.value;
		settings.onmessage = -1;
		if(value.startsWith("/"))
		{
			settings.commands.length = 0;
			let spl = value.split(" ");
			let maxh = 5;
			let found = 0;
			let i = 0;
			while(i < settings.suggests.length && found < maxh)
			{
				if((spl.length > 1 && settings.suggests[i].name == spl[0]) || (spl.length < 2 && settings.suggests[i].name.startsWith(spl[0])))
				{
					let help = settings.suggests[i].help || "";
					if(spl.length <= 1)
						str += "<span style=\"color: #FFFFFF;\"><b>";
					str += settings.suggests[i].name;
					if(spl.length <= 1)
						str += "</b></span>";
					if(settings.suggests[i].params)
					{
						let num = spl.length-2;
						if(num >= settings.suggests[i].params.length)
							num = settings.suggests[i].params.length-1;
						for(let j = 0; j < settings.suggests[i].params.length; j++)
						{
							if(num == j)
								str += "<span style=\"color: #FFFFFF;\"><b>";
							str += " ["+settings.suggests[i].params[j].name+"]";
							if(num == j)
								str += "</b></span>";
						}
						if(num > -1)
							help = settings.suggests[i].params[num].help || "";
					}
					if(help.length > 0)
						str += "<br><span style=\"font-size: 1.4vh\">"+help+"</span>";
					str += "<br>";
					settings.commands[settings.commands.length] = settings.suggests[i].name;
					found++;
				}
				i++;
			}
		}
		if(settings.onmessage < -settings.commands.length-1)
			settings.onmessage = -1;
		if(str.length > 4)
			str = str.substring(0, str.length-4);
		if(showed != str)
		{
			document.getElementById("tiptext").innerHTML = str;
			showed = str;
		}
	};
	//document.getElementById("input").oninput = function(event){settings.onmessage = -1;changed(event)};
	//document.getElementById("input").onchange = changed;
}