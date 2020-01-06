#include "aboutdialog.h"
#include "ui_aboutdialog.h"
#include "clientmodel.h"

#include "util.h"
#include "version.h"

AboutDialog::AboutDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::AboutDialog)
{
    ui->setupUi(this);

    QString version = QString::fromStdString(FormatAboutVersion());
    ui->versionLabel->setText(version);

    QRegExp mailto("<mailto:(.*)>", Qt::CaseSensitive, QRegExp::RegExp2);
    mailto.setMinimal(true);

    QString copyrightInfo = QString::fromStdString(FormatCopyright());
    copyrightInfo.replace(mailto, "&lt;<a href=\"mailto:\\1\">\\1</a>&gt;");
    copyrightInfo.replace("\n", "<br>");

    QRegExp uri("<(.*)>", Qt::CaseSensitive, QRegExp::RegExp2);
    uri.setMinimal(true);

    QString licenseInfo = QString::fromStdString(FormatLicense());
    licenseInfo.replace(uri, "<a href=\"\\1\">\\1</a>");
    licenseInfo.replace("\n", "<br>");

    ui->copyrightLabel->setText(copyrightInfo + "<br><br>" + licenseInfo);
}

void AboutDialog::setModel(ClientModel *model)
{
}

AboutDialog::~AboutDialog()
{
    delete ui;
}

void AboutDialog::on_buttonBox_accepted()
{
    close();
}
