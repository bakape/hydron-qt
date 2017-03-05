import QtQuick 2.5
import QtQml 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

TextField {
	id: searchBar
	placeholderText: "Search"

	onAccepted: browser.loadThumbnails(searchBar.text.split(" "))

	Component.onCompleted: searchBar.forceActiveFocus()

	Keys.onReleased: {

	}
}
