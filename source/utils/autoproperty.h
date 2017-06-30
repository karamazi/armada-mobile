#ifndef QAUTOPROPERTY_H
#define QAUTOPROPERTY_H

#include <QList>
#include <QObject>
#include <QQmlListProperty>

#include <QQmlEngine>

// based on
// https://gist.github.com/Rolias/48d453a0490d36090193

#define AUTO_PROPERTY(TYPE, NAME) \
    Q_PROPERTY(TYPE NAME READ NAME WRITE NAME NOTIFY NAME ## Changed ) \
    public: \
       TYPE NAME() const { return a_ ## NAME ; } \
       void NAME(TYPE value) { \
          if (a_ ## NAME == value)  return; \
          a_ ## NAME = value; \
          emit NAME ## Changed(value); \
        } \
       Q_SIGNAL void NAME ## Changed(TYPE value);\
    private: \
       TYPE a_ ## NAME;

#define AUTO_PROPERTY_D(TYPE, NAME, DEFAULT) \
    Q_PROPERTY(TYPE NAME READ NAME WRITE NAME NOTIFY NAME ## Changed ) \
    public: \
       TYPE NAME() const { return a_ ## NAME ; } \
       void NAME(TYPE value) { \
          if (a_ ## NAME == value)  return; \
          a_ ## NAME = value; \
          emit NAME ## Changed(value); \
        } \
       Q_SIGNAL void NAME ## Changed(TYPE value);\
    private: \
       TYPE a_ ## NAME = DEFAULT;

#define READONLY_PROPERTY(TYPE, NAME) \
    Q_PROPERTY(TYPE NAME READ NAME CONSTANT ) \
    public: \
       TYPE NAME() const { return a_ ## NAME ; } \
    private: \
       void NAME(TYPE value) {a_ ## NAME = value; } \
       TYPE a_ ## NAME;



#define LIST_PROPERTY(TYPE, NAME) \
    Q_PROPERTY(QQmlListProperty<TYPE> NAME READ NAME NOTIFY NAME ## Changed) \
    public: \
        QQmlListProperty<TYPE> NAME() { return QQmlListProperty<TYPE>(this, a_ ## NAME ## Raw); } \
        QList<TYPE*> NAME ## Raw() const { return a_ ## NAME ## Raw; } \
        void NAME ## Add(TYPE* value) { \
            a_ ## NAME ## Raw.append(value); \
            emit NAME ## Changed(QQmlListProperty<TYPE>(this, a_ ## NAME ## Raw)); \
        } \
        void NAME ## Clear() { \
            a_ ## NAME ## Raw.clear(); \
            emit NAME ## Changed(QQmlListProperty<TYPE>(this, a_ ## NAME ## Raw)); \
        } \
        void NAME(QList<TYPE*> value) { \
            a_ ## NAME ## Raw = value; \
            emit NAME ## Changed(QQmlListProperty<TYPE>(this, a_ ## NAME ## Raw)); \
        } \
        Q_SIGNAL void NAME ## Changed(QQmlListProperty<TYPE> value); \
    private: \
        QList<TYPE*> a_ ## NAME ## Raw;


#define ARMADA_QML_NAMESPACE "sh.armada"
#define QML_REGISTER_UNCREATABLE_TYPE(TYPE) qmlRegisterUncreatableType<TYPE>(ARMADA_QML_NAMESPACE, 1, 0, #TYPE, "C++ only!");
#define QML_REGISTER_TYPE(TYPE) qmlRegisterType<TYPE>(ARMADA_QML_NAMESPACE, 1, 0, #TYPE);


#endif // QAUTOPROPERTY_H
