#include "loader.h"
#include "i2cdriver.h"

Loader::Loader(QObject *parent) :
    QObject(parent)
{
}

void Loader::loadFile(const QString& file, BinaryData* display)
{
    const char* port = "/dev/ttyUSB0";
    I2CDriver i2c;

        i2c_connect(&i2c, port);
        if (!i2c.connected)
        {
            qDebug() << "failed to connect via" << port;
        }
        else
        {
            char data[64];
            qDebug() << "connected to" << port;
            i2c_qread(&i2c, 0x68, "0x0", data);
            // qDebug() << "output:" << data;
            // need to use fromRawData to avoid \00's terminate the sequence of chars prematurely
            const QByteArray qba = QByteArray::fromRawData(data,sizeof(data));
            // TODO: "out-of-the-box" the UI will not load data if contains less bytes than 16 !!
            display->load(qba);
        }


}
