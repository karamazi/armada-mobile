#ifndef CLUSTERCONNECTION_H
#define CLUSTERCONNECTION_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

#include "source/sharedStructs/instanceslistdata.h"

class ClusterConnection : public QObject
{
    Q_OBJECT
public:
    explicit ClusterConnection(QObject *parent = 0);

signals:
    void clusterInstancesListLoaded(InstancesListData data);

public slots:
    void onClusterInstancesListRequested(QString address);

private:
    QNetworkAccessManager* mNetworkManager;

    void get(QString url);
    Q_SLOT void replyFinished(QNetworkReply*);

};

#endif // CLUSTERCONNECTION_H
