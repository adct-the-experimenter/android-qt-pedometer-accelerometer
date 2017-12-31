import QtQuick 2.4
import QtSensors 5.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.5

Item {
    id: item1
    width: 640
    height: 480
    property alias pauseCheckBox: pauseCheckBox
    property alias resetButton: resetButton
    property alias tanintercept_textinput: tanintercept_textinput
    property alias tanslope_textInput: tanslope_textInput

    Text
    {
        id: xread
        y: 89
        text: accelerometer_values.xaxis
        anchors.left: xtext.right
        anchors.leftMargin: 2
        font.pixelSize: 12
    }

    Text {
        id: xtext
        y: 89
        text: qsTr("x:")
        anchors.left: accelerometer_values_header.left
        anchors.leftMargin: 5
        font.pixelSize: 12
    }





    Text {
        id: ytext
        y: 110
        text: qsTr("y:")
        anchors.left: accelerometer_values_header.left
        anchors.leftMargin: 5
        font.pixelSize: 12
    }

    Text {
        id: yread
        y: 110
        text: accelerometer_values.yaxis
        anchors.left: ytext.right
        anchors.leftMargin: 2
        font.pixelSize: 12
    }

    Text {
        id: ztext
        y: 130
        text: qsTr("z:")
        anchors.left: accelerometer_values_header.left
        anchors.leftMargin: 5
        font.pixelSize: 12
    }

    Text {
        id: zread
        y: 130
        text: accelerometer_values.zaxis
        anchors.left: ztext.right
        anchors.leftMargin: 2
        font.pixelSize: 12
    }

    Text
    {
        id: accelerometer_values_header
        y: 69
        text: qsTr("Accelerometer Values")
        anchors.left: parent.left
        anchors.leftMargin: 6
        font.pixelSize: 12
    }

    Rectangle {
        id: xaxisrect
        y: 278
        width: 25
        height: rect_props.xRectHeight
        color: rect_props.xRectColor
        anchors.left: accelerometer_values_header.left
        anchors.leftMargin: 0
    }

    Rectangle {
        id: yaxisrect
        y: 278
        width: 25
        height: rect_props.yRectHeight
        color: rect_props.yRectColor
        anchors.left: xaxisrect.right
        anchors.leftMargin: 20
    }

    Rectangle {
        id: zaxisrect
        y: 278
        width: 25
        height: rect_props.zRectHeight
        color: rect_props.zRectColor
        anchors.left: yaxisrect.right
        anchors.leftMargin: 20
    }

    Text {
        id: xrecttext
        x: 17
        y: 248
        text: qsTr("x")
        anchors.horizontalCenter: xaxisrect.horizontalCenter
        anchors.bottom: xaxisrect.top
        anchors.bottomMargin: 15
        font.pixelSize: 12
    }

    Text {
        id: yrecttext
        x: 84
        y: 248
        text: qsTr("y")
        anchors.horizontalCenter: yaxisrect.horizontalCenter
        anchors.bottom: yaxisrect.top
        anchors.bottomMargin: 15
        font.pixelSize: 12
    }

    Text {
        id: zrecttext
        x: 160
        y: 248
        text: qsTr("z")
        anchors.bottom: zaxisrect.top
        anchors.bottomMargin: 15
        anchors.horizontalCenter: zaxisrect.horizontalCenter
        font.pixelSize: 12
    }

    Text {
        id: stepstext
        text: qsTr("Steps:")
        anchors.top: accelerometer_values_header.bottom
        anchors.topMargin: 90
        anchors.left: accelerometer_values_header.left
        anchors.leftMargin: 5
        font.pixelSize: 12
    }

    Text {
        id: stepsread
        x: 52
        y: 174
        text: accelerometer_values.step_count
        font.pixelSize: 12
    }

    Text {
        id: tanslopetext
        y: 201
        text: qsTr("tangent_slope(a):")
        anchors.left: accelerometer_values_header.left
        anchors.leftMargin: 5
        font.pixelSize: 12
    }

    Text {
        id: tanintercepttext
        y: 222
        text: qsTr("tangent_intercept(B):")
        anchors.left: accelerometer_values_header.left
        anchors.leftMargin: 5
        font.pixelSize: 12
    }

    TextInput {
        id: tanslope_textInput
        y: 201
        width: 211
        height: 20
        validator: DoubleValidator {bottom: -100; top: 100; decimals: 4;}
        focus: false
        text: "0"
        anchors.left: tanslopetext.right
        anchors.leftMargin: 5
        font.pixelSize: 12
    }

    TextInput {
        id: tanintercept_textinput
        y: 222
        width: 227
        height: 20
        validator: DoubleValidator {bottom: -100; top: 100; decimals: 4;}
        focus: false
        text: "0"
        anchors.left: tanintercepttext.right
        anchors.leftMargin: 5
        font.pixelSize: 12
    }

    Button {
        id: resetButton
        x: 132
        y: 248
        text: qsTr("Reset")
    }

    CheckBox {
        id: pauseCheckBox
        x: 132
        y: 284
        text: qsTr("Pause")
        checked: true
    }

    Text {
        id: threshold_eq
        y: 24
        text: qsTr("th = (a / (i-k)) + B")
        anchors.left: parent.left
        anchors.leftMargin: 8
        font.pixelSize: 12
    }

    Text {
        id: step_detect_text
        y: 48
        text: qsTr("1 step: max_accel_z - current_accel_z >= th")
        anchors.left: parent.left
        anchors.leftMargin: 8
        font.pixelSize: 12
    }





}
