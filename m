Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DA2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 14:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350861AbiCXOQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 10:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346422AbiCXOQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:16:21 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7E323BF6;
        Thu, 24 Mar 2022 07:14:30 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EAA5260007;
        Thu, 24 Mar 2022 14:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648131269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkc1E79+EMhZIZKmqJGwa4SoDzH/uFspi1OYFAhWuYc=;
        b=A4hfsUPHuso3uaMlSlxIu/mHGk3ZOEhgEN2cuMFyC6VOWBaLkUhmXfMscLAwSS2tL2sMaG
        hP+9PCgO7sbJ8NiVMJ3wuUYQMJp53lQizU+SQnFQtMzPBQb2GTET/1F6XEE3vgOeNDGw0L
        zYcU5mbHep9vLD8QcU3migoZv0+CioXo33O4XLUkOFFSs6KoykBXgNb8mJIb8q7B/nqhIG
        WtVZqzHa0x6wd68pJalW36tdM+gel2IkHJp8qKsgMk/n86AYjcLb8nSf+6wHxLNnfFnyx3
        pMSTkMIU+CnTvTSUKRbHG2PeWqy8b5lR874zHB2eNugoVUDA8ojh7ahGYdnlBQ==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH v2 1/3] of: add function to convert fwnode_reference_args to of_phandle_args
Date:   Thu, 24 Mar 2022 15:12:35 +0100
Message-Id: <20220324141237.297207-2-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220324141237.297207-1-clement.leger@bootlin.com>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add of_phandle_args_from_fwnode_reference_args() which convert a struct
fwnode_reference_args to an of_phandle_args. This is used to maintain
compatibility for device-tree specifiers translation functions that are
used by various subsystem.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 include/linux/of.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 2dc77430a91a..1f6c8927c5ff 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -175,6 +175,18 @@ static inline bool is_of_node(const struct fwnode_handle *fwnode)
 			&__of_fwnode_handle_node->fwnode : NULL;	\
 	})
 
+static inline void
+of_phandle_args_from_fwnode_reference_args(struct of_phandle_args *of_args,
+					   const struct fwnode_reference_args *fwnode_args)
+{
+	int i;
+
+	of_args->np = to_of_node(fwnode_args->fwnode);
+	of_args->args_count = fwnode_args->nargs;
+	for (i = 0; i < fwnode_args->nargs; i++)
+		of_args->args[i] = fwnode_args->args[i];
+}
+
 static inline bool of_have_populated_dt(void)
 {
 	return of_root != NULL;
@@ -543,6 +555,12 @@ static inline struct device_node *of_find_node_with_property(
 
 #define of_fwnode_handle(node) NULL
 
+static inline void
+of_phandle_args_from_fwnode_reference_args(struct of_phandle_args *of_args,
+					   const struct fwnode_reference_args *fwnode_args)
+{
+}
+
 static inline bool of_have_populated_dt(void)
 {
 	return false;
-- 
2.34.1

