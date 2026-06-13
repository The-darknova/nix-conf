import QtQuick
import QtQuick.Controls
import Qt.labs.platform
import org.kde.kirigami as Kirigami
import org.kde.kquickcontrols as KQControls

Item {
    id: configRoot

    QtObject {
        id: unidWeatherValue
        property var value
    }

    ColorDialog {
        id: colorDialog
    }

    signal configurationChanged

    property alias cfg_temperatureUnit: unidWeatherValue.value
    property alias cfg_latitudeC: latitude.text
    property alias cfg_longitudeC: longitude.text
    property alias cfg_useCoordinatesIp: autamateCoorde.checked
    property alias cfg_colorHex: colorDialog.color

    Kirigami.FormLayout {
        width: parent.width

        ComboBox {
            textRole: "text"
            valueRole: "value"
            id: positionComboBox
            Kirigami.FormData.label: i18n("Temperature Unit:")
            model: [
                {text: i18n("Celsius (°C)"), value: 0},
                {text: i18n("Fahrenheit (°F)"), value: 1},
            ]
            onActivated: unidWeatherValue.value = currentValue
            Component.onCompleted: currentIndex = indexOfValue(unidWeatherValue.value)
        }

        CheckBox {
            id: autamateCoorde
            Kirigami.FormData.label: i18n('Use IP location')
        }
        TextField {
            id: latitude
            visible: !autamateCoorde.checked
            Kirigami.FormData.label: i18n("Latitude:")
            width: 200
        }
        TextField {
            id: longitude
            visible: !autamateCoorde.checked
            Kirigami.FormData.label: i18n("Longitude:")
            width: 200
        }
        KQControls.ColorButton {
            id: colorhex
            showAlphaChannel: true
            color: colorDialog.color
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    colorDialog.open()
                }
            }
        }
    }
}
