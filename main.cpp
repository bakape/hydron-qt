#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QProcess>
#include <QStringList>

int main(int argc, char *argv[])
{
    // Start backend
    QProcess hydron;
    hydron.start("hydron", QStringList() << "serve");

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    if (!hydron.waitForStarted(5000)) {
        return 1;
    }

    int ret = app.exec();
    hydron.terminate();
    return ret;
}
