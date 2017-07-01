#include "clusterconnection.h"
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

ClusterConnection::ClusterConnection(QObject *parent) : QObject(parent)
{
    mNetworkManager = new QNetworkAccessManager(this);
    connect(mNetworkManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinished(QNetworkReply*)));
}

void ClusterConnection::onClusterInstancesListRequested(QString address){
    QString endpoint = QString("%1/list").arg(address);
    qDebug() << endpoint;
    get(endpoint);
}


void ClusterConnection::get(QString url){
    Q_ASSERT(url.indexOf("http") == 0);
    mNetworkManager->get(QNetworkRequest(QUrl(url)));
}

void ClusterConnection::replyFinished(QNetworkReply *reply)
{
    if(reply->error())
    {
        qDebug() << "HttpRequest::ERROR!";
        qDebug() << reply->errorString();
        emit clusterRequestError(reply->errorString());
    }
    else {
        QByteArray data = reply->readAll();
        if(data.isEmpty()){
            return;
        }

        QJsonObject response = QJsonDocument::fromJson(data).object();
        QString status = response["status"].toString();
        if(status != "ok")
        {
            QString error = response["error"].toString();
            qDebug() << "Armada API failed with error:";
            qDebug() << error;
            emit clusterRequestError(error);
            return; //TODO: emit connection error
        }
        QJsonArray instancesListJson = response["result"].toArray();
        InstancesListData instancesListData = InstancesListData::fromJson(instancesListJson);
        emit clusterInstancesListLoaded(instancesListData);
    }
}
