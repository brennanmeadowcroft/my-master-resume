$(function() {
	$("#activity_tag_tokens").tokenInput("/tags.json", {
		crossDomain: false,
		prePopulate: $("#activity_tag_tokens").data("pre"),
		theme: "facebook",
		allowCustomEntry: true
	});
});