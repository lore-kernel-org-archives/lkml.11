Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F86FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 07:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiDEHmA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 03:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiDEHlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:41:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442E04B855;
        Tue,  5 Apr 2022 00:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A715C615CD;
        Tue,  5 Apr 2022 07:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DE5C340EE;
        Tue,  5 Apr 2022 07:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649144364;
        bh=9LikLm7DZPRY/Ex4AnW+fnPisRJQyaAZowfEP71FjWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bE5a+dJxnahtxBoV0ZTmGbUsz0BRL/oo7SzmBJOtLAVen/0NLsEFUhJGkA1OQdFdf
         uUoH/FMkOz2zabOaf0Lx6PpGNsHlPPuY3eFR7BCU+cHEup7UAigOJ0ZI7bqh6AJ4aL
         ZhhydySxPMIr9YcutyZpi3S7NC0x6uWpfGk/8jGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.17 0009/1126] drm/amdgpu: only check for _PR3 on dGPUs
Date:   Tue,  5 Apr 2022 09:12:36 +0200
Message-Id: <20220405070407.809990929@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
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
@@ -2147,8 +2147,10 @@ static int amdgpu_device_ip_early_init(s
 	    !pci_is_thunderbolt_attached(to_pci_dev(dev->dev)))
 		adev->flags |= AMD_IS_PX;
 
-	parent = pci_upstream_bridge(adev->pdev);
-	adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
+	if (!(adev->flags & AMD_IS_APU)) {
+		parent = pci_upstream_bridge(adev->pdev);
+		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
+	}
 
 	amdgpu_amdkfd_device_probe(adev);
 


