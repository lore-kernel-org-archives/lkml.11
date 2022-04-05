Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AA8C35280
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385591AbiDEMdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbiDEJCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:02:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092E365A9;
        Tue,  5 Apr 2022 01:54:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1F39B81BD9;
        Tue,  5 Apr 2022 08:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE9FC385A1;
        Tue,  5 Apr 2022 08:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148846;
        bh=v4eLI41AdyjQ9o5HFb27oHRebt+0z8LfrZY/WbHi8qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKykuR0y6J9mdPyDZU4DgrFcrQ/1i4gVfAkGXBFovk1u0bcRtZOKHOUaYUGLBp3Iu
         LMdDV69aPJ1R50/Jnm7r11rltSxLabBTdftCRfFVR/oWf1g5U4sjBlBkmxrkEo5o1L
         UQj+CO6NuJhfCACX7kf7dETtxRYseqbcw0hyz1RM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yiqing Yao <yiqing.yao@amd.com>,
        Monk Liu <Monk.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0501/1017] drm/amd/pm: enable pm sysfs write for one VF mode
Date:   Tue,  5 Apr 2022 09:23:34 +0200
Message-Id: <20220405070409.170939495@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yiqing Yao <yiqing.yao@amd.com>

[ Upstream commit e610941c45bad75aa839af015c27d236ab6749e5 ]

[why]
pm sysfs should be writable in one VF mode as is in passthrough

[how]
do not remove write access on pm sysfs if device is in one VF mode

Fixes: 11c9cc95f818 ("amdgpu/pm: Make sysfs pm attributes as read-only for VFs")
Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
Reviewed-by: Monk Liu <Monk.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d31719b3418f..8744bda59474 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2123,8 +2123,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		}
 	}
 
-	/* setting should not be allowed from VF */
-	if (amdgpu_sriov_vf(adev)) {
+	/* setting should not be allowed from VF if not in one VF mode */
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
 		dev_attr->attr.mode &= ~S_IWUGO;
 		dev_attr->store = NULL;
 	}
-- 
2.34.1



