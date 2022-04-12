Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA64C4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 08:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379493AbiDLIUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355801AbiDLH3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:29:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF0D4F9EF;
        Tue, 12 Apr 2022 00:08:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 566B7616E3;
        Tue, 12 Apr 2022 07:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68861C385A1;
        Tue, 12 Apr 2022 07:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649747300;
        bh=Me+BbeK8TrKlngWFOxZmgxcvmrkuXu2Fd9tMqyMU6Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8x0AJugTPnB/HS95WhbGJO86qaRJx6ZNNFWlxj7wd1YOA4PLVXORmrCiUeTnwOQd
         iU8P3+CDaV8MYxWmopNYcvaJsWbY6yFGFjREG5/G8VUkDWmhhacJJ4z3yH51WbQf7y
         cAxvJo6lH7GGnt1D2wfFiUci1OYhmN+VOqX8yQJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philip Yang <Philip.Yang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 030/343] drm/amdkfd: Dont take process mutex for svm ioctls
Date:   Tue, 12 Apr 2022 08:27:28 +0200
Message-Id: <20220412062951.975802742@linuxfoundation.org>
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
index 337953af7c2f..70122978bdd0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1846,13 +1846,9 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
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



