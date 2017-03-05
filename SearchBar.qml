import QtQuick 2.5
import QtQuick.Controls 1.4

TextField {
    placeholderText: "Search"

    onAccepted: function () {
        browser.loadThumbnails(searchBar.text.split(" "))
    }
}
