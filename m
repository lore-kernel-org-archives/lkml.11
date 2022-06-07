Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2765ACCA48A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 17:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348490AbiFGRk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347629AbiFGRaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:30:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94EA100539;
        Tue,  7 Jun 2022 10:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C0D26137B;
        Tue,  7 Jun 2022 17:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5942DC385A5;
        Tue,  7 Jun 2022 17:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654622863;
        bh=YgQ6cG9ycguXV3vG1QTl0qpiSjRDeFpJeg9BCSKj0Gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8TeRNJ4N34Pwio2LXM2PUfdeO2ZhVpHa/G97Pb2B0FvMaKtX73yfMQSkJtJMffO6
         bXuc9oTSgqQOFg7AK7fp9Ge3nbiHfA2QiiqYrWis3q8IZWV/v6iJSUclO5OEAmGOtI
         ZrI6c04gfNrHTcX5J/tytJHniw7KVnALkqVJfX28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 211/452] media: st-delta: Fix PM disable depth imbalance in delta_probe
Date:   Tue,  7 Jun 2022 19:01:08 +0200
Message-Id: <20220607164914.850220324@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164908.521895282@linuxfoundation.org>
References: <20220607164908.521895282@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 94e3dba710fe0afc772172305444250023fc2d30 ]

The pm_runtime_enable will decrease power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: f386509e4959 ("[media] st-delta: STiH4xx multi-format video decoder v4l2 driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Acked-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/sti/delta/delta-v4l2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sti/delta/delta-v4l2.c b/drivers/media/platform/sti/delta/delta-v4l2.c
index c691b3d81549..5da49a0ab70b 100644
--- a/drivers/media/platform/sti/delta/delta-v4l2.c
+++ b/drivers/media/platform/sti/delta/delta-v4l2.c
@@ -1862,7 +1862,7 @@ static int delta_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(delta->dev, "%s failed to initialize firmware ipc channel\n",
 			DELTA_PREFIX);
-		goto err;
+		goto err_pm_disable;
 	}
 
 	/* register all available decoders */
@@ -1876,7 +1876,7 @@ static int delta_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(delta->dev, "%s failed to register V4L2 device\n",
 			DELTA_PREFIX);
-		goto err;
+		goto err_pm_disable;
 	}
 
 	delta->work_queue = create_workqueue(DELTA_NAME);
@@ -1901,6 +1901,8 @@ static int delta_probe(struct platform_device *pdev)
 	destroy_workqueue(delta->work_queue);
 err_v4l2:
 	v4l2_device_unregister(&delta->v4l2_dev);
+err_pm_disable:
+	pm_runtime_disable(dev);
 err:
 	return ret;
 }
-- 
2.35.1



