Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FD4C4167D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 20:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbiDEUYV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 16:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358255AbiDEK2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:28:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F477655;
        Tue,  5 Apr 2022 03:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E98FFB81CB3;
        Tue,  5 Apr 2022 10:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E829C385A0;
        Tue,  5 Apr 2022 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153844;
        bh=JbaZZu96NMk2NGaOOEFcIIrtri2HPW2g9NuKPNcasSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7tjd8IYoDVkB23uzjMp2gVnM101ksxUfFJcbBAR7yIKuuNVfCQbbzOzv8EV1k1xd
         jwG2A67fSX4UGABC6z26+HjE75BDKye3VZCcwDSEVNs93UTVQw3gopyWXrjaapMkGK
         hRcfBdrIfh/SbrWqZd6C0isP8N8e02cX7i7osnfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 329/599] gpu: host1x: Fix a memory leak in host1x_remove()
Date:   Tue,  5 Apr 2022 09:30:23 +0200
Message-Id: <20220405070308.623593005@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 025c6643a81564f066d8381b9e2f4603e0f8438f ]

Add a missing 'host1x_channel_list_free()' call in the remove function,
as already done in the error handling path of the probe function.

Fixes: 8474b02531c4 ("gpu: host1x: Refactor channel allocation code")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/host1x/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index a2c09dca4eef..8659558b518d 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -520,6 +520,7 @@ static int host1x_remove(struct platform_device *pdev)
 	host1x_syncpt_deinit(host);
 	reset_control_assert(host->rst);
 	clk_disable_unprepare(host->clk);
+	host1x_channel_list_free(&host->channel_list);
 	host1x_iommu_exit(host);
 
 	return 0;
-- 
2.34.1



