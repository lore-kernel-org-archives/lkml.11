Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4195AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 09:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243349AbiCWJx1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243337AbiCWJxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:53:23 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753804130B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:51:50 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D41251C0014;
        Wed, 23 Mar 2022 09:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648029108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkc1E79+EMhZIZKmqJGwa4SoDzH/uFspi1OYFAhWuYc=;
        b=HMp8G494ZGJ8dv9CWnZAwJMMWPisuRH0yVkrzEFNzrOQh1VkePeFTOqpe+gNKa2lUL9n7Z
        3MC0uZpNbQycqoWoF2zyncR1/nIjucleXnG2QyY53cDI+JDsigGjLFPFjDq6AAIVuaC4zj
        +TdEM4ETfIjLgHurt5U/Uz7CQu1FuCHj6KELK13dZvko+K9ePMc3K4Gz65XtAMS/QVTrI8
        JCOoU/CS48c7bgakubLn7IPMEhR8Pakabm7oMtaGDuea/FPAv4YMV6+PI5HJ0PYSCZNFok
        OBV9QbiljEECGZx3oD2jOOzt/BY9WUBJ57vFXu2WPzFgCblIXj2MvqwM+zS7vw==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH 1/2] of: add function to convert fwnode_reference_args to of_phandle_args
Date:   Wed, 23 Mar 2022 10:50:21 +0100
Message-Id: <20220323095022.453708-2-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220323095022.453708-1-clement.leger@bootlin.com>
References: <20220323095022.453708-1-clement.leger@bootlin.com>
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

