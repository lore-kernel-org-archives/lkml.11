Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60767C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 07:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiCCHiX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 02:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiCCHiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:38:17 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5EAC0E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 23:37:30 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z15so4054861pfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 23:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=57ObZ9WKBOQO5ZgrGoTV/jrO94u2pe+h4TWQl++STHc=;
        b=idmNsoY1ddXtmt3FmXVFqejj3RpLwXfGeI5a+wzMtJcy/YYj7+syJslAzlfhLRXQ6s
         fkU6qzwsF/bCuysC0RMpl/O67GBw8UEb8csqefSQP4lgI+FzSv/HVDiXnHLa2NYiIUMO
         5tM1RytJ54xysIGCfIEd5tDmer/Z7S0+n1kGZYIwGqxf5udcsBkekAWSNsFoaoKyYdfO
         Rv+lqaRnkPDfndDGawW5mHTyWI4fun38ZgcULvYy0gp0kq9i8NbxKGE7ilgShoJ4l+/z
         sQRtknJTH/w9DYyDXtYAg5+s+KEynjk6++ESQ1CmGflRRwFPexobLlRLhFBqruoQeqFn
         K2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=57ObZ9WKBOQO5ZgrGoTV/jrO94u2pe+h4TWQl++STHc=;
        b=6kLXPZbY3wYhcoWDHpBiAFdo6Ib2v2TV+69D85icLH72AWykz3y3Yvi2DcVBV/EED8
         FvxuJEx8AkruVjtZwzvW8QOfLkOaym54UgXtytWoNZGivBo0rlT1SuXX6KUoP3U2DEtX
         UMWHYPGBFEf7IFQIPjjdtVA84RoAZ0HqUVFr4K0q8IdfBd3Yo4GA7JXzdpuXLTaOKPcz
         Y5+49YqroA1hYtVn6MloSW/Esv4SZV30gVDqZNjnniuXSABt9k2rhjbtGgdEgqKPA+iO
         9I1LiqhNwAbytgF89RnA2zzauvnoazccKVWhcMT420CqIN80OYXP9WN1pnwXffEpflst
         nwtQ==
X-Gm-Message-State: AOAM533n4Ia/raAoE/3KIBc0wKyKe1sGxuSPNPgjxWLVVZsQ+UuWywvG
        xaw5MqrXEOdfWXXjqK3Apg==
X-Google-Smtp-Source: ABdhPJwv/YNHN2USXNi1ZngWvkj3bsZjlk1pBpv/VM2Tf8QZIgwnZJzwD0icIMh2x8/vU3Yxr0v5jg==
X-Received: by 2002:aa7:88d1:0:b0:4f3:6132:42e1 with SMTP id k17-20020aa788d1000000b004f3613242e1mr36875925pff.67.1646293049909;
        Wed, 02 Mar 2022 23:37:29 -0800 (PST)
Received: from sh08423pcu1.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z9-20020a655a49000000b00373459df190sm1228165pgs.35.2022.03.02.23.37.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2022 23:37:29 -0800 (PST)
From:   Bruce Chen <brucechen251@gmail.com>
To:     bruce.chen@unisoc.com, rogerq@kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, linux-kernel@vger.kernel.org
Cc:     orsonzhai@gmail.com, gengcixi@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com
Subject: [PATCH V1] extcon/usb: Remove disable irq operation in system sleep.
Date:   Thu,  3 Mar 2022 15:36:03 +0800
Message-Id: <1646292963-20570-1-git-send-email-brucechen251@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bruce Chen <bruce.chen@unisoc.com>

If disable vbus/id irq, it will lead to wakeup system fail
in unisoc platform. In unisoc platform, Irq enable and irq
wakeup are the same interrupt line. So remove disable vbus/id
irq operation is a way to solve the issue.

Signed-off-by: Bruce Chen <bruce.chen@unisoc.com>
---
 drivers/extcon/extcon-usb-gpio.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
index f2b65d9..40d967a 100644
--- a/drivers/extcon/extcon-usb-gpio.c
+++ b/drivers/extcon/extcon-usb-gpio.c
@@ -226,16 +226,6 @@ static int usb_extcon_suspend(struct device *dev)
 		}
 	}
 
-	/*
-	 * We don't want to process any IRQs after this point
-	 * as GPIOs used behind I2C subsystem might not be
-	 * accessible until resume completes. So disable IRQ.
-	 */
-	if (info->id_gpiod)
-		disable_irq(info->id_irq);
-	if (info->vbus_gpiod)
-		disable_irq(info->vbus_irq);
-
 	if (!device_may_wakeup(dev))
 		pinctrl_pm_select_sleep_state(dev);
 
@@ -267,11 +257,6 @@ static int usb_extcon_resume(struct device *dev)
 		}
 	}
 
-	if (info->id_gpiod)
-		enable_irq(info->id_irq);
-	if (info->vbus_gpiod)
-		enable_irq(info->vbus_irq);
-
 	queue_delayed_work(system_power_efficient_wq,
 			   &info->wq_detcable, 0);
 
-- 
1.9.1

