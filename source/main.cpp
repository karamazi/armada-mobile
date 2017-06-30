#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "source/aramdaapplication.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    ArmadaApplication app(argc, argv);
    return app.exec();
}
