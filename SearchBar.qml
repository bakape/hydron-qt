import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4

TextField {
	Layout.fillWidth: true
	placeholderText: "Search"

	onAccepted: browser.loadThumbnails(searchBar.text.split(" "))
	Component.onCompleted: searchBar.forceActiveFocus()

	Keys.onReleased: {
		suggestions.model.clear()
		switch (event.key) {
		case Qt.Key_Return:
		case Qt.Key_Escape:
		case Qt.Key_Tab:
			return
		}

		var i = searchBar.text.lastIndexOf(" ")
		if (i === searchBar.text.length - 1) {
			return
		}
		var url = "http://localhost:8010/complete_tag/"
				+ searchBar.text.slice(i + 1)

		var xhr = new XMLHttpRequest()
		xhr.onreadystatechange = function () {
			if (xhr.readyState !== XMLHttpRequest.DONE
					|| xhr.status !== 200
					|| !xhr.responseText) {
				return
			}

			// Need to clear again, because this callback
			// is asynchrounous
			suggestions.model.clear()
			var data = JSON.parse(xhr.responseText).sort()
			for (var i = 0; i < data.length; i++) {
				suggestions.model.append({tag: data[i]})
			}
		}
		xhr.open("GET", url)
		xhr.send()
	}
}
