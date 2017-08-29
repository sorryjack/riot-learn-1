<hello-form>
<formx onSubmit="{sayHello}">
<input type="text" name="greet">
<button onclick="{sayHello}">Say Hello</button>
</formx>
<h3>Hello {this.greeting}</h3>
<script type="text/javascript">
this.sayHello=function(){
this.greeting = this.refs.greet.value;
this.refs.greet.value='';
}
</script>
</hello-form>
