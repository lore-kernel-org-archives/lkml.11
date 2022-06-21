Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBEDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 13:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351227AbiFUNNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350887AbiFUNNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:13:34 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A92C5585
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:13:28 -0700 (PDT)
X-QQ-mid: bizesmtp73t1655817049tyyeozl4
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 21:10:43 +0800 (CST)
X-QQ-SSF: 0100000000700050B000B00A0000000
X-QQ-FEAT: EHEARuS8QZiTHpJYUDEzFwrWd9czPiu7c3XFvsY7+sI3PyOSjbTnrJJit0iwL
        iTugaNOWJGRNor8dmChnlRslGSL6oFaCySOeb2ozrzRNAff+yP8+C29VTPH8vgVfsmZEEwI
        hrtz/EVarHA3uMuNfcJBYLnTDQLkr0eT0rh2veDifPe5aagLAtT9ETvh7aLzxgme+iDkX4N
        QjhjAN9O56j6V0De+JAStAfMQvlLpMfgcIjBJyzRnUAVqWhldroo+XMXpo8tO+yXQlmMNPn
        X4HPhMw2N+sJDBadDEtipjswL/bT9BbaHrcuZZ4/HJv+tRgelT2sVnNUyUDjYty5Nm7QwcL
        gv82qiwnyE4tSN21YOU+CRjtXUAWA==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, Felix.Kuehling@amd.com,
        JinhuiEric.Huang@amd.com, Philip.Yang@amd.com, qiang.yu@amd.com,
        nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] drm/amdgpu: vm - drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 21:10:41 +0800
Message-Id: <20220621131041.129513-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
line: 57
  * the kernel tells the the ring what VMID to use for that command
changed to
  * the kernel tells the ring what VMID to use for that command

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dc76d2b3ce52..8530befb2051 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -54,7 +54,7 @@
  * (uncached system pages).
  * Each VM has an ID associated with it and there is a page table
  * associated with each VMID.  When executing a command buffer,
- * the kernel tells the the ring what VMID to use for that command
+ * the kernel tells the ring what VMID to use for that command
  * buffer.  VMIDs are allocated dynamically as commands are submitted.
  * The userspace drivers maintain their own address space and the kernel
  * sets up their pages tables accordingly when they submit their
-- 
2.17.1

