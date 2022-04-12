Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC616C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 07:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiDLHiR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 03:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352431AbiDLHOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:14:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB82B25D;
        Mon, 11 Apr 2022 23:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91AB260B2E;
        Tue, 12 Apr 2022 06:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A275CC385A1;
        Tue, 12 Apr 2022 06:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649746486;
        bh=itrofdbs716ODIhnXjVEg+ypZaOmRWHXn91zuOKUFUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sCAGzdNFmhakSpJu0azNQFji2rvz08iOb/khsagOXrARuv34R/IyoM4b54FEPFuAU
         n06GREAK84WAiDVRBBN9uYUmvvGyCbbXutO0GIJX9fDGZ93EvvqzZYLTHyLb+3rFzr
         LkOVd8Fn545Q5mjtAdlV5CQ2B/G9++CHNsEhsK2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philip Yang <Philip.Yang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 022/285] drm/amdkfd: Dont take process mutex for svm ioctls
Date:   Tue, 12 Apr 2022 08:27:59 +0200
Message-Id: <20220412062944.319696634@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062943.670770901@linuxfoundation.org>
References: <20220412062943.670770901@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit ac7c48c0cce00d03b3c95fddcccb0a45257e33e3 ]

SVM ioctls take proper svms->lock to handle race conditions, don't need
take process mutex to serialize ioctls. This also fixes circular locking
warning:

WARNING: possible circular locking dependency detected

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&svms->deferred_list_work));
                                lock(&process->mutex);
                     lock((work_completion)(&svms->deferred_list_work));
   lock(&process->mutex);

   *** DEADLOCK ***

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 24ebd61395d8..3aaf10c778d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1840,13 +1840,9 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	if (!args->start_addr || !args->size)
 		return -EINVAL;
 
-	mutex_lock(&p->mutex);
-
 	r = svm_ioctl(p, args->op, args->start_addr, args->size, args->nattr,
 		      args->attrs);
 
-	mutex_unlock(&p->mutex);
-
 	return r;
 }
 #else
-- 
2.35.1



