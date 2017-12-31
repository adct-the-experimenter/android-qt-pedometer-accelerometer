#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QtQml> //for qmlRegisterType

#include "specialaccelerometerpedometer.h" //for QAccelerometer derivative SpecialAccelerometerPedometer

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    //Register SpecialAccelerometerPedometer class derived from QAccelerometer as qml type
    //call with import com.vas.specialaccelpedometer 1.0
    //qmlName is SpecialAccelPedometer
    qmlRegisterType<SpecialAccelerometerPedometer>("com.vas.specialaccelpedometer", 1, 0, "SpecialAccelPedometer");

    //SpecialAccelerometerPedometer accelPedometer;
    //engine.rootContext()->setContextProperty("SpecialAccelPedometer",&accelPedometer);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
