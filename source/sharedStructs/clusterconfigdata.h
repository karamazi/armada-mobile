#ifndef CLUSTERCONFIGDATA_H
#define CLUSTERCONFIGDATA_H

#include <QObject>

struct ClusterConfigData {
    QString name;
    QString address;
};

// ClustersConfigData is easy to missspell
struct MultipleClustersConfigData {
    QList<ClusterConfigData> clusters;
};

#endif // CLUSTERCONFIGDATA_H
