#ifndef INSTANCEMODEL_H
#define INSTANCEMODEL_H

#include <QObject>
#include "source/utils/autoproperty.h"

class InstanceModel : public QObject
{
    Q_OBJECT
    AUTO_PROPERTY(QString, id)
    AUTO_PROPERTY(QString, name)
    AUTO_PROPERTY(QString, status)

public:
    explicit InstanceModel(QObject *parent = 0);

signals:

public slots:
};

#endif // INSTANCEMODEL_H
