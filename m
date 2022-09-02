Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69225C38145
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 12:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbiIBM4l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 08:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbiIBMyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:54:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090F0D9D;
        Fri,  2 Sep 2022 05:38:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D3662181;
        Fri,  2 Sep 2022 12:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1D2C433C1;
        Fri,  2 Sep 2022 12:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662122300;
        bh=oMTC32BuVSAw4PAlLwY406UsI1M/nTgKc6MBfnXNkKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6D4h+GHTJSRFUCl27KJXT9YNm0G2k0ILu/vQ6c/Ut3zA06aMRBAZLx0hoBLP2Msk
         gp257EojnvXghi3R1mnpaOH5VlMQczQR47BPYcufoVB1BkrEAF7ExE/Qx3s8fcno0K
         Qqj14/gsl2qnHe3Ggu+LA59ZaaUmDd/gBEWpRXvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shane Xiao <shane.xiao@amd.com>,
        Aaron Liu <aaron.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.19 60/72] drm/amdgpu: Add secure display TA load for Renoir
Date:   Fri,  2 Sep 2022 14:19:36 +0200
Message-Id: <20220902121406.750858595@linuxfoundation.org>
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

From: Shane Xiao <shane.xiao@amd.com>

[ Upstream commit e42dfa66d59240afbdd8d4b47b87486db39504aa ]

Add secure display TA load for Renoir

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index a2588200ea580..0b2ac418e4ac4 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -101,6 +101,16 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
 		adev->psp.dtm_context.context.bin_desc.start_addr =
 			(uint8_t *)adev->psp.hdcp_context.context.bin_desc.start_addr +
 			le32_to_cpu(ta_hdr->dtm.offset_bytes);
+
+		if (adev->apu_flags & AMD_APU_IS_RENOIR) {
+			adev->psp.securedisplay_context.context.bin_desc.fw_version =
+				le32_to_cpu(ta_hdr->securedisplay.fw_version);
+			adev->psp.securedisplay_context.context.bin_desc.size_bytes =
+				le32_to_cpu(ta_hdr->securedisplay.size_bytes);
+			adev->psp.securedisplay_context.context.bin_desc.start_addr =
+				(uint8_t *)adev->psp.hdcp_context.context.bin_desc.start_addr +
+				le32_to_cpu(ta_hdr->securedisplay.offset_bytes);
+		}
 	}
 
 	return 0;
-- 
2.35.1



