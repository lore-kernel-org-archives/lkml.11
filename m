Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06141C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 22:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbiBWWxe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244641AbiBWWx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:53:29 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BDF55BCF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:53:01 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so769086oos.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nL2QpZnKV3HxTzcFT7bRBaCkmb2XkZapooy7SlCYZSs=;
        b=f3be7ok1af1OmW3b8kFKfU363rbwOptxnTXohjbiZT4jEc3ll39O/cV2YLYdtj8usW
         Zu72iUGdJF+bX0xRVYT3rogfH4E4CNL06gEbjwvEtUlNOvjUy1zphdkFPtbD9vIZTV33
         dfLLhTpfFsd2CWwVFJWu3RmZl6mRF66QMs2XzoItX7FDXY4BnmJ11H9K9OzhGFCS1Y3o
         K8Mxwkn7eYSMZyj0Ene2WYGBeNhhrk9Ls6jh+OAr3YFEJWZdRs4ykgLi/n3BDGeXN3Zo
         uemv7oAF8z4eUuJxrSbPUjPF5TEH+G9Hk5xa3oKsnKKYS1DP4dtCey2Lp8FjbjAvshWj
         pOIA==
X-Gm-Message-State: AOAM532zDT2xB8hpANwAFd1UaD0Ua3TGevVeqh4rEMjP0YCZNROjpAle
        kXmq5Ax6GythyubIprR53g==
X-Google-Smtp-Source: ABdhPJzWW1gt3Gvu3LnDr6//KD6EUkqtDm/uZivcsQuup0ijp122gNy2thVrToOoVsgDzk0Zxg6aPQ==
X-Received: by 2002:a05:6870:3c19:b0:d1:a765:c020 with SMTP id gk25-20020a0568703c1900b000d1a765c020mr878341oab.18.1645656780647;
        Wed, 23 Feb 2022 14:53:00 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id y15sm398775oof.37.2022.02.23.14.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 14:52:59 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] driver core: Refactor multiple copies of device cleanup
Date:   Wed, 23 Feb 2022 16:52:56 -0600
Message-Id: <20220223225257.1681968-2-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223225257.1681968-1-robh@kernel.org>
References: <20220223225257.1681968-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 3 copies of the same device cleanup code used for probe failure,
testing re-probing, and device unbinding. Changes to this code often miss
at least one of the copies of the code. See commits d0243bbd5dd3 ("drivers
core: Free dma_range_map when driver probe failed") and d8f7a5484f21
("driver core: Free DMA range map when device is released") for example.

Let's refactor the code to its own function.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/base/dd.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f47cab21430f..19bae32955c1 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -506,6 +506,19 @@ static ssize_t state_synced_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(state_synced);
 
+static void device_unbind_cleanup(struct device *dev)
+{
+	devres_release_all(dev);
+	arch_teardown_dma_ops(dev);
+	kfree(dev->dma_range_map);
+	dev->dma_range_map = NULL;
+	dev->driver = NULL;
+	dev_set_drvdata(dev, NULL);
+	if (dev->pm_domain && dev->pm_domain->dismiss)
+		dev->pm_domain->dismiss(dev);
+	pm_runtime_reinit(dev);
+	dev_pm_set_driver_flags(dev, 0);
+}
 
 static int call_driver_probe(struct device *dev, struct device_driver *drv)
 {
@@ -628,16 +641,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		else if (drv->remove)
 			drv->remove(dev);
 
-		devres_release_all(dev);
-		arch_teardown_dma_ops(dev);
-		kfree(dev->dma_range_map);
-		dev->dma_range_map = NULL;
 		driver_sysfs_remove(dev);
-		dev->driver = NULL;
-		dev_set_drvdata(dev, NULL);
-		if (dev->pm_domain && dev->pm_domain->dismiss)
-			dev->pm_domain->dismiss(dev);
-		pm_runtime_reinit(dev);
+		device_unbind_cleanup(dev);
 
 		goto re_probe;
 	}
@@ -667,16 +672,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
 pinctrl_bind_failed:
 	device_links_no_driver(dev);
-	devres_release_all(dev);
-	arch_teardown_dma_ops(dev);
-	kfree(dev->dma_range_map);
-	dev->dma_range_map = NULL;
-	dev->driver = NULL;
-	dev_set_drvdata(dev, NULL);
-	if (dev->pm_domain && dev->pm_domain->dismiss)
-		dev->pm_domain->dismiss(dev);
-	pm_runtime_reinit(dev);
-	dev_pm_set_driver_flags(dev, 0);
+	device_unbind_cleanup(dev);
 done:
 	return ret;
 }
@@ -1209,17 +1205,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 			drv->remove(dev);
 
 		device_links_driver_cleanup(dev);
-
-		devres_release_all(dev);
-		arch_teardown_dma_ops(dev);
-		kfree(dev->dma_range_map);
-		dev->dma_range_map = NULL;
-		dev->driver = NULL;
-		dev_set_drvdata(dev, NULL);
-		if (dev->pm_domain && dev->pm_domain->dismiss)
-			dev->pm_domain->dismiss(dev);
-		pm_runtime_reinit(dev);
-		dev_pm_set_driver_flags(dev, 0);
+		device_unbind_cleanup(dev);
 
 		klist_remove(&dev->p->knode_driver);
 		device_pm_check_callbacks(dev);
-- 
2.32.0

