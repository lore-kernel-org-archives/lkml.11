Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C3AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 10:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbiDEKsk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241662AbiDEIfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:35:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8935C11A3C;
        Tue,  5 Apr 2022 01:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA80EB81C19;
        Tue,  5 Apr 2022 08:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C2DC385A0;
        Tue,  5 Apr 2022 08:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147525;
        bh=4OvB7EdZuNT8kdmTDQ2yED1bKkQrmupQ5BoSD9gf6Ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmRMhthzdQsRoFDdrk/vrOinntDJezmi3PtBtp9TW6h6XCX076GFH9VlKNUg/E3+l
         vhurt3i58GhSqlcbaA9SOGzIYisrqpU2rWL/iYqBtxf977Nh+eUnxpJiKcrv2lmA3z
         KuDRFthmsEvq2Zdsf+ogtlp/Nv1OGQmMSnSt+SKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.16 0027/1017] drm/amdgpu: only check for _PR3 on dGPUs
Date:   Tue,  5 Apr 2022 09:15:40 +0200
Message-Id: <20220405070354.983759601@linuxfoundation.org>
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
@@ -2144,8 +2144,10 @@ static int amdgpu_device_ip_early_init(s
 	    !pci_is_thunderbolt_attached(to_pci_dev(dev->dev)))
 		adev->flags |= AMD_IS_PX;
 
-	parent = pci_upstream_bridge(adev->pdev);
-	adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
+	if (!(adev->flags & AMD_IS_APU)) {
+		parent = pci_upstream_bridge(adev->pdev);
+		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
+	}
 
 	amdgpu_amdkfd_device_probe(adev);
 


