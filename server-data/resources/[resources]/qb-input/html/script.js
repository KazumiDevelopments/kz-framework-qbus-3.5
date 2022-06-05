let formInputs = {};

const OpenMenu = (data) => {
    if (data == null || data == "") {
        console.log("No data detected");
        return null;
    }

    $(`.main-wrapper`).fadeIn(0);

    let form = [
        "<form id='qb-input-form'>",
        `<div class="heading">${
            data.header != null ? data.header : "Form Title"
        }</div>`,
    ];

    data.inputs.forEach((item, index) => {
        switch (item.type) {
            case "text":
                form.push(renderTextInput(item));
                break;
            case "password":
                form.push(renderPasswordInput(item));
                break;
            case "number":
                form.push(renderNumberInput(item));
                break;
            case "radio":
                form.push(renderRadioInput(item));
                break;
            case "select":
                form.push(renderSelectInput(item));
                break;
            case "checkbox":
                form.push(renderCheckboxInput(item));
                break;
            default:
                form.push(`<div>${item.text}</div>`);
        }
    });
    form.push(
        `<div class="footer"><button type="submit" class="btn btn-success" id="submit">${
            data.submitText ? data.submitText : "Submit"
        }</button></div>`
    );

    form.push("</form>");

    $(".main-wrapper").html(form.join(" "));

    $("#qb-input-form").on("change", function (event) {
        if( $(event.target).attr("type") == 'checkbox' ) {
            const value = $(event.target).is(":checked") ? "true" : "false";
            formInputs[$(event.target).attr("value")] = value;
        }else{
            formInputs[$(event.target).attr("name")] = $(event.target).val();
        }
    });

    $("#qb-input-form").on("submit", async function (event) {
        if (event != null) {
            event.preventDefault();
        }
        await $.post(
            `https://${GetParentResourceName()}/buttonSubmit`,
            JSON.stringify({ data: formInputs })
        );
        CloseMenu();
    });
};

const renderTextInput = (item) => {
    const { text, name } = item;
    formInputs[name] = "";
    const isRequired =
        item.isRequired == "true" || item.isRequired ? "required" : "";

    return ` <input placeholder="${text}" type="text" class="form-control" name="${name}" ${isRequired}/>`;
};
const renderPasswordInput = (item) => {
    const { text, name } = item;
    formInputs[name] = "";
    const isRequired =
        item.isRequired == "true" || item.isRequired ? "required" : "";

    return ` <input placeholder="${text}" type="password" class="form-control" name="${name}" ${isRequired}/>`;
};
const renderNumberInput = (item) => {
    try {
        const { text, name } = item;
        formInputs[name] = "";
        const isRequired =
            item.isRequired == "true" || item.isRequired ? "required" : "";

        return `<input placeholder="${text}" type="number" class="form-control" name="${name}" ${isRequired}/>`;
    } catch (err) {
        console.log(err);
        return "";
    }
};

const renderRadioInput = (item) => {
    const { options, name, text } = item;
    formInputs[name] = options[0].value;

    let div = `<div class="form-input-group"> <div class="form-group-title">${text}</div>`;
    div += '<div class="input-group">';
    options.forEach((option, index) => {
        div += `<label for="radio_${name}_${index}"> <input type="radio" id="radio_${name}_${index}" name="${name}" value="${
            option.value
        }" ${index == 0 ? "checked" : ""}> ${option.text}</label>`;
    });

    div += "</div>";
    div += "</div>";
    return div;
};

const renderCheckboxInput = (item) => {
    const { options, name, text } = item;


    let div = `<div class="form-input-group"> <div class="form-group-title">${text}</div>`;
    div += '<div class="input-group-chk">';

    options.forEach((option, index) => {
        div += `<label for="chk_${name}_${index}">${option.text} <input type="checkbox" id="chk_${name}_${index}" name="${name}" value="${option.value}"></label>`;
        formInputs[option.value] = 'false';
    });

    div += "</div>";
    div += "</div>";
    return div;
};

const renderSelectInput = (item) => {
    const { options, name, text } = item;
    let div = `<div class="select-title">${text}</div>`;

    div += `<select class="form-select" name="${name}" title="${text}">`;
    formInputs[name] = options[0].value;

    options.forEach((option, index) => {
        div += `<option value="${option.value}" ${
            option.checked != null ? "checked" : ""
        }>${option.text}</option>`;
    });
    div += "</select>";
    return div;
};

const CloseMenu = () => {
    $(`.main-wrapper`).fadeOut(0);
    $("#qb-input-form").remove();
    formInputs = {};
};

const CancelMenu = () => {
    $.post(`https://${GetParentResourceName()}/closeMenu`);
    return CloseMenu();
};

window.addEventListener("message", (event) => {
    const data = event.data;
    const info = data.data;
    const action = data.action;
    switch (action) {
        case "OPEN_MENU":
            return OpenMenu(info);
        case "CLOSE_MENU":
            return CloseMenu();
        default:
            return;
    }
});

document.onkeyup = function (event) {
    const charCode = event.key;
    if (charCode == "Escape") {
        CancelMenu();
    } else if (charCode == "Enter") {
        SubmitData();
    }
};

// IDK why this is a thing ? what if they misclick?
$(document).click(function (event) {
    var $target = $(event.target);
    if (
        !$target.closest(".main-wrapper").length &&
        $(".main-wrapper").is(":visible")
    ) {
        CancelMenu();
    }
});
