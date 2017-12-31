/****************************************************************************
 **
 ** Copyright (C) 2015 The Qt Company Ltd.
 ** Contact: http://www.qt.io/licensing/
 **
 ** This file is part of the QtSensors module of the Qt Toolkit.
 **
 ** $QT_BEGIN_LICENSE:BSD$
 ** You may use this file under the terms of the BSD license as follows:
 **
 ** "Redistribution and use in source and binary forms, with or without
 ** modification, are permitted provided that the following conditions are
 ** met:
 **   * Redistributions of source code must retain the above copyright
 **     notice, this list of conditions and the following disclaimer.
 **   * Redistributions in binary form must reproduce the above copyright
 **     notice, this list of conditions and the following disclaimer in
 **     the documentation and/or other materials provided with the
 **     distribution.
 **   * Neither the name of The Qt Company Ltd nor the names of its
 **     contributors may be used to endorse or promote products derived
 **     from this software without specific prior written permission.
 **
 **
 ** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 ** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 ** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 ** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 ** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 ** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 ** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 ** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 ** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 ** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 ** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 **
 ** $QT_END_LICENSE$
 **
 ****************************************************************************/

 import QtQuick 2.1
 import QtQuick.Controls 1.0
 import QtQuick.Dialogs 1.2 //for MessageDialog type
 import QtSensors 5.0 //for Accelerometer type

 import com.vas.specialaccelpedometer 1.0 //for SpecialAccelPedometer

 ApplicationWindow
 {
     title: "Accelerometer Pedometer"
     id: mainWindow
     width: 320
     height: 480
     visible: true


     SpecialAccelPedometer
     {
        id:accel_pedometer
        dataRate: 100
        active: true

        //if accelerometer reading is changed
        onReadingChanged:
        {
            //if step count is not paused
            if(accelerometer_values.stepCountPaused == false)
            {
                //update display variables for x,y,z values of accelerometer
                accelerometer_values.xaxis = accel_pedometer.reading.x
                accelerometer_values.yaxis = accel_pedometer.reading.y
                accelerometer_values.zaxis = accel_pedometer.reading.z
                //update rect_prop variables
                rect_props.setXRectProp(accel_pedometer.reading.x)
                rect_props.setYRectProp(accel_pedometer.reading.y)
                rect_props.setZRectProp(accel_pedometer.reading.z)

                //run step count algorithm
                accel_pedometer.runQMLStepCountAlgorithm()
            }
        }

        //if step count is incremented or changed in any way
        onStepCountChanged:
        {
            accelerometer_values.step_count = accel_pedometer.stepCount //update display variable for step count
        }
     }



     //qt object to contain accelerometer values to display
     //referred to by id accelerometer_values
     QtObject
     {
         id:accelerometer_values
         //x,y,z axis values
         property string xaxis: "0"
         property string yaxis: "0"
         property string zaxis: "0"
         //step count
         property string step_count: "0"

         property bool stepCountPaused: true
     }
    //qt object to contain heights of rectangles for x axis, y axis, z axis
     //and their colors
    //referred to by id rect_props
    QtObject
    {
        id:rect_props

        //x axis rectangle properties
        property double xRectHeight: 35
        property color xRectColor: "#FFFFFF"

        //y axis rectangle properties
        property double yRectHeight: 35
        property color yRectColor: "#FFFFFF"

        //z axis rectangle properties
        property double zRectHeight: 35
        property color zRectColor: "#FFFFFF"

        //function to set height and color of x axis rectangle
        function setXRectProp(xvalue)
        {
            //if x is negative, set color to red and set height to positive xvalue
            if(xvalue < 0)
            {
                rect_props.xRectColor = "#FF0000"
                rect_props.xRectHeight = xvalue * -10
            }
            //else set color to green and height to xvalue
            else
            {
                rect_props.xRectColor = "#006600"
                rect_props.xRectHeight = xvalue * 10
            }
        }

        //function to set height and color of y axis rectangle
        function setYRectProp(yvalue)
        {
            //if y is negative, set color to red and set height to positive yvalue
            if(yvalue < 0)
            {
                rect_props.yRectColor = "#FF0000"
                rect_props.yRectHeight = yvalue * -10
            }
            //else set color to green and height to yvalue
            else
            {
                rect_props.yRectColor = "#006600"
                rect_props.yRectHeight = yvalue * 10
            }
        }

        //function to set height and color of z axis rect
        function setZRectProp(zvalue)
        {
            //if z is negative, set color to red and set height to positive zvalue
            if(zvalue < 0)
            {
                rect_props.zRectColor = "#FF0000"
                rect_props.zRectHeight = zvalue * -10
            }
            //else set color to green and height to zvalue
            else
            {
                rect_props.zRectColor = "#006600"
                rect_props.zRectHeight = zvalue * 10
            }
        }

    }// end QTObject rect_props


     //Main display inside application not including menu bar
     MainForm
     {
         anchors.fill: parent

         //if pauseCheckBox is clicked
          pauseCheckBox.onClicked:
          {
              if(pauseCheckBox.checkedState == Qt.Checked){accelerometer_values.stepCountPaused = true;}
              else{accelerometer_values.stepCountPaused = false;}
          }

         //when done editing, return or enter pressed and focus lost
         tanintercept_textinput.onAccepted:
         {
             //assign text input to pedometer tan intercept
             accel_pedometer.tangent_line_y_intercept = parseFloat(tanintercept_textinput.text);
             tanintercept_textinput.focus = false; //set text input focus to false
         }

         tanslope_textInput.onAccepted:
         {
             //assign text input to pedometer tan slope
             accel_pedometer.tangent_line_slope = parseFloat(tanslope_textInput.text);
             tanslope_textInput.focus = false; //set text input focus to false
         }
        //if reset button clicked
         resetButton.onClicked:
         {
             accel_pedometer.resetStepCount(); //reset step count
             accelerometer_values.step_count = "0"; //reset display variable for step count
         }


     }

}
