import QtQuick 2.5
import QtQuick.Layouts 1.1
import "util.js" as Util

GridView {
	snapMode: GridView.SnapToRow
	cellHeight: 155
	cellWidth: 155
	model: ListModel {}
	highlight: highlight
	focus: true
	activeFocusOnTab: true

	function loadThumbnails (ids) {
		var xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function () {
			if (xhr.readyState !== XMLHttpRequest.DONE
					|| xhr.status !== 200
					) {
				return
			}

			model.clear()

			if (!xhr.responseText) {
				return
			}

			var data = JSON.parse(xhr.responseText)
			for (var i = 0; i < data.length; i++) {
				var file = data[i]
				file.sha1 = file.SHA1
				model.append(file)
			}
		}
		xhr.open("GET", "http://localhost:8010/search/"
				 + ids.join(",")
				 + "?minimal=true")
		xhr.send()
	}

	delegate: Rectangle {
		height: 155
		width: 155
		color: "transparent"
		Image {
			anchors {
				horizontalCenter: parent.horizontalCenter
				verticalCenter: parent.verticalCenter
			}
			asynchronous: true
			sourceSize: "150x150"
			source: Util.thumbPath(sha1, thumbIsPNG)
			focus: true
		}
	}

	Component {
		id: highlight

		Rectangle {
			width: cellWidth
			height: cellHeight
			color: SystemPalette.highlight || "lightsteelblue"
			radius: 5
			x: currentItem.x
			y: currentItem.y

			Behavior on x {
				SpringAnimation {}
			}

			Behavior on y {
				SpringAnimation {}
			}
		}
	}

	Keys.onPressed: {
		if (event.modifiers & Qt.MetaModifier) {
			return
		}
		switch (event.key) {
		case Qt.Key_Up:
			moveCurrentIndexUp()
			break
		case Qt.Key_Down:
			moveCurrentIndexDown()
			break
		case Qt.Key_Left:
			moveCurrentIndexLeft()
			break
		case Qt.Key_Right:
			moveCurrentIndexRight()
			break
		case Qt.Key_Home:
			positionViewAtBeginning()
			break
		case Qt.Key_End:
			positionViewAtEnd()
			break
		}
	}

	MouseArea {
		anchors.fill: parent
		acceptedButtons: Qt.LeftButton

		onClicked: {
			forceActiveFocus()
			select(indexAt(mouse.x, mouse.y + contentY))
		}
	}

	function select(i) {
		currentIndex = i
	}
}
