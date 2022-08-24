let btns = document.getElementsByClassName("btn-select-size")
let a;
window.onclick= function (e) {
  for (let item of btns) {
    if (item.id == e.target.id) {
      a = item;
    }
  };
  reply_click(a.id)
}
function reply_click(clicked_id)
{
  var pr =  document.getElementById(clicked_id).getAttribute("data-price");
    document.getElementById("pro_price").innerHTML = "$ " + pr;
  var quantity =  document.getElementById(clicked_id).getAttribute("data-quantity");
    document.getElementById("pro_quantity").innerHTML =  quantity + " in stock";
    document.getElementById("line_item_quantity").max = quantity;
  var action = "/line_items?product_attribute_id="+clicked_id;
  var form = document.getElementById("my_form");
    form.setAttribute("action",action);
}

require("../plugin/js")
