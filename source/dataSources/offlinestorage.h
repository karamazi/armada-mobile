#ifndef OFFILINESTORAGE_H
#define OFFILINESTORAGE_H

#include <QObject>
#include "source/sharedStructs/clusterconfigdata.h"

class OfflineStorage : public QObject
{
    Q_OBJECT
public:
    explicit OfflineStorage(QObject *parent = nullptr);
    void loadSavedConfig();

signals:
    void savedClustersConfigLoaded(MultipleClustersConfigData data);

public slots:
    void onSaveClustersConfigRequested(MultipleClustersConfigData data);

private:
    const QString mConfigFileName = "config.dat";
    void loadClustersConfig();
};

#endif // OFFILINESTORAGE_H
