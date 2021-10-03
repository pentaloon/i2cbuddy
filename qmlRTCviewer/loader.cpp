#include "loader.h"
#include "i2cdriver.h"

Loader::Loader(QObject *parent) :
    QObject(parent)
{
}

void Loader::i2cRead(const QString& port, const QString& address, const QString& offset, const QString& length, BinaryData* display)
{
    I2CDriver i2c;
    i2c_connect(&i2c, port.toLocal8Bit().data());
    if (!i2c.connected)
        qDebug() << "failed to connect via" << port;
    else
    {
        qDebug() << "connected to" << port;
        char data[(length.startsWith("0x")) ? length.toUInt(NULL, 16) : length.toUInt()];
        unsigned int devAddress = (address.startsWith("0x")) ? address.toUInt(NULL, 16) : address.toUInt();
        unsigned int registerOffset = (offset.startsWith("0x")) ? offset.toUInt(NULL, 16) : offset.toUInt();

        i2c_qread(&i2c, devAddress, registerOffset, data);

        // qDebug() << "output:" << data;
        // need to use fromRawData to avoid \00's terminate the sequence of chars prematurely
        const QByteArray qba = QByteArray::fromRawData(data,sizeof(data));
        // TODO: "out-of-the-box" the UI will not load data if contains less bytes than 16 !!
        display->load(qba);
    }


}
