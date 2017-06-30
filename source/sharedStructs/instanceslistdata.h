#ifndef INSTANCESLISTDATA_H
#define INSTANCESLISTDATA_H
#include "instancedata.h"

struct InstancesListData {
    QList<InstanceData> instances;

    static InstancesListData fromJson(QJsonArray json);
};

#endif // INSTANCESLISTDATA_H
