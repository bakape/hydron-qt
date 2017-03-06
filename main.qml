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

		RowLayout {
			anchors.fill: parent

			SearchBar {
				id: searchBar
				Layout.fillWidth: true
			}
		}
	}

	ScrollView {
		id: browserContainer
		anchors.fill: parent

		Browser {
			id: browser
			anchors.fill: parent
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
