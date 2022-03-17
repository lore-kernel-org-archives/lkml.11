Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801ACC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 15:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbiCQPuD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbiCQPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:49:46 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C71E0A2;
        Thu, 17 Mar 2022 08:48:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 216E2E0152;
        Thu, 17 Mar 2022 08:48:20 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PXDfg9TV7vKz; Thu, 17 Mar 2022 08:48:19 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Angus Ainslie <angus@akkea.ca>,
        Hector Martin <marcan@marcan.st>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Subject: [PATCH 6/7] usb: typec: tipd: Add debugfs entries for customer use word
Date:   Thu, 17 Mar 2022 16:45:17 +0100
Message-Id: <20220317154518.4082046-7-sebastian.krzyszkowiak@puri.sm>
In-Reply-To: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
References: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guido Günther <agx@sigxcpu.org>

This allows to verify that a sane firmware is on the device.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/usb/typec/tipd/core.c | 65 +++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 874528b02a99..d3c70aaf1a0c 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -6,6 +6,7 @@
  * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
  */
 
+#include <linux/debugfs.h>
 #include <linux/i2c.h>
 #include <linux/acpi.h>
 #include <linux/module.h>
@@ -22,6 +23,7 @@
 /* Register offsets */
 #define TPS_REG_VID			0x00
 #define TPS_REG_MODE			0x03
+#define TPS_REG_CUSTOMER_USE		0x06
 #define TPS_REG_CMD1			0x08
 #define TPS_REG_DATA1			0x09
 #define TPS_REG_INT_EVENT1		0x14
@@ -99,10 +101,15 @@ struct tps6598x {
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
 	enum power_supply_usb_type usb_type;
+
 	struct tps6598x_pdo terms;
 
 	u32 data_status;
 	u16 pwr_status;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dev_dentry;
+	struct dentry *customer_user_dentry;
+#endif
 };
 
 static enum power_supply_property tps6598x_psy_props[] = {
@@ -239,6 +246,62 @@ static void tps6598x_set_data_role(struct tps6598x *tps,
 	typec_set_data_role(tps->port, role);
 }
 
+#ifdef CONFIG_DEBUG_FS
+static struct dentry *rootdir;
+
+static int tps6598x_debug_customer_use_show(struct seq_file *s, void *v)
+{
+	struct tps6598x *tps = (struct tps6598x *)s->private;
+	u64 mode64;
+	int ret;
+
+	mutex_lock(&tps->lock);
+
+	ret =  tps6598x_block_read(tps, TPS_REG_CUSTOMER_USE, &mode64, sizeof(mode64));
+	if (!ret)
+		seq_printf(s, "0x%016llx\n", mode64);
+
+	mutex_unlock(&tps->lock);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(tps6598x_debug_customer_use);
+
+static void tps6598x_debugfs_init(struct tps6598x *tps)
+{
+	struct dentry *dentry;
+
+	if (!rootdir)
+		rootdir = debugfs_create_dir("tps6598x", NULL);
+
+	dentry = debugfs_create_dir(dev_name(tps->dev), rootdir);
+	if (IS_ERR(dentry))
+		return;
+	tps->dev_dentry = dentry;
+
+	dentry = debugfs_create_file("customer_use",
+				     S_IFREG | 0444, tps->dev_dentry,
+				     tps, &tps6598x_debug_customer_use_fops);
+	if (IS_ERR(dentry))
+		return;
+	tps->customer_user_dentry = dentry;
+}
+
+static void tps6598x_debugfs_exit(struct tps6598x *tps)
+{
+	debugfs_remove(tps->customer_user_dentry);
+	debugfs_remove(tps->dev_dentry);
+	debugfs_remove(rootdir);
+	rootdir = NULL;
+}
+
+#else
+
+static void tps6598x_debugfs_init(const struct tps6598x *tps) { }
+static void tps6598x_debugfs_exit(const struct tps6598x *tps) { }
+
+#endif
+
 static int tps6598x_connect(struct tps6598x *tps, u32 status)
 {
 	struct typec_partner_desc desc;
@@ -995,6 +1058,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	}
 
 	i2c_set_clientdata(client, tps);
+	tps6598x_debugfs_init(tps);
 
 	return 0;
 
@@ -1011,6 +1075,7 @@ static int tps6598x_remove(struct i2c_client *client)
 {
 	struct tps6598x *tps = i2c_get_clientdata(client);
 
+	tps6598x_debugfs_exit(tps);
 	tps6598x_disconnect(tps, 0);
 	typec_unregister_port(tps->port);
 	usb_role_switch_put(tps->role_sw);
-- 
2.35.1

