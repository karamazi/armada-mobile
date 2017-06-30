#ifndef INSTANCEDATA_H
#define INSTANCEDATA_H
#include <QObject>

struct InstanceData {
    QString microserviceName;
    QString microserviceId;
    QString status;
    QString env;
    QString appId;
};

#endif // INSTANCEDATA_H
