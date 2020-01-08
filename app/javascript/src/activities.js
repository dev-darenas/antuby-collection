
const init = () => {
  console.log(" init activities ")
  $( ".type_activity").change(function() {
    $(".activities_fields").hide();
    $("."+ $(this).val()).show();
  });
};

export default init;
