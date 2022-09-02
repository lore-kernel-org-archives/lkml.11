Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08842C54EE9
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 12:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbiIBMys (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 08:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbiIBMxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:53:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2688AF8F7C;
        Fri,  2 Sep 2022 05:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48EEDB82ADD;
        Fri,  2 Sep 2022 12:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99814C433D6;
        Fri,  2 Sep 2022 12:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662122204;
        bh=MpsjRacOxYFO0Y80lIecBuhnNRp1/Q76mn8eJIR1epI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dy5zOi8GRVPuPer19N5dc0NAnpogQVaR35T2w4OHD4LQxAuZIyuPQN1y0HAxNpqID
         jj7bkAwBJdq+MsJ4EEGh/D7gm14wwJ0n3g0Kw5OcmZXXEeDiYkCnc6wCeXnHWCPTm5
         ggzFbzjkzDJcitJEJEqFzA7ByakquKkCEu91Nml0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Zhen Ni <nizhen@uniontech.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.19 45/72] drm/amd/pm: Fix a potential gpu_metrics_table memory leak
Date:   Fri,  2 Sep 2022 14:19:21 +0200
Message-Id: <20220902121406.251815602@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902121404.772492078@linuxfoundation.org>
References: <20220902121404.772492078@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Ni <nizhen@uniontech.com>

[ Upstream commit 5afb76522a0af0513b6dc01f84128a73206b051b ]

Memory is allocated for gpu_metrics_table in
smu_v13_0_4_init_smc_tables(), but not freed in
smu_v13_0_4_fini_smc_tables(). This may cause memory leaks, fix it.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Zhen Ni <nizhen@uniontech.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 5a17b51aa0f9f..7df360c25d51e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -190,6 +190,9 @@ static int smu_v13_0_4_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->watermarks_table);
 	smu_table->watermarks_table = NULL;
 
+	kfree(smu_table->gpu_metrics_table);
+	smu_table->gpu_metrics_table = NULL;
+
 	return 0;
 }
 
-- 
2.35.1



