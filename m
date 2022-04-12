Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350E2C35294
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 08:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385863AbiDLIxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359267AbiDLHmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:42:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E602CCAA;
        Tue, 12 Apr 2022 00:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE9C1B81B4F;
        Tue, 12 Apr 2022 07:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CE1C385A1;
        Tue, 12 Apr 2022 07:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649748088;
        bh=9VZAPCzEDAxExx6/TXtYqfHjelitcTwOZOGjOs8mLFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+MYuLagRtWZULzRG19K5+TuhDdI37FWVCsZVN7idANXflCy5ICIPwRw/D/yJzRbq
         Okynhx4iEuoBKpkcTjuPe6Sl6DJvxItbuRRVZb0AwR6/71dRy9ivPTAA4+q/jGLgsA
         ftYMEBJnCV8+kO338sJj7ZqZfdD0nCKdrZabVLFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.17 314/343] drm/amdkfd: Fix variable set but not used warning
Date:   Tue, 12 Apr 2022 08:32:12 +0200
Message-Id: <20220412063000.386044332@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062951.095765152@linuxfoundation.org>
References: <20220412062951.095765152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philip Yang <Philip.Yang@amd.com>

commit 90c44207cdd18091ac9aa7cab8a3e7b0ef00e847 upstream.

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c: In function
'svm_range_deferred_list_work':
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2067:22: warning:
variable 'p' set but not used [-Wunused-but-set-variable]
    2067 |  struct kfd_process *p;
         |

Fixes: 367c9b0f1b8750 ("drm/amdkfd: Ensure mm remain valid in svm deferred_list work")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-By: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2066,13 +2066,10 @@ static void svm_range_deferred_list_work
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct mm_struct *mm;
-	struct kfd_process *p;
 
 	svms = container_of(work, struct svm_range_list, deferred_list_work);
 	pr_debug("enter svms 0x%p\n", svms);
 
-	p = container_of(svms, struct kfd_process, svms);
-
 	spin_lock(&svms->deferred_list_lock);
 	while (!list_empty(&svms->deferred_range_list)) {
 		prange = list_first_entry(&svms->deferred_range_list,


