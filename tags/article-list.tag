<article-list>
<h3>Article List </h3>
<div class="table-responsive">
<p>
<button type="button" id="new-btn" class="btn btn-primary" data-toggle="modal" data-target="#new">New Entry</button>
</p>
<table id="mytable" class="table table-bordered table-striped">
<thead>
<th><input type="checkbox" id="checkall" /></th>
<th>Title</th>
<th>Content</th>
<th>Created at</th>
<th>Updated at</th>
<th>Edit</th>
<th>Delete</th>
</thead>
<tbody>
<tr each={articles}>
<td><input type="checkbox" class="checkthis" data-idc={id}/></td>
<td title-idc={id}>{title}</td>
<td content-idc={id}>{content}</td>
<td data-idc={id}>{created_at}</td>
<td data-idc={id}>{updated_at}</td>
<td><p data-placement="top" data-toggle="tooltip" title="Edit"><button class="btn btn-primary btn-sm edit-btn" data-title="Edit" data-idc={id}><span class="glyphicon glyphicon-pencil"></span></button></p></td>
<td><p data-placement="top" data-toggle="tooltip" title="Delete"><button class="btn btn-danger btn-sm delete-btn" data-title="Delete" data-idc={id}><span class="glyphicon glyphicon-trash"></span></button></p></td>
</tr>
</tbody>
</table>

</div>
<div class="row">
<div class="col-xs-6">
<small>Showing {display} from total {total} data</small>
</div>
<div class="col-xs-6">
<!-- <nav aria-label="Page navigation">
<ul class="pagination pull-right">
<li class="disabled">
<a href="#" aria-label="Previous">
<span aria-hidden="true">&laquo;</span>
</a>
</li>
<li class="active"><a href="#">1</a></li>
<li><a href="#">2</a></li>
<li><a href="#">3</a></li>
<li><a href="#">4</a></li>
<li><a href="#">5</a></li>
<li>
<a href="#" aria-label="Next">
<span aria-hidden="true">&raquo;</span>
</a>
</li>
</ul>
</nav> -->

<nav aria-label="Page navigation">
  <ul class="pagination pull-right">
    <li each={pejing} class={status}><a href="#" class="goto_page" data-offset={offset}>{pNumber}</a></li>
  </ul>
</nav>

</div>

</div>

<div class="modal fade" id="new" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
<div class="modal-dialog">
<div class="modal-content">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
<h4 class="modal-title custom_align" id="Heading">New Data</h4>
</div>
<div class="modal-body">
<div class="form-group">
<input class="form-control " type="text" placeholder="Title" name="new_title" ref="new_title" required>
</div>
<div class="form-group">
<textarea rows="2" class="form-control" placeholder="Content" name="new_content" ref="new_content" required></textarea>
</div>
</div>
<div class="modal-footer ">
<button type="button" class="btn btn-success btn-lg" style="width: 100%;" id="new-data" onclick={add_deh}><span class="glyphicon glyphicon-ok-sign"></span> Input</button>
</div>
</div>
<!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="edit" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
<div class="modal-dialog">
<div class="modal-content">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
<h4 class="modal-title custom_align" id="Heading">Edit Your Detail</h4>
</div>
<div class="modal-body">
<div class="form-group">
<input class="form-control " type="text" placeholder="Title" value="{edit_title}" name="edit_title" ref="edit_title">
</div>
<div class="form-group">
<textarea rows="2" class="form-control" placeholder="Content" name="edit_content" ref="edit_content">{edit_content}</textarea>
</div>
</div>
<div class="modal-footer ">
<button type="button" class="btn btn-warning btn-lg" style="width: 100%;" id="update-data"><span class="glyphicon glyphicon-ok-sign"></span> Update</button>
</div>
</div>
<!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
<div class="modal-dialog">
<div class="modal-content">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
<h4 class="modal-title custom_align" id="Heading">Delete this entry</h4>
</div>
<div class="modal-body">
<div class="alert alert-danger"><span class="glyphicon glyphicon-warning-sign"></span> Are you sure you want to delete this Record?</div>
</div>
<div class="modal-footer ">
<button type="button" class="btn btn-success" id="delete-data"><span class="glyphicon glyphicon-ok-sign"></span> Yes</button>
<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> No</button>
</div>
</div>
<!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>

<script>
var self=this;
runMe(2,0);

//tombol NEW
add_deh(){
var title= self.refs.new_title;
var content= self.refs.new_content;
if(title.value=='' || content.value==''){
alert('No empty data!');
}else{
var dataNya = {'title':title.value,'content':content.value};
// console.log(JSON.stringify(dataNya));
$.ajax({
url: "https://rest-api.r10.co/articles",
type: "POST",
dataType: "application/json",
contentType: 'application/json; charset=utf-8',
data: JSON.stringify(dataNya),
success: function(respond) {
runMe(2,0);
$('#new').modal('hide');
title.value='';
content.value='';
},
error: function(){
runMe(2,0);
$('#new').modal('hide');
title.value='';
content.value='';
}

});
}}
//------------------------------

function runMe(limit,offset){
$.ajax({
url: "https://rest-api.r10.co/articles?limit="+limit+"&offset="+offset,
type: "GET",
success: function(resultData) {
var dataGot = resultData.data;
self.limit = limit;
self.total = resultData.total;
self.articles = dataGot;
self.update();
var totalDisplayed = $('td[title-idc]').length;
self.display = totalDisplayed;
// console.log(this.articles);

//-------------------------------------------------------
$("#mytable #checkall").click(function () {
if ($("#mytable #checkall").is(':checked')) {
$("#mytable input[type=checkbox]").each(function () {
$(this).prop("checked", true);
});

} else {
$("#mytable input[type=checkbox]").each(function () {
$(this).prop("checked", false);
});
}
});

$("[data-toggle=tooltip]").tooltip();
//-----------------------------------------------------------
$('.edit-btn').click(function(){
var idc = $(this).attr('data-idc');
self.edit_title = $('td[title-idc="'+idc+'"]').html();
self.edit_content = $('td[content-idc="'+idc+'"]').html();
self.id_data = idc;
self.update();
$('#edit').modal('show');
});

//tombol update-------------------------------------------
$('#update-data').click(function(){
  var title= self.refs.edit_title;
  var content= self.refs.edit_content;
  if(title.value=='' || content.value==''){
  alert('No empty data!');
  }else{

var dataNya = {'title':title.value,'content':content.value};
// console.log(JSON.stringify(dataNya));
$.ajax({
url: "https://rest-api.r10.co/articles/"+self.id_data,
type: "PUT",
dataType: "application/json",
contentType: 'application/json; charset=utf-8',
data: JSON.stringify(dataNya),
success: function(respond) {
runMe(2,0);
$('#edit').modal('hide');
},
error: function() {
runMe(2,0);
$('#edit').modal('hide');
}
});
}
});
//tombol delete---------------------------------------------
$('.delete-btn').click(function(){
var idc = $(this).attr('data-idc');
self.id_data=idc;
$('#delete').modal('show');
});

$('#delete-data').click(function(){
$.ajax({
url: "https://rest-api.r10.co/articles/"+self.id_data,
type: "DELETE",
success: function(respond) {
runMe(2,0);
$('#delete').modal('hide');
// console.log(respond.status)

}
});
});
//paging-----------------
function pagination(pageA){
  var totalPage = Math.ceil(self.total/self.limit);
  var nomer = [];
  for(page=0;page<totalPage;page++){
    var pNumber = page+1;
    var os = limit*page;
    if(pageA==os){
    var  status='active';
  }else{
    var status = '';
  }
nomer.push({'pNumber' :pNumber,'offset' :os,'status' :status});
  }
  // console.log(totalDisplayed);
  self.pejing=nomer;
  self.update();
}
pagination(offset);
//-------------------------------------
$('.goto_page').click(function(e){
  e.preventDefault();
  var offset=$(this).data('offset');
  runMe(2,offset)
})
//----------------------------------------------
},//close success articles
error : function(jqXHR, textStatus, errorThrown) {
},

timeout: 120000,
});
}


</script>

</article-list>
