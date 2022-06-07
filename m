Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D909CCA492
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 22:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383874AbiFGWGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 18:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379898AbiFGVGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:06:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4452122A0;
        Tue,  7 Jun 2022 11:50:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8932AB823A0;
        Tue,  7 Jun 2022 18:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D9EC385A2;
        Tue,  7 Jun 2022 18:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654627816;
        bh=1rMP8kZatU4ASe70FEHQC3m9PZKnZRDIpdNd/40kEeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+9GNFkc4VvbjsD42sePFyIltijF4wdFZPi5CV1sg7sh8+txSRUk9kR/aVsL9IZPT
         ZrAyveAjbeSIKzmSELGyX0jaxAzSGAhGpPAvD4/rjum2NCZNhRJhyt/6wqQ+nfWYsK
         y9cIslDvWkrTo3RgiKdSYxNMd9NvfvLCeTJTOlMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 102/879] media: venus: hfi: avoid null dereference in deinit
Date:   Tue,  7 Jun 2022 18:53:40 +0200
Message-Id: <20220607165005.657321390@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607165002.659942637@linuxfoundation.org>
References: <20220607165002.659942637@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Weiss <luca.weiss@fairphone.com>

[ Upstream commit 86594f6af867b5165d2ba7b5a71fae3a5961e56c ]

If venus_probe fails at pm_runtime_put_sync the error handling first
calls hfi_destroy and afterwards hfi_core_deinit. As hfi_destroy sets
core->ops to NULL, hfi_core_deinit cannot call the core_deinit function
anymore.

Avoid this null pointer derefence by skipping the call when necessary.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/hfi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index 4e2151fb47f0..1968f09ad177 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -104,6 +104,9 @@ int hfi_core_deinit(struct venus_core *core, bool blocking)
 		mutex_lock(&core->lock);
 	}
 
+	if (!core->ops)
+		goto unlock;
+
 	ret = core->ops->core_deinit(core);
 
 	if (!ret)
-- 
2.35.1



