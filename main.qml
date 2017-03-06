import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

ApplicationWindow {
	id: window
	visible: true
	visibility: "Maximized"
	title: "hydron-qt"
	minimumWidth: 640
	minimumHeight: 480

	toolBar: ToolBar {
		focus: true
//		height: childrenRect.height

		RowLayout {
			anchors.fill: parent

			SearchBar {
				id: searchBar
				focus: true
				Layout.fillWidth: true
			}
		}
	}

	ScrollView {
		anchors.fill: parent

		Browser {
			id: browser
			anchors.fill: parent
			focus: true
		}
	}

	Item {
		id: overlay
		anchors.fill: parent

		MouseArea {
			enabled: false
		}

		ScrollView {
			ListView {
				id: suggestions
				anchors.leftMargin: 7
				anchors.fill: parent
				model: ListModel {}

				delegate: Rectangle {
					color: SystemPalette.base || "white"
					width: childrenRect.width
					height: childrenRect.height

					Text {
						text: tag
					}
				}
			}
		}
	}
}
