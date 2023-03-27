const STYLESHEET_KEY = "stylesheet";
const DEFAULT = "style/default.css";
const ALT = "style/alternative.css";

function toggleStyleSheet() {
    var styleElement = document.getElementById("mainStyleSheet");
    var fileName = styleElement.getAttribute("href");
    var newFileName = DEFAULT;
    if (fileName == ALT) {
        newFileName = DEFAULT
    } else {
        newFileName = ALT
    }
    styleElement.setAttribute("href", newFileName);
    localStorage.setItem(STYLESHEET_KEY, newFileName);
}

window.onload = function () {
    var stylesheetValue = localStorage.getItem(STYLESHEET_KEY) || DEFAULT;
    var styleElement = document.getElementById("mainStyleSheet");
    styleElement.setAttribute("href", stylesheetValue);
}