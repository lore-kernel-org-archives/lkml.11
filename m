Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE62C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 10:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353572AbiBUKHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 05:07:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353939AbiBUJ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:58:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A8E483A4;
        Mon, 21 Feb 2022 01:27:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6377A60F8C;
        Mon, 21 Feb 2022 09:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BABC340E9;
        Mon, 21 Feb 2022 09:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645435636;
        bh=GN4rx9+/uSWbncndIG5kZ/xPlZ2HAEnyxXgODofDk6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9qMOkRZx5FO3m0tsVZ9RqpNpt/gYKVY3aFDuq8oFVhxSGkH9mp4jNgaJ2+PpH+v7
         ZBxxyeDZBfSyXFeDtxO+v4NWlGfKa/G/z+iuG2cE3KxgcmBU8N1pS+jz2oyCoys/bN
         fP3HWONCgvhOg5LDGVEQu7AJ1ZOVi+vyPex+yceU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Liu <aaron.liu@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 222/227] drm/amdgpu: add utcl2_harvest to gc 10.3.1
Date:   Mon, 21 Feb 2022 09:50:41 +0100
Message-Id: <20220221084942.183691096@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084934.836145070@linuxfoundation.org>
References: <20220221084934.836145070@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Liu <aaron.liu@amd.com>

[ Upstream commit a072312f43c33ea02ad88bff3375f650684a6f24 ]

Confirmed with hardware team, there is harvesting for gc 10.3.1.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index b4eddf6e98a6a..ff738e9725ee8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -543,7 +543,9 @@ static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_device *adev)
 		adev->gfx.config.max_sh_per_se *
 		adev->gfx.config.max_shader_engines);
 
-	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 3)) {
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(10, 3, 1):
+	case IP_VERSION(10, 3, 3):
 		/* Get SA disabled bitmap from eFuse setting */
 		efuse_setting = RREG32_SOC15(GC, 0, mmCC_GC_SA_UNIT_DISABLE);
 		efuse_setting &= CC_GC_SA_UNIT_DISABLE__SA_DISABLE_MASK;
@@ -566,6 +568,9 @@ static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_device *adev)
 		disabled_sa = tmp;
 
 		WREG32_SOC15(GC, 0, mmGCUTCL2_HARVEST_BYPASS_GROUPS_YELLOW_CARP, disabled_sa);
+		break;
+	default:
+		break;
 	}
 }
 
-- 
2.34.1



