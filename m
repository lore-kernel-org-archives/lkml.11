Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413A7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 14:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347211AbiDKOTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 10:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347451AbiDKOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:18:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AEA1116E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Qyqf1uPVPL3PyVQKl1EmiPuwTiU5LR+HZ4CfCVyTJz8=; b=bPTLtmiIav25Jb/guwqSFV28jI
        g+lhC3HZR3otZTAAAWozFHObmyxDwt/p/mfL4umlrak2wG9t18Rfh2t+cwKgs4HQ/iXTfXJO0mODZ
        dXeOnNnr2/WVWZkrvZEwwY4bnWGQw3FYlwjXgePq9gMxAk0ZQnfPaGjD8a3f0X5Xt5iyIoeNxa2t7
        s7r3hcJCJs7M04QPJEym6zMfjLvYd/PanwrO+V8A4d8veVWDeQkGi3KjSeCyYzIBCk3oC7hGJZDy/
        wl/HnlJ3Agnr1Gf8B34nq1Qfrl2WAi/3PQ2MEnndpaY4FrRZAzjDM81/G99Bc5X8uRYJomuOcJLJD
        +l5hjY3Q==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndupW-009L0x-1k; Mon, 11 Apr 2022 14:15:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 33/34] vfio/mdev: Use the driver core to create the 'remove' file
Date:   Mon, 11 Apr 2022 16:14:02 +0200
Message-Id: <20220411141403.86980-34-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411141403.86980-1-hch@lst.de>
References: <20220411141403.86980-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

The device creator is supposed to use the dev.groups value to add sysfs
files before device_add is called, not call sysfs_create_files() after
device_add() returns. This creates a race with uevent delivery where the
extra attribute will not be visible.

This was being done because the groups had been co-opted by the mdev
driver, now that prior patches have moved the driver's groups to the
struct device_driver the dev.group is properly free for use here.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/vfio/mdev/mdev_core.c    |  1 +
 drivers/vfio/mdev/mdev_private.h |  2 ++
 drivers/vfio/mdev/mdev_sysfs.c   | 19 ++++++++++---------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 19a20ff420b7f..b8b9e7911e559 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -269,6 +269,7 @@ int mdev_device_create(struct mdev_type *type, const guid_t *uuid)
 	mdev->dev.parent  = parent->dev;
 	mdev->dev.bus = &mdev_bus_type;
 	mdev->dev.release = mdev_device_release;
+	mdev->dev.groups = mdev_device_groups;
 	mdev->type = type;
 	/* Pairs with the put in mdev_device_release() */
 	kobject_get(&type->kobj);
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index 5a7ffd4e770fd..7c9fc79f3d838 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -32,6 +32,8 @@ struct mdev_type {
 	unsigned int type_group_id;
 };
 
+extern const struct attribute_group *mdev_device_groups[];
+
 #define to_mdev_type_attr(_attr)	\
 	container_of(_attr, struct mdev_type_attribute, attr)
 #define to_mdev_type(_kobj)		\
diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
index 5a3873d1a275a..0ccfeb3dda245 100644
--- a/drivers/vfio/mdev/mdev_sysfs.c
+++ b/drivers/vfio/mdev/mdev_sysfs.c
@@ -244,11 +244,20 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_WO(remove);
 
-static const struct attribute *mdev_device_attrs[] = {
+static struct attribute *mdev_device_attrs[] = {
 	&dev_attr_remove.attr,
 	NULL,
 };
 
+static const struct attribute_group mdev_device_group = {
+	.attrs = mdev_device_attrs,
+};
+
+const struct attribute_group *mdev_device_groups[] = {
+	&mdev_device_group,
+	NULL
+};
+
 int mdev_create_sysfs_files(struct mdev_device *mdev)
 {
 	struct mdev_type *type = mdev->type;
@@ -262,15 +271,8 @@ int mdev_create_sysfs_files(struct mdev_device *mdev)
 	ret = sysfs_create_link(kobj, &type->kobj, "mdev_type");
 	if (ret)
 		goto type_link_failed;
-
-	ret = sysfs_create_files(kobj, mdev_device_attrs);
-	if (ret)
-		goto create_files_failed;
-
 	return ret;
 
-create_files_failed:
-	sysfs_remove_link(kobj, "mdev_type");
 type_link_failed:
 	sysfs_remove_link(mdev->type->devices_kobj, dev_name(&mdev->dev));
 	return ret;
@@ -280,7 +282,6 @@ void mdev_remove_sysfs_files(struct mdev_device *mdev)
 {
 	struct kobject *kobj = &mdev->dev.kobj;
 
-	sysfs_remove_files(kobj, mdev_device_attrs);
 	sysfs_remove_link(kobj, "mdev_type");
 	sysfs_remove_link(mdev->type->devices_kobj, dev_name(&mdev->dev));
 }
-- 
2.30.2

