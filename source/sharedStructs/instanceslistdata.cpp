#include "instanceslistdata.h"

#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>

InstancesListData InstancesListData::fromJson(QJsonArray json)
{
    InstancesListData data;
    for(auto instanceJson : json)
    {
        QJsonObject instanceObject = instanceJson.toObject();
        //qDebug() << instanceObject;

        InstanceData instanceData;
        instanceData.microserviceId = instanceObject["microservice_id"].toString();
        instanceData.microserviceName = instanceObject["name"].toString();
        instanceData.status = instanceObject["status"].toString();

        QJsonObject tagsObject = instanceObject["tags"].toObject();
        instanceData.env = tagsObject["env"].toString();
        instanceData.appId = tagsObject["app_id"].toString();
        data.instances.append(instanceData);
    }

    return data;
}
