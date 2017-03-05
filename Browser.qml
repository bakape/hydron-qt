import QtQuick 2.0
import QtQuick.Layouts 1.1
import "util.js" as Util

GridView {
	snapMode: GridView.SnapOneRow
	cellHeight: 152
	cellWidth: 152
	model: ListModel {}

	function loadThumbnails (ids) {
		var xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function () {
			if (xhr.readyState !== XMLHttpRequest.DONE
					|| xhr.status !== 200
					) {
				return
			}

			browser.model.clear()

			if (!xhr.responseText) {
				return
			}

			var data = JSON.parse(xhr.responseText)
			for (var i = 0; i < data.length; i++) {
				var model = data[i]
				model.sha1 = model.SHA1
				delete model.SHA1
				browser.model.append(model)
			}
		}
		xhr.open("GET", "http://localhost:8010/search/"
				 + ids.join(",")
				 + "?minimal=true")
		xhr.send()
	}

	delegate: Rectangle {
		height: 150
		width: 150
		color: "transparent"
		Image {
			anchors {
				horizontalCenter: parent.horizontalCenter
				verticalCenter: parent.verticalCenter
			}
			asynchronous: true
			sourceSize: "150x150"
			source: Util.thumbPath(sha1, thumbIsPNG)
		}
	}
}
