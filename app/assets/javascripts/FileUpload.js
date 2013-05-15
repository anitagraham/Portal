$('#photoForm input').change(function(){
 $(this).parent().ajaxSubmit({
  beforeSubmit: function(a,f,o) {
   o.dataType = 'json';
  },
  complete: function(XMLHttpRequest, textStatus) {
    $('#personPhoto').attr('src', XMLHttpRequest.responseText);
  },
 });
});