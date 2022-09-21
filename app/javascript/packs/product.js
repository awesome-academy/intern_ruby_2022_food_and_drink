import { data } from "jquery";

$(document).ready(function () {
  let attrClass = $(document).find(".nested-attr-fields");
  let imageClass = $(document).find(".nested-image-fields");
  if (attrClass.length == 1) {
    $(".remove-attr").addClass("d-none")
  }

  if (imageClass.length == 1) {
    $(".remove-image").addClass("d-none")
  }

  $(".btn-add-attr").click(function (e) {
    $(".remove-attr").removeClass("d-none")
  })
  $(".btn-add-image").click(function (e) {
    $(".remove-image").removeClass("d-none")
  })

  $("#new_product").bind("DOMSubtreeModified", function () {
    if ($(this).find(".nested-fields").length == 1) {
      $(".remove-attr").addClass("d-none")
    }
  })

  $(document).find("#new_product").validate({
    rules: {
      "product[name]": {
        required: true,
        maxlength: 200,
        minlength: 8,
        name_exists: true
      },
      "product[category_id]": {
        required: true
      },
      "product[product_attributes_attributes][0][size_id]": {
        required: true
      },
      "product[product_attributes_attributes][0][price]": {
        required: true,
        min: 1,
        max: 1000000000000,
      },
      "product[product_attributes_attributes][0][quantity]": {
        required: true,
        min: 1,
        max: 1000000000000,
      },
      "product[description]": {
        required: true,
        minlength: 30,
      },
      "product[product_images_attributes][0][image]": {
        required: true
      },
    },
    messages: {
      "product[name]": {
        required: I18n.t("validate.required"),
        maxlength: I18n.t("validate.max_length", { number: 200 }),
        minlength: I18n.t("validate.min_length", { number: 8 }),
      },
      "product[category_id]": {
        required: I18n.t("validate.required"),
      },
      "product[product_attributes_attributes][0][size_id]": {
        required: I18n.t("validate.required"),
      },
      "product[product_attributes_attributes][0][price]": {
        required: I18n.t("validate.required"),
        min: I18n.t("validate.min", { number: 1 }),
        max: I18n.t("validate.max", { number: 1000000000000 }),
      },
      "product[product_attributes_attributes][0][quantity]": {
        required: I18n.t("validate.required"),
        min: I18n.t("validate.min", { number: 1 }),
        max: I18n.t("validate.max", { number: 1000000000000 }),
      },
      "product[description]": {
        required: I18n.t("validate.required"),
      },
      "product[product_images_attributes][0][image]": {
        required: I18n.t("validate.required"),
      },
    }
  });

  jQuery.validator.addMethod("name_exists", function (value) {
    return !(Object.values(JSON.parse($(document).find("#all_name").val())).indexOf(value) > -1)
  }, I18n.t("validate.name_exists"));

  $(document).on("submit", "#new_product", function (e) {
    if (!$("#new_product").valid()) {
      return;
    }
    localStorage.setItem("flash", I18n.t("admin.products.destroy.alert_success_destroy"))
  })

  $(document).on("click", ".btn-delete-product", function (e) {
    let id = $(this).data("id");
    let name = $(this).data("name");
    Swal.fire({
      title: I18n.t("admin.products.destroy.title_modal", { name: name }),
      icon: "question",
      iconHtml: "؟",
      confirmButtonText: I18n.t("btn_ok"),
      cancelButtonText: I18n.t("btn_cancel"),
      showCancelButton: true,
      preConfirm: (function (e) {
        $.ajax({
          type: "DELETE",
          url: `products/${id}`,
        }).done(results => {
          localStorage.setItem("flash", I18n.t("admin.products.destroy.alert_success_destroy"))
          window.location.reload();
        }).fail(errors => {
          toastr.error(I18n.t("admin.products.destroy.alert_err_destroy"))
        })
      })
    })
  })

  $(document).on("click", ".btn-delete-category", function (e) {
    let id = $(this).data("id");
    let name = $(this).data("name");
    Swal.fire({
      title: I18n.t("admin.categories.destroy.warning_delete", { name: name }),
      icon: "question",
      iconHtml: "؟",
      confirmButtonText: I18n.t("btn_ok"),
      cancelButtonText: I18n.t("btn_cancel"),
      showCancelButton: true,
      preConfirm: (function (e) {
        $.ajax({
          type: "DELETE",
          url: `categories/${id}`,
        }).done(results => {
          localStorage.setItem("flash", I18n.t("admin.categories.destroy.alert_success_delete"))
          window.location.reload();
        }).fail(errors => {
          toastr.error(I18n.t("admin.categories.destroy.alert_err_delete"))
        })
      })
    })
  })

  $(document).on("click", ".btn-update-orders", function (e) {
    let id = $(this).data("id")
    let status = $(this).data("status")
    let form = `<form class="edit_order" id="edit_order_1" action="/vi/admin/orders/${id}" accept-charset="UTF-8" method="post"></form><input type="hidden" name="_method" value="patch" autocomplete="off"><input type="hidden" name="authenticity_token" value="pM5vXLZ-ni1LV82XhFbHDRZO5Hu4eNne6wdQ4Y1izcXyWBtwMmmGEL6PtBHnSRgrhjGKgWXQYiil-3bwMSlLjQ" autocomplete="off">
    <div class="text-red">
    </div>
    <div class="card-body">
      <div class="form-row">
        <div class="form-group col-md-6">
          <label for="order_<span class=&quot;translation_missing&quot; title=&quot;translation missing: vi.admin.orders.order.status&quot;>Status</span>">Status"&gt;status&lt;/span&gt;</label>
          <select class="form-control" name="order[status]" id="order_status">
          <option value="approved">${I18n.t("orders.status.approved")}</option>
          <option value="rejected">${I18n.t("orders.status.rejected")}</option>
          <option value="processing">${I18n.t("orders.status.processing")}</option>
          <option value="finished">${I18n.t("orders.status.finished")}</option>
        </select>
        </div>
      </div>
    </div>
    <div class="card-footer">
      <input type="submit" name="commit" value="Cập nhật" data-id="${id}" class="btn btn-update-status btn-danger" data-disable-with="Cập nhật">
    </div>`

    $(`.modal-${id}`).find(".modal-content").empty().append(form);
    $(`.modal-${id}`).show();
  })

  $(document).on("click", ".btn-update-status", function (e) {
    e.preventDefault()
    let id = $(this).data("id")
    let data = $(document).find(`#order_status`).val();
    console.log(data);
    $.ajax({
      type: "PATCH",
      url: `orders/${id}`,
      data: {
        order: {
          status: data
        }
      }
    }).done(function (e) {
      localStorage.setItem("flash", I18n.t("admin.orders.update.success"))
      window.location.reload();
    }).fail(errors => {
      toastr.error(I18n.t("admin.orders.update.fail"))
    })
  })


  $(window).bind('load', function () {
    if (localStorage.getItem("flash") != null) {
      toastr.success(localStorage.getItem("flash"))
      localStorage.removeItem("flash")
    }
  })
})
