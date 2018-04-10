helpers
addEnd

	self writeText:
'	}
	mamani["',self uuid,'"]= new TRCanvas("',self uuid,'");
	$("#',self uuid,'").resize(function(){
		mamani["',self uuid,'"].camera.update();
	});
	$("#',self uuid,'").trigger("resize");
	$(document).ready(buildView',self uuid,'());
		</script>
	'.