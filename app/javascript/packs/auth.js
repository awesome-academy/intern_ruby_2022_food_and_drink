$(document).ready(function () {
  let emailRegex = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
  let phoneRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]/
  let passwordRegex = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im
  $(document).find(".show_pass").click(function (e) {
    let input = $(this).siblings("input");
    $(this).find(".svg-inline--fa").toggleClass("fa-eye-slash").toggleClass("fa-eye")
    input.prop("type", $(this).find(".fa-eye-slash").length ? "password" : "text")
  })

  $(document).find("#new_user").validate({
    errorPlacement: function (error, element) {
      error.insertBefore(element.parent());
    },
    rules: {
      "user[name]": {
        required: true,
        maxlength: 255,
        minlength: 10
      },
      "user[email]": {
        required: true,
        regexEmail: true,
        maxlength: 255,
        minlength: 10
      },
      "user[phone]": {
        required: true,
        regexPhone: true,
      },
      "user[password]": {
        required: true,
        // regexPassword: true,
        maxlength: 255,
        minlength: 6
      },
      "user[password_confirmation]": {
        required: true,
        regexPassword: true,
        equalTo: "#user_password"
      }
    },
    messages: {
      "user[email]": {
        required: I18n.t("devise.validate.required"),
        minlength: I18n.t("devise.validate.length.min", { number: 10 }),
        maxlength: I18n.t("devise.validate.length.max", { number: 255 }),
      },
      "user[password]": {
        required: I18n.t("devise.validate.required"),
        minlength: I18n.t("devise.validate.length.min", { number: 6 }),
        maxlength: I18n.t("devise.validate.length.max", { number: 255 }),
      },
    }
  })

  $.validator.addMethod("regexEmail",
    function (value, element) {
      return emailRegex.test(value);
    },
    I18n.t("devise.validate.wrong_format_email")
  );

  $.validator.addMethod("regexPassword",
    function (value, element) {
      return phoneRegex.test(value);
    },
    I18n.t("devise.validate.wrong_format_pw")
  );

  $.validator.addMethod("regexPhone",
    function (value, element) {
      return passwordRegex.test(value);
    },
    I18n.t("devise.validate.wrong_format_phone")
  );

  $(document).on("submit", "#new_user", function (e) {
    if (!$("#new_user").valid()) {
      return;
    }
  })
})
