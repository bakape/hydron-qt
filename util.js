
function sourcePath(id, ext) {
	return "http://localhost:8010/files/" + id + "." + ext
}

function thumbPath(id, isPNG) {
	return "http://localhost:8010/thumbs/" + id + "." + (isPNG ? "png" : "jpg")
}
