Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC9DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352306AbiBUJx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:53:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352942AbiBUJsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:48:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A801110;
        Mon, 21 Feb 2022 01:21:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C2A260EDF;
        Mon, 21 Feb 2022 09:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733E0C340E9;
        Mon, 21 Feb 2022 09:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645435298;
        bh=C1qZQx6yYLwBXAFUSzZG7n6rehyKJ48+uXEVgcXmhBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+wzEDGtpKi4ZyPBR0+Pdw3IqbOp/2OKk0HBCjxVI88PmwIjDJFk2yHZOmS+qXaph
         amgy6SuU3tdFZWn2exxZQTSMieg6g2ILTUSmSUyrKqfaUCF5qodivg8irjL0Rig2+l
         bfloalcky9+5OAuEfBIoew7lofFI9M7rGc3XORAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rajib Mahapatra <rajib.mahapatra@amd.com>
Subject: [PATCH 5.16 082/227] drm/amdgpu: skipping SDMA hw_init and hw_fini for S0ix.
Date:   Mon, 21 Feb 2022 09:48:21 +0100
Message-Id: <20220221084937.599484558@linuxfoundation.org>
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

From: Rajib Mahapatra <rajib.mahapatra@amd.com>

commit f8f4e2a518347063179def4e64580b2d28233d03 upstream.

[Why]
SDMA ring buffer test failed if suspend is aborted during
S0i3 resume.

[How]
If suspend is aborted for some reason during S0i3 resume
cycle, it follows SDMA ring test failing and errors in amdgpu
resume. For RN/CZN/Picasso, SMU saves and restores SDMA
registers during S0ix cycle. So, skipping SDMA suspend and
resume from driver solves the issue. This time, the system
is able to resume gracefully even the suspend is aborted.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2057,6 +2057,10 @@ static int sdma_v4_0_suspend(void *handl
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/* SMU saves SDMA state for us */
+	if (adev->in_s0ix)
+		return 0;
+
 	return sdma_v4_0_hw_fini(adev);
 }
 
@@ -2064,6 +2068,10 @@ static int sdma_v4_0_resume(void *handle
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/* SMU restores SDMA state for us */
+	if (adev->in_s0ix)
+		return 0;
+
 	return sdma_v4_0_hw_init(adev);
 }
 


