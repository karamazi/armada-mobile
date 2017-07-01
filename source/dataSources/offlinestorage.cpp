#include "offlinestorage.h"
#include "iso646.h"

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QFile>

#include <QDebug>


OfflineStorage::OfflineStorage(QObject *parent) : QObject(parent)
{

}

void OfflineStorage::loadSavedConfig()
{
    loadClustersConfig();
}

void OfflineStorage::onSaveClustersConfigRequested(MultipleClustersConfigData data)
{
    QJsonArray json;
    for(ClusterConfigData ccd : data.clusters)
    {
        QJsonObject clusterObjectJson;
        clusterObjectJson["name"] = ccd.name;
        clusterObjectJson["address"] = ccd.address;
        json.append(clusterObjectJson);
    }
    QByteArray stringData = QJsonDocument(json).toJson(QJsonDocument::Compact);
    QFile saveFile(mConfigFileName);
    saveFile.open(QFile::WriteOnly);
    saveFile.write(stringData);
    saveFile.close();
}

void OfflineStorage::loadClustersConfig()
{
    QFile loadFile(mConfigFileName);
    if(!loadFile.exists())
    {
        return;
    }

    loadFile.open(QFile::ReadOnly);
    QByteArray loadedData = loadFile.readAll();
    QJsonArray clustersData = QJsonDocument::fromJson(loadedData).array();

    MultipleClustersConfigData data;
    for(auto clusterJsonDataRef : clustersData)
    {
        ClusterConfigData cdd;
        QJsonObject clusterJsonData = clusterJsonDataRef.toObject();
        cdd.address = clusterJsonData["address"].toString();
        cdd.name = clusterJsonData["name"].toString();
        data.clusters.append(cdd);
    }
    emit savedClustersConfigLoaded(data);
}
