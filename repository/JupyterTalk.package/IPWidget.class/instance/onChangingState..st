event-handling
onChangingState: aBlockWithOneArgument
	"argument is the changed property k and v"
	self listeners add:aBlockWithOneArgument 