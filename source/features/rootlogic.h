#ifndef ROOTLOGIC_H
#define ROOTLOGIC_H

#include <QObject>
#include "source/utils/autoproperty.h"

#include "source/features/cluster/clusterlogic.h"


class RootLogic : public QObject
{
    Q_OBJECT
    AUTO_PROPERTY(ClusterLogic*, clusterLogic)

public:
    explicit RootLogic(QObject *parent = 0);

signals:

public slots:
};

#endif // ROOTLOGIC_H
