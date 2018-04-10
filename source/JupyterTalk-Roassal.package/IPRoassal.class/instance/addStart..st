helpers
addStart: aView

	self writeText: 
	'
	<div id="', self uuid ,'">
	</div>
		<style type="text/css">
			body, svg { 
				margin: 0;
				padding: 0;
				-moz-user-select:-moz-none;
				-moz-user-select: none;
				-o-user-select: none;
				-khtml-user-select:none;
				-webkit-user-select:none;
				-ms-user-select:none;
				user-select:none;
			}
			text{
				cursor: default;
			}
		</style>
		<script type="text/javascript">
	
function buildView',self uuid,'() {
	'. 