$(document).ready(function() {
	$(".tag-field").hide();
	$(".skill-field").hide();

	$(".item-tags h3").click(function() {
		$(".tag-field").animate({
			height: 'toggle'
		}, 1000);
	});
	$(".item-skills h3").click(function() {
		$(".skill-field").animate({
			height: 'toggle'
		}, 1000);
	});
	
	$('#activity_skill_tokens').tokenInput('/skills.json', {
		theme: 'facebook',
		prePopulate: $('#activity_skill_tokens').data('load'),
		propertyToSearch: 'description',
		preventDuplicates: true
	});

	$('#activity_tag_tokens').tokenInput('/tags.json', {
		theme: 'facebook',
		prePopulate: $('#activity_tag_tokens').data('load'),
		propertyToSearch: 'description',
		preventDuplicates: true
	});
});