Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD70C4167B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 14:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354299AbiDEOO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 10:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbiDEJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:32:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50D32E5;
        Tue,  5 Apr 2022 02:19:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 712516144D;
        Tue,  5 Apr 2022 09:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A01BC385A3;
        Tue,  5 Apr 2022 09:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649150353;
        bh=80uFsQUPPQey6gmqzFrvrYIR2Wecj3/7tPqFrUDtep8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yjpxTMkxv0S0+ZxYeuchz1AZLZLyK9UmybrdHCISMMzGmubxQrsfQktw6X3bl6l4h
         gt2x0eWr+/URnyDAdaJrZvVg3of27RS1hO+SYmPfoxNJexZcHGHHs7oDkZjDWocsdj
         W+xoBu+4aMYYUX+WPsUOrrnLvai91aoAV2O1lnW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 027/913] drm/amdgpu: only check for _PR3 on dGPUs
Date:   Tue,  5 Apr 2022 09:18:09 +0200
Message-Id: <20220405070340.629555726@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 85ac2021fe3ace59cc0afd6edf005abad35625b0 upstream.

We don't support runtime pm on APUs.  They support more
dynamic power savings using clock and powergating.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2178,8 +2178,10 @@ static int amdgpu_device_ip_early_init(s
 	    !pci_is_thunderbolt_attached(to_pci_dev(dev->dev)))
 		adev->flags |= AMD_IS_PX;
 
-	parent = pci_upstream_bridge(adev->pdev);
-	adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
+	if (!(adev->flags & AMD_IS_APU)) {
+		parent = pci_upstream_bridge(adev->pdev);
+		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
+	}
 
 	amdgpu_amdkfd_device_probe(adev);
 


