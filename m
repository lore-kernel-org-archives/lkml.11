Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8B3C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 07:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351668AbiDLH2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 03:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351752AbiDLHMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:12:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E639217A8A;
        Mon, 11 Apr 2022 23:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3F5DB81B35;
        Tue, 12 Apr 2022 06:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92E2C385A1;
        Tue, 12 Apr 2022 06:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649746331;
        bh=HYUEX2kYwW/fwRXKxRfNw0x/SATn9LUwe4xOoGFsWFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MyDKZUn1nmqWJdJaxpEz82z2o3efnB4MDDHGiOyidbqLXL45/9m6uhLFEOJJ0KOHz
         3qPNLZCRlHRO9EeIoD/PAaEoRQo707OEte+ST0eh9zEyelj5hWaO7wuFTBC08xz6YF
         EKSiejii8WtMTHo9Rj8kavPmVOw/r5stSvv8pzK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Emily Deng <Emily.Deng@amd.com>,
        James Zhu <James.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 244/277] drm/amdgpu/vcn: Fix the register setting for vcn1
Date:   Tue, 12 Apr 2022 08:30:47 +0200
Message-Id: <20220412062949.104005239@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062942.022903016@linuxfoundation.org>
References: <20220412062942.022903016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emily Deng <Emily.Deng@amd.com>

commit 02fc996d5098f4c3f65bdf6cdb6b28e3f29ba789 upstream.

Correct the code error for setting register UVD_GFX10_ADDR_CONFIG.
Need to use inst_idx, or it only will set VCN0.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -601,8 +601,8 @@ static void vcn_v3_0_mc_resume_dpg_mode(
 			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
 
 	/* VCN global tiling registers */
-	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
-		UVD, 0, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
+		UVD, inst_idx, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
 static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)


